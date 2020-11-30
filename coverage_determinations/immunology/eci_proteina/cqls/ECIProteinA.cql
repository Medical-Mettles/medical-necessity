library ECIProteinA version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Rheumatoid Arthritis": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.21'
valueset "Idiopathic thrombocytopenic purpura": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.22'
valueset "Swollen joints": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.23'
valueset "Tender joints": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.24'
valueset "Morning Stiffness": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.25'
valueset "Disease Modifying Anti-Rheumatic Drugs": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.26'
valueset "Extracorporeal Immunoadsorption (ECI)Using Protein A Columns": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.27'
valueset "Procedure Unsuccessful": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Procedure for Medication Administration": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "ITResource":
	([Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Idiopathic thrombocytopenic purpura"))

define "RAResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Rheumatoid Arthritis")

define "PrimaryDiagnoses":
	("RAResource" union "ITResource")P
	return (First(P.code.coding).display.value)+'\n'

define SwollenJointsResource:
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Swollen joints")

define TenderJointsResource:
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Tender joints")

define MorningStiffnessResource:
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Morning Stiffness")

define "SwollenJoints":
	"SwollenJointsResource" P
	return First(P.code.coding).display.value+'\n'

define "TenderJoints":
	"TenderJointsResource" P
	return First(P.code.coding).display.value+'\n'

define "MorningStiffness":
	"MorningStiffnessResource" P
	return First(P.code.coding).display.value+'\n'

define "MedicationAdministrationResources":
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and (First(((M.medication as CodeableConcept).coding) P where P in "Disease Modifying Anti-Rheumatic Drugs") is not null
		or First([Medication]med
							where (M.medication as Reference).reference.value = 'Medication/'+med.id.value
							and ((med.code.coding)C where C in "Disease Modifying Anti-Rheumatic Drugs") is not null
				) is not null
			) is not null

define "ProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.outcome.coding) in "Procedure Unsuccessful"
		and exists(P.code.coding C where C in "Procedure for Medication Administration")

define "FailedDMARDsResources":
	"MedicationAdministrationResources" M
	with "ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "FailedDMARDs":
	"FailedDMARDsResources" P
	return (if (P.medication as CodeableConcept) is not null
					then ((P.medication as CodeableConcept).coding[0].display.value+'\n')
					else (First([Medication]med
							where (P.medication as Reference).reference.value = 'Medication/'+med.id.value).code.coding[0].display.value+'\n')
				)