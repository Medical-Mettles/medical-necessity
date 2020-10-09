library ECIProteinA version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ECIProteinADecision version '1.0.0' called ECIProteinADecision

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Rheumatoid Arthritis": '2.16.840.1.113883.3.6037.1001.23.97.21'
valueset "Idiopathic thrombocytopenic purpura": '2.16.840.1.113883.3.6037.1001.23.97.22'
valueset "Swollen joints": '2.16.840.1.113883.3.6037.1001.23.97.23'
valueset "Tender joints": '2.16.840.1.113883.3.6037.1001.23.97.24'
valueset "Morning Stiffness": '2.16.840.1.113883.3.6037.1001.23.97.25'
valueset "Disease Modifying Anti-Rheumatic Drugs": '2.16.840.1.113883.3.6037.1001.23.97.26'
valueset "Extracorporeal Immunoadsorption (ECI)Using Protein A Columns": '2.16.840.1.113883.3.6037.1001.23.97.27'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "ITResource":
	ECIProteinADecision."ITResource"

define "RAResource":
	ECIProteinADecision."RAResource"

define "PrimaryDiagnoses":
	("RAResource" union "ITResource")P
	return (First(P.code.coding).display.value)+'\n'

define "SwollenJoints":
	ECIProteinADecision."SwollenJointsResource" P
	return First(P.code.coding).display.value+'\n'

define "TenderJoints":
	ECIProteinADecision."TenderJointsResource" P
	return First(P.code.coding).display.value+'\n'

define "MorningStiffness":
	ECIProteinADecision."MorningStiffnessResource" P
	return First(P.code.coding).display.value+'\n'

define "FailedDMARDsResources":
	ECIProteinADecision."MedicationAdministrationResources" M
	with ECIProteinADecision."ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "FailedDMARDs":
	"FailedDMARDsResources" P
	return (if (P.medication as CodeableConcept) is not null
					then ((P.medication as CodeableConcept).coding[0].display.value+'\n')
					else (First([Medication]med
							where (P.medication as Reference).reference.value = 'Medication/'+med.id.value).code.coding[0].display.value+'\n')
				)