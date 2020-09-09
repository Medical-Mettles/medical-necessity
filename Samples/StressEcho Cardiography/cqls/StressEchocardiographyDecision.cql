library StressEchocardiographyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include StressEchoCommon version '1.0.0' called StressEchoCommon


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define PCICABGCodes:
	exists(StressEchoCommon."PCICABGCodes")

define ServiceEncounter:
	StressEchoCommon."ServiceEncounter"

define Evaluation:
	StressEchoCommon."Evaluation"

define PatientHistory:
	StressEchoCommon."PatientHistory"

define ImagingHistory:
	StressEchoCommon."ImagingHistory"

define VitalSigns:
	StressEchoCommon."VitalSigns"

define QT:
	"QuestionnaireResponse".item

define QA21:
	("QT".item I
		where I.linkId.value = '2.1')QR
		return First(QR.answer).value

define QA23:
	("QT".item I
		where I.linkId.value = '2.3')QR
		return First(QR.answer).value

define QA25:
	("QT".item I
		where I.linkId.value = '2.5')QR
		return First(QR.answer).value

define QA27:
	("QT".item I
		where I.linkId.value = '2.7')QR
		return First(QR.answer).value

define QA31:
	("QT".item I
		where I.linkId.value = '3.1')QR
		return First(QR.answer).value

define QA32:
	("QT".item I
		where I.linkId.value = '3.2')QR
		return First(QR.answer).value

define QA33:
	("QT".item I
		where I.linkId.value = '3.3')QR
		return First(QR.answer).value

define QA34:
	("QT".item I
		where I.linkId.value = '3.4')QR
		return First(QR.answer).value

define QA41:
	("QT".item I
		where I.linkId.value = '4.1')QR
		return First(QR.answer).value

define QA42:
	("QT".item I
		where I.linkId.value = '4.2')QR
		return First(QR.answer).value

define QA43:
	("QT".item I
		where I.linkId.value = '4.3')QR
		return First(QR.answer).value

define QA44:
	("QT".item I
		where I.linkId.value = '4.4')QR
		return First(QR.answer).value

define StepDecision:
	First("QA31").value

define TypicalAngina :
	if ((First("QA32").value = true )
		and (First("QA33").value = true)
		and (First("QA34").value = true))
	then true
	else false

define AtypicalAngina:
	if ((First("QA32").value = true )
		or (First("QA33").value = true)
		or (First("QA34").value = true))
	then true
	else false

define NonAnginalChestPain:
	if("TypicalAngina" = false)
	then true
	else false

define CADAssessment:
	if ("TypicalAngina" = true) then true
	else
	if (("AtypicalAngina" = true) and (Patient.gender.value = 'male')) then true
	else
	if ((AgeInYearsAt(Today())>39) and ("NonAnginalChestPain" = true) and (Patient.gender.value = 'male')) then true
	else
	if ((AgeInYearsAt(Today())>49) and ("AtypicalAngina" = true) and (Patient.gender.value = 'female')) then true
	else
	if ((AgeInYearsAt(Today())>59) and ("NonAnginalChestPain" = true) and (Patient.gender.value = 'female')) then true
	else false

define HighRiskCAD:
	if ((AgeInYearsAt(Today())>39) and ("TypicalAngina" = true) and (Patient.gender.value = 'male')) then true
	else
	if ((AgeInYearsAt(Today())>59) and ("TypicalAngina" = true) and (Patient.gender.value = 'female')) then true
	else false

define FunctionalCapacity:
	if ((First("QA41").value = true )
		and (First("QA42").value = true)
		and (First("QA43").value = true)
		and (First("QA44").value = true)
		)
	then true
	else false

define ECG:
	exists(StressEchoCommon."ECG")

define ExerciseTest:
	if(("FunctionalCapacity" = true) and ("ECG" = true))
	then true
	else false

define Diabetic:
	exists(StressEchoCommon."Diabetic")

define HighSystolicPressure:
	StressEchoCommon."HighSystolicPressure"

define UninterpretableECG:
	StressEchoCommon."UninterpretableECG"

define VentricularTachycardia:
	exists(StressEchoCommon."VentricularTachycardia")

define ComputerTomography:
	exists(StressEchoCommon."ComputerTomography")

define ETTPerformed:
	StressEchoCommon."ETTPerformed"

define SecondarySymptoms:
	if ((First("QA23") = true )
		or (First("QA25") = true)
		or (First("QA27") = true))
	then true
	else false

define Symptoms:
	if ((First("QA21") = true )
		and (First("QA23") = true)
		and (First("QA25") = true))
	then true
	else false

define ReviewSymptoms:
	if ((First("QA21") = true )
		and ("SecondarySymptoms" = true))
	then true
	else false

define FalseNegativeETT:
	if (( "ETTPerformed" = true) and ("Symptoms" = true))
	then true
	else false


define ImagingConditions:
	StressEchoCommon."ImagingConditions"

define ImagingGuidelines:
	if ("HighRiskCAD" = true)
		then true
	else
	if("PCICABGCodes" = true)
		then true
	else
	if ("VentricularTachycardia" = true )
		then true
	else
	if ((AgeInYearsAt(Today())>40) and ("Diabetic" = true))
		then true
	else
	if ("ComputerTomography" = true)
		then true
	else
	if ("HighSystolicPressure" = true)
		then true
	else
	if ("UninterpretableECG" = true)
		then true
	else
	if ("FalseNegativeETT" = true)
		then true
	else false

define NeedDataForStressImaging:
	if (("PCICABGCodes" = false)
		and ("VentricularTachycardia" = false)
		and ("Diabetic" = false)
		and ("ComputerTomography" = false)
		and ("HighSystolicPressure" = false)
		and ("UninterpretableECG" = false)
		and ("ETTPerformed" = false)
		and ("HighRiskCAD" = false)
		)
	then true
	else false

define ImagingIndications:
	if ("Symptoms" = true) and ("ImagingGuidelines" = true)
	then true
	else false


define PrimaryDecision:
	if (("Evaluation" is not null)
		and ("StepDecision" = false)
		and ("PatientHistory" = true)
		and ("CADAssessment" = true)
		and ("VitalSigns" is not null))
	then true
	else false

define ETTDecision:
	if (("PrimaryDecision" = true) and ("FunctionalCapacity" =true))
	then true
	else false

define ETTReason:
	if(("PrimaryDecision" = false) and ("FunctionalCapacity" = false))
	then 'Doesnt satisfy the clinical coverage requirements for the study'
	else if (("PrimaryDecision" = true) and ("FunctionalCapacity" = true))
	then 'The Functional Capacity of the Patient qualifies for a Exercise Treadmill Test'
	else if (("PrimaryDecision" = false) and ("FunctionalCapacity" = true))
	then 'Doesnt satisfy the clinical coverage requirements for the study and The Functional Capacity of the Patient qualifies for a Exercise Treadmill Test'
	else null

define ImagingDecision:
	if (("PrimaryDecision" = true) and ("FunctionalCapacity" = false) and ("ImagingIndications" = true))
	then true
	else false

define ImagingReason:
	if (("PrimaryDecision" = false) and ("FunctionalCapacity" = false) and ("ImagingIndications" = true))
	then 'Doesnt satisfy the clinical coverage requirements for the study'
	else if (("PrimaryDecision" = true) and ("FunctionalCapacity" = true) and ("ImagingIndications" = true))
	then 'The Functional Capacity of the Patient qualifies for a Exercise Treadmill Test'
	else if (("PrimaryDecision" = false) and ("FunctionalCapacity" = true) and ("ImagingIndications" = true))
	then 'Doesnt satisfy the clinical coverage requirements for the study and The Functional Capacity of the Patient qualifies for a Exercise Treadmill Test'
	else if (("PrimaryDecision" = false) and ("FunctionalCapacity" = false) and ("ImagingIndications" = false))
	then 'Doesnt satisfy the clinical coverage requirements for the study and Doesnt satisfy conditions required for StressEcho Imaging Study'
	else if (("PrimaryDecision" = true) and ("FunctionalCapacity" = false) and ("ImagingIndications" = false))
	then 'Doesnt satisfy conditions required for StressEcho Imaging Study'
	else if (("PrimaryDecision" = true) and ("FunctionalCapacity" = true) and ("ImagingIndications" = false))
	then 'The Functional Capacity of the Patient qualifies for a Exercise Treadmill Test and Doesnt satisfy conditions required for StressEcho Imaging Study'
	else null

define NeedsDataForAssessment:
	if ("Evaluation" is null)
	then true
	else false

define NeedsDataOfVitalSigns:
	if("VitalSigns" is null)
	then true else false

define NeedsDataReview:
	if (("Evaluation" is null)
		or ("PatientHistory" = false)
		or ("VitalSigns" is null)
		or ("NeedDataForStressImaging" = true)
		)
	then true
	else false

define ReviewDecision:
	if (("NeedsDataReview" = true)
		and ("StepDecision" = false)
		and ("CADAssessment" = true)
		and ("FunctionalCapacity" = false)
		and ("ReviewSymptoms" = true)
		)
	then true
	else false

define ReviewReason:
	if( "NeedsDataReview" = true)
	then 'Required Data missing in the submitted Claim'
	else  null


define FinalDecision:
	if ("ImagingDecision" = true)
	then 'YES'
	else
	if ("ReviewDecision" = true)
	then 'REVIEW NEEDED'
	else 'NO'

define FinalReason:
	if (("ImagingDecision" = false) and ("ReviewDecision" = false))
	then "ImagingReason"
	else
	if (("ReviewDecision" = true) and ("ImagingDecision" = false))
	then "ReviewReason"
	else null
