library BotulinumToxin version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BotulinumToxinDecision version '1.0.0' called BTCommon

//include otherLibrary version 'x.x' called otherLibrary
//codesystem codeSystemName : 'OID' version 'x.x'
//valueset valuesetName : 'OID' version 'x.x' codesystems{codeSystem1 , codeSystem2, etc}
//code codeName : 'OID' from codeSystemName display 'displayName'
//concept conceptName : {codeName1, codeName2, etc} display 'displayName'
//parameter parameterName (dataType or default value)

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define ServiceEncounter:
	BTCommon."ServiceEncounter"

define QualifiedConditions:
	BTCommon."QualifiedConditions"

define Esophagoscopy:
	BTCommon."Esophagoscopy"

define Sialorrhea:
	BTCommon."Sialorrhea"

define AnalFissure:
	BTCommon."AnalFissure"

define Cystourethroscopy:
	BTCommon."Cystourethroscopy"

define Blepharospasm:
	BTCommon."Blepharospasm"

define CervicalDystonia:
	BTCommon."CervicalDystonia"

define ChemodenervationOfOneExtremity:
	BTCommon."ChemodenervationOfOneExtremity"

define Hyperhidrosis:
	BTCommon."Hyperhidrosis"
	
define ExtraOcularMuscle:
	BTCommon."ExtraOcularMuscle"

define ChemodenervationOfNeckMuscle:
	BTCommon."ChemodenervationOfNeckMuscle"

define MigraineWithoutAura:
	BTCommon."MigraineWithoutAura"

define Headaches:
	BTCommon."Headaches"

define Preclusion:
	FHIRHelpers.ToQuantity("ServiceRequest".quantity as Quantity).value


define RelevantDiagnosis:
	First("QualifiedConditions".code.coding).display.value

define TreatmentPerformed:
	 	First([Procedure]P
	 	where P.subject.reference.value = 'Patient/'+ "Patient".id.value
	 		and P.status.value = 'completed'
	 		and "Normalize Interval Procedure"(P.performed) starts after (Today()-1 year))

define IsTreatmentPerformed:
	if ("TreatmentPerformed" is not null)
	then true
	else false

define TreatmentFailed:
		First("TreatmentPerformed".code.coding).display.value

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