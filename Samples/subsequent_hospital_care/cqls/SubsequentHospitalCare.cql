library SubsequentHospitalCare version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "Chest Pain": '2.16.840.1.113883.3.6037.1001.23.93.246'
valueset "Pain in Arm, Neck, Back or Jaw": '2.16.840.1.113883.3.6037.1001.23.93.247'
valueset "ST elevation myocardial infarction (STEMI)": '2.16.840.1.113883.3.6037.1001.23.93.248'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define "EncounterResource":
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define "EncounterPatient":
	"EncounterResource"

define Patient:
	Last([Patient]P with "EncounterResource" E
    		such that ('Patient/' + P.id.value) = E.subject.reference.value)

define PatientMedicaidNumber:
	First("Patient".identifier identifier
    		  where identifier.system.value = 'http://qualitrac.com/MD/medicaid-number').value.value

define DiscomformInChest:
	[Condition]C
		where exists(C.code.coding C where C in "Chest Pain")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define PainOtherAreas:
	[Condition]C
		where exists(C.code.coding C where C in "Pain in Arm, Neck, Back or Jaw")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define Symptoms:
	if exists("DiscomformInChest")
		then 'Pain/Discomfort in the chest'
			else if exists("PainOtherAreas")
				then 'Pain in Neck, Back, Arm or Jaw'
					else ''

define STEMICondition:
	[Condition]C
		where exists(C.code.coding C where C in "ST elevation myocardial infarction (STEMI)")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define ClinicalIndications:
	if exists("STEMICondition")
		then 'Elevated Cardiac Troponin Level'
			else ''
