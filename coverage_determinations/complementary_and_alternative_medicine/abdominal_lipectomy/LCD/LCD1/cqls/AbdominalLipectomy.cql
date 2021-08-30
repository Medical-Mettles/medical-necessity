library AbdominalLipectomy version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'


valueset "Localized adiposity": '2.16.840.1.113883.3.6037.1001.23.93.125'
valueset "Skin Conditions causing Panniculus": '2.16.840.1.113883.3.6037.1001.23.93.126'
valueset "Panniculitis Conditions": '2.16.840.1.113883.3.6037.1001.23.93.127'
valueset "Erythema Intertrigo": '2.16.840.1.113883.3.6037.1001.23.93.128'
valueset "Functional Deficit Causing Panniculus": '2.16.840.1.113883.3.6037.1001.23.93.129'
valueset "Panniculectomy": '2.16.840.1.113883.3.6037.1001.23.99.80'
valueset "Significant Weight Loss": '2.16.840.1.113883.3.6037.1001.23.93.130'
valueset "Bariatric Surgery": '2.16.840.1.113883.3.6037.1001.23.93.131'
valueset "Debridement Procedure": '2.16.840.1.113883.3.6037.1001.23.93.132'
valueset "Topical Application Procedure": '2.16.840.1.113883.3.6037.1001.23.93.133'
valueset "Steroids Procedure": '2.16.840.1.113883.3.6037.1001.23.93.134'
valueset "Antibiotic Medical Therapy": '2.16.840.1.113883.3.6037.1001.23.93.111'
valueset "Antifungal Medicines": '2.16.840.1.113883.3.6037.1001.23.93.135'
valueset "Panniculus Corticosteroids": '2.16.840.1.113883.3.6037.1001.23.93.136'
valueset "Antifungal Medical Therapy Procedure": '2.16.840.1.113883.3.6037.1001.23.93.137'
valueset "Antibiotics Oral and Injectables": '2.16.840.1.113762.1.4.1106.75'
valueset "Ventral Hernia": '2.16.840.1.113883.3.6037.1001.23.93.138'
valueset "Abdomen and Pelvis CT": '2.16.840.1.113883.3.6037.1001.23.93.139'
valueset "Abdomen and Pelvis MRI": '2.16.840.1.113883.3.6037.1001.23.93.140'
valueset "Symphysis Pubis Body Site": '2.16.840.1.113883.3.6037.1001.23.93.141'
valueset "Active Tobacco Usage": '2.16.840.1.113883.3.6037.1001.23.93.142'
valueset "Diabetes Mellitus": '2.16.840.1.113883.3.3157.1329'
valueset "Diabetes Mellitus Screening and Laboratory Tests": '2.16.840.1.113762.1.4.1221.122'
valueset "Nutritional Deficiency": '2.16.840.1.113883.3.6037.1001.23.93.143'
valueset "GERD Condition": '2.16.840.1.113883.3.6037.1001.23.93.144'
valueset "Body weight": '2.16.840.1.113762.1.4.1045.159'
valueset "Successful": '2.16.840.1.113883.3.6037.1001.23.93.48'
valueset "Partially successful": '2.16.840.1.113883.3.6037.1001.23.93.47'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define GradeTwoPanniculusCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Localized adiposity")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and exists(C.bodySite.coding co where co in "Symphysis Pubis Body Site")

define RecurrentSkinConditions:
	[Condition]C
    where exists(C.code.coding C where C in "Skin Conditions causing Panniculus")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define CellulitisOrPanniculitisCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Panniculitis Conditions")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define IntertiginousDermititisCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Erythema Intertrigo")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define FunctionalDeficitCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Functional Deficit Causing Panniculus")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define SurgeryPurpose:
	if exists("GradeTwoPanniculusCondition")
				and (exists("RecurrentSkinConditions")
							or exists("CellulitisOrPanniculitisCondition")
							or exists("IntertiginousDermititisCondition")
							or exists("FunctionalDeficitCondition"))
					then 'Reconstructive'
						else 'Cosmetic'

define ValidPatientAge:
	AgeInYearsAt(Today())>18

define PatientAgeAboveEighteen:
	if ("ValidPatientAge" = true)
					then true
						else false

define GradeTwoPanniculusHangs:
	exists("GradeTwoPanniculusCondition")

define SkinConditionsCausingPanniculus:
	exists("RecurrentSkinConditions")

define CellulitisOrPanniculitis:
	exists("CellulitisOrPanniculitisCondition")

