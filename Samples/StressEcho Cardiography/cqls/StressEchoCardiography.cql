library StressEchocardiography version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include StressEchoCommon version '1.0.0' called StressEchoCommon


codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'


valueset "StressEchoCardiography Diagnosis List": '99.1'
valueset "StressEchoCardiography related Imaging Study": '99.9'
valueset "Arm Pain": '99.14'
valueset "Jaw Pain": '99.15'
valueset "Shortness of breath": '99.16'
valueset "Chest pain": '99.17'

parameter "ServiceRequest" ServiceRequest

define Patient:
		First([Patient]P
		where 'Patient/' + P.id.value = "ServiceRequest".subject.reference.value)

define ServiceEncounter:
	StressEchoCommon."ServiceEncounter"

define function "EncounterDiagnosis"(Encounter Encounter):
	Encounter.diagnosis D
	return First([Condition]C
				where C.id.value = "GetId"(D.condition.reference.value)
					and FHIRHelpers.ToInteger(D.rank) = 2)

define ServiceCondition:
	"EncounterDiagnosis"("ServiceEncounter")

define ServiceDiagnosis:
	First("ServiceCondition" S
			where First(S.code.coding) in "StressEchoCardiography Diagnosis List")

define RelevantDiagnosis:
	"ServiceDiagnosis".code.coding[0].display.value

define function "GetId"(uri String):
	Last(Split(uri, '/'))

define ServiceDiagnosticReport:
	First([Observation]D
	where D.subject.reference.value = 'Patient/'+ "Patient".id.value
		and StressEchoCommon."Normalize Interval Procedure"(D.effective) starts after (Today() -60 days))

define ImagingTest:
	"ServiceDiagnosticReport" R
		where First(R.code.coding) in "StressEchoCardiography related Imaging Study"

define PriorImagingTest:
	First("ImagingTest".code.coding).display.value

define DateOfImaging:
	start of StressEchoCommon."Normalize Interval Procedure"("ImagingTest".effective)

define ReasonCondition:
	StressEchoCommon."Evaluation"

define Reason:
	First("ReasonCondition".code.coding).display.value

define DateOfAssessment:
	start of StressEchoCommon."Normalize Onset"("ReasonCondition".onset)

define TreatmentPerformed:
 	First([Procedure]P
 	where P.subject.reference.value = 'Patient/'+ "Patient".id.value
 		and P.status.value = 'completed'
 		and StressEchoCommon."Normalize Interval Procedure"(P.performed) starts after (Today()-1 year))

define ProceduresPerformed:
	"TreatmentPerformed".code.coding[0].display.value

define TreatmentDate:
	start of StressEchoCommon."Normalize Interval Procedure"("TreatmentPerformed".performed)

define UnspecifiedChestPain:
	First([Condition]P
		where P.subject.reference.value = 'Patient/'+ "Patient".id.value
		and First(P.code.coding) in "Chest pain"
		and P.encounter.reference.value = 'Encounter/'+ "ServiceEncounter".id.value)

define ChestPain:
	if ("UnspecifiedChestPain" is not null)
	then true
	else false

define ChestPainDate:
	start of StressEchoCommon."Normalize Onset"("UnspecifiedChestPain".onset)

define ChestPainSeverity:
	First("UnspecifiedChestPain".severity.coding).display.value

define UnspecifiedArmPain:
	First([Condition]P
		where P.subject.reference.value = 'Patient/'+ "Patient".id.value
		and First(P.code.coding) in "Arm Pain"
		and P.encounter.reference.value = 'Encounter/'+ "ServiceEncounter".id.value)

define ArmPain:
	if ("UnspecifiedArmPain" is not null)
	then true
	else false

define ArmPainDate:
	start of StressEchoCommon."Normalize Onset"("UnspecifiedArmPain".onset)

define ArmPainSeverity:
	First("UnspecifiedArmPain".severity.coding).display.value

define UnspecifiedJawPain:
	First([Condition]P
		where P.subject.reference.value = 'Patient/'+ "Patient".id.value
		and First(P.code.coding) in "Jaw Pain"
		and P.encounter.reference.value = 'Encounter/'+ "ServiceEncounter".id.value)

define JawPain:
	if ("UnspecifiedJawPain" is not null)
	then true
	else false
define JawPainDate:
	start of StressEchoCommon."Normalize Onset"("UnspecifiedJawPain".onset)

define JawPainSeverity:
	First("UnspecifiedJawPain".severity.coding).display.value

define UnspecifiedShortnessOfBreath:
	First([Condition]P
		where P.subject.reference.value = 'Patient/'+ "Patient".id.value
		and First(P.code.coding) in "Shortness of breath"
		and P.encounter.reference.value = 'Encounter/'+ "ServiceEncounter".id.value)

define ShortnessOfBreath:
	if ("UnspecifiedShortnessOfBreath" is not null)
	then true
	else false

define ShortnessOfBreathDate:
	start of StressEchoCommon."Normalize Onset"("UnspecifiedShortnessOfBreath".onset)

define ShortnessOfBreathSeverity:
	First("UnspecifiedShortnessOfBreath".severity.coding).display.value

define Base:
	First(Patient.link).other

define level:
	[Patient]P
	where 'Patient/' + P.id.value = "Base".reference.value

define PatientHistory:
	StressEchoCommon."PatientHistory"

define ImagingHistory:
	StressEchoCommon."ImagingHistory"

define VitalSigns:
	StressEchoCommon."VitalSigns"

define ECG:
	StressEchoCommon."ECG"

define Diabetic:
	StressEchoCommon."Diabetic"

define HighSystolicPressure:
	StressEchoCommon."HighSystolicPressure"

define UninterpretableECG:
	StressEchoCommon."UninterpretableECG"

define ImagingConditions:
	StressEchoCommon."ImagingConditions"

define VentricularTachycardia:
	StressEchoCommon."VentricularTachycardia"

define ComputerTomography:
	StressEchoCommon."ComputerTomography"

define ETTPerformed:
	StressEchoCommon."ETTPerformed"

define PCICABGCodes:
	StressEchoCommon."PCICABGCodes"
