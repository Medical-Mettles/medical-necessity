library BotulinumEccrine version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

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

valueset "BotulinumToxin Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.26'
valueset "Sialorrhea Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.27'
valueset "Esophagoscopy Codes": '2.16.840.1.113883.3.6037.1001.23.99.28'
valueset "AnalFissure Codes": '2.16.840.1.113883.3.6037.1001.23.99.29'
valueset "Cystourethroscopy Codes": '2.16.840.1.113883.3.6037.1001.23.99.30'
valueset "Blepharospasm Codes": '2.16.840.1.113883.3.6037.1001.23.99.31'
valueset "CervicalDystonia Codes": '2.16.840.1.113883.3.6037.1001.23.99.32'
valueset "ChemodenervationOfOneExtremity Codes": '2.16.840.1.113883.3.6037.1001.23.99.33'
valueset "Hyperhidrosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.34'
valueset "ExtraOcularMuscle Codes": '2.16.840.1.113883.3.6037.1001.23.99.35'
valueset "ChemodenervationOfNeckMuscle Codes": '2.16.840.1.113883.3.6037.1001.23.99.36'
valueset "MigraineWithoutAura Codes": '2.16.840.1.113883.3.6037.1001.23.99.48'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'

parameter "ServiceRequest" ServiceRequest

context Patient

define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)
	
define QualifiedConditions:
	First([Condition]C
		where exists(C.code.coding C where C in "BotulinumToxin Diagnosis Codes")
			and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Esophagoscopy:
	First([Condition]C
		where exists(C.code.coding C where C in "Esophagoscopy Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Sialorrhea:
	First([Condition]C
		where exists(C.code.coding C where C in "Sialorrhea Diagnosis Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define AnalFissure:
	First([Condition]C
		where exists(C.code.coding C where C in "AnalFissure Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Cystourethroscopy:
	First([Condition]C
		where exists(C.code.coding C where C in "Cystourethroscopy Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Blepharospasm:
	First([Condition]C
		where exists(C.code.coding C where C in "Blepharospasm Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define CervicalDystonia:
	First([Condition]C
		where exists(C.code.coding C where C in "CervicalDystonia Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define ChemodenervationOfOneExtremity:
	First([Condition]C
		where exists(C.code.coding C where C in "ChemodenervationOfOneExtremity Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Hyperhidrosis:
	First([Condition]C
		where exists(C.code.coding C where C in "Hyperhidrosis Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define ExtraOcularMuscle:
	First([Condition]C
		where exists(C.code.coding C where C in "ExtraOcularMuscle Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define ChemodenervationOfNeckMuscle:
	First([Condition]C
		where exists(C.code.coding C where C in "ChemodenervationOfNeckMuscle Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define MigraineWithoutAura:
	First([Condition]C
		where exists(C.code.coding C where C in "MigraineWithoutAura Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Headaches:
	exists([Condition]C
		where exists(C.code.coding C where C in "ChemodenervationOfNeckMuscle Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Preclusion:
	FHIRHelpers.ToQuantity("ServiceRequest".quantity as Quantity).value

define RelevantDiagnosis:
	First("QualifiedConditions".code.coding).display.value

define ProcedurePerformed:
	First([Procedure]P
	 	where P.status.value = 'completed')

define TreatmentPerformed:
	if (IsNull("ProcedurePerformed".performed) = false)
	 	then 
		 ( "ProcedurePerformed" P
			where ToDate(start of "Normalize Interval"(P.performed)) after (Today()-1 year)
			and First(P.outcome.coding) in "Unsuccessful")
		else null
		
define IsTreatmentPerformed:
	if ("TreatmentPerformed" is not null)
	then true
	else false

define TreatmentFailed:
		First("TreatmentPerformed".code.coding).display.value

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
	if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null