define IntertriginousDermatitis:
	exists("IntertiginousDermititisCondition")

define FunctionalDeficit:
	exists("FunctionalDeficitCondition")

define SignificantWeightLossCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Significant Weight Loss")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define SignificantWeightLoss:
	exists("SignificantWeightLossCondition")

define BariatricSurgeryProcedure:
	[Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Bariatric Surgery")

define BariatricSurgery:
	exists("BariatricSurgeryProcedure"P
  where First(P.complication C where First(C.coding co where co in "Significant Weight Loss") is not null) is not null
    or First(P.complicationDetail D
              with "SignificantWeightLossCondition" S
              such that D.reference.value = 'Condition/'+S.id.value) is not null)

define BodyWeight:
	First(([Observation]P
				where P.status.value in {'final', 'amended', 'corrected'}
					and exists(P.code.coding x where x in "Body weight")) O
				with "BariatricSurgeryProcedure" P
					such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
						where "Normalize Interval Procedure"(O.effective) starts before (Today()-180 days)
			sort by end of "Normalize Interval"(effective))

define BodyWeightResult:
	if FHIRHelpers.ToQuantity("BodyWeight".value).unit = 'kg'
	then FHIRHelpers.ToQuantity("BodyWeight".value).value
  else 0

define WeightToday:
	Last(([Observation]P
				where P.status.value in {'final', 'amended', 'corrected'}
					and exists(P.code.coding x where x in "Body weight")) O
				with "BodyWeight" B
					such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(B.effective)
						where "Normalize Interval Procedure"(O.effective) starts before (Today()-2 days))

//define SignificantWeightChange:
//	[Observation]P
//				where P.status.value in {'final', 'amended', 'corrected'}
//					and exists(P.code.coding x where x in "Body weight")
//						and First(O.interpretation.coding).code.value in {'A','AA','HH','LL','H','HU'}

define WeightTodayResult:
	if FHIRHelpers.ToQuantity("WeightToday".value).unit = 'kg'
	then FHIRHelpers.ToQuantity("WeightToday".value).value
  else 0

define StableWeightForSixMonths:
	if "BodyWeightResult" = "WeightTodayResult"
		then true
			else false

define AboveEighteenMonthsPostSurgery:
	exists("BariatricSurgeryProcedure" P
        	where "Normalize Interval Procedure"(P.performed) starts before (Today()-540 days))

define Debridement:
	exists([Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Debridement Procedure"))

define AntibioticsMedicationAdministration:
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Antibiotics Oral and Injectables"

define AntibioticsProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and (First(P.code.coding) in "Antibiotic Medical Therapy"
						or First(P.code.coding) in "Topical Application Procedure")

define CheckAntibioticsAdministration:
	"AntibioticsMedicationAdministration" M
		with "AntibioticsProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define AntibioticMedicalTherapy:
  if Last("CheckAntibioticsAdministration") is not null
		then true
			else false

define AntibioticTherapyForTwelveWeeks:
	exists("AntibioticsMedicationAdministration" M
		with "AntibioticsProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
				and "LengthInDays"("Normalize Interval Procedure"(P.performed)) > 84 days)

define PostAntibioticsSuccessfulOutcome:
	if exists("AntibioticsMedicationAdministration" M
							with "AntibioticsProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful"))
					then true
						else false

define PostAntibioticsUnsuccessfulOutcome:
	if exists("AntibioticsMedicationAdministration" M
							with "AntibioticsProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then true
						else false

define PostAntibioticMedicalTherapy:
	if ("PostAntibioticsSuccessfulOutcome" = true)
		then true
			else if ("PostAntibioticsUnsuccessfulOutcome" = true)
				then false
					else null

define AntifungalsMedicationAdministration:
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Antifungal Medicines"

define AntifungalsProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and (First(P.code.coding) in "Antifungal Medical Therapy Procedure"
					or First(P.code.coding) in "Topical Application Procedure")

define CheckAntifungalsAdministration:
	"AntifungalsMedicationAdministration" M
		with "AntifungalsProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define AntifungalMedicalTherapy:
  if Last("CheckAntifungalsAdministration") is not null
		then true
			else false

define AntifungalTherapyForTwelveWeeks:
	exists("AntifungalsMedicationAdministration" M
		with "AntifungalsProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
				and "LengthInDays"("Normalize Interval Procedure"(P.performed)) > 84 days)

define PostAntifungalsSuccessfulOutcome:
	if exists("AntifungalsMedicationAdministration" M
							with "AntifungalsProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful"))
					then true
						else false

define PostAntifungalsUnsuccessfulOutcome:
	if exists("AntifungalsMedicationAdministration" M
							with "AntifungalsProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then true
						else false

define PostAntifungalsMedicalTherapy:
	if ("PostAntifungalsSuccessfulOutcome" = true)
		then true
			else if ("PostAntifungalsUnsuccessfulOutcome" = true)
				then false
					else null

define CorticosteroidsMedicationAdministration:
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Panniculus Corticosteroids"

define CorticosteroidsProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and (First(P.code.coding) in "Steroids Procedure"
					or First(P.code.coding) in "Topical Application Procedure")

define CheckCorticosteroidsAdministration:
	"CorticosteroidsMedicationAdministration" M
		with "CorticosteroidsProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define CorticosteroidsMedicalTherapy:
  if Last("CheckCorticosteroidsAdministration") is not null
		then true
			else false

define CorticosteroidsTherapyForTwelveWeeks:
	exists("CorticosteroidsMedicationAdministration" M
		with "CorticosteroidsProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
				and "LengthInDays"("Normalize Interval Procedure"(P.performed)) > 84 days)

define PostCorticosteroidsSuccessfulOutcome:
	if exists("CorticosteroidsMedicationAdministration" M
							with "CorticosteroidsProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful"))
					then true
						else false

define PostCorticosteroidsUnsuccessfulOutcome:
	if exists("CorticosteroidsMedicationAdministration" M
							with "CorticosteroidsProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then true
						else false

define PostCorticosteroidsMedicalTherapy:
	if ("PostCorticosteroidsSuccessfulOutcome" = true)
		then true
			else if ("PostCorticosteroidsUnsuccessfulOutcome" = true)
				then false
					else null

define ConservativeMedicalTherapy:
	if ("AntibioticMedicalTherapy" = true
				or "AntifungalMedicalTherapy" = true
					or "CorticosteroidsMedicalTherapy" = true)
						then true
							else false

define ConservativeTherapyForTwelveWeeks:
	if ("AntibioticTherapyForTwelveWeeks" = true
				or "AntifungalTherapyForTwelveWeeks" = true
					or "CorticosteroidsTherapyForTwelveWeeks" = true)
						then true
							else false

define PostConservativeTherapyImprovement:
	if ("PostAntibioticMedicalTherapy" = true
				or "PostAntifungalsMedicalTherapy" = true
					or "PostCorticosteroidsMedicalTherapy" = true)
						then true
							else false

define VentralHerniaCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Ventral Hernia")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define VentralHernia:
	exists("VentralHerniaCondition")

define VentralHerniaScreening:
	exists([Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and (First(P.code.coding) in "Steroids Procedure"
					or First(P.code.coding) in "Abdomen and Pelvis CT"
						or First(P.code.coding) in "Abdomen and Pelvis MRI"))
		//and Last(P.category C where exists(C.coding x where x.code.value = 'Diagnostic procedure')))

define IncisionalHerniaRepair:
	exists("VentralHerniaCondition")

define Smoking:
	exists([Condition]C
    where exists(C.code.coding C where C in "Active Tobacco Usage")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define DiabetesMellitus:
	exists([Condition]C
    where exists(C.code.coding C where C in "Diabetes Mellitus")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define DiabetesTests:
	Last([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Diabetes Mellitus Screening and Laboratory Tests"))

define DiabetesResult:
	if FHIRHelpers.ToQuantity("DiabetesTests".value).unit = 'mg/dl'
	then FHIRHelpers.ToQuantity("DiabetesTests".value).value
  else 0

define DiabetesUnderControl:
	if "DiabetesResult" < 180
			then true
				else false

define NutritionalDeficiency:
	exists([Condition]C
    where exists(C.code.coding C where C in "Nutritional Deficiency")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define GERDCondition:
	exists([Condition]C
    where exists(C.code.coding C where C in "GERD Condition")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define function "Normalize Onset"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else if onset is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).high) + 1 year)
	else null

define function "Normalize Interval Procedure"(choice Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
		else if choice is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	  else if choice is FHIR.Age then
	 	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age),
 		FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age) + 1 year)
		else if choice is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).high) + 1 year)
	  else null

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null

define function "LengthInDays"(Value Interval<DateTime>):
	difference in days between start of Value and end of Value