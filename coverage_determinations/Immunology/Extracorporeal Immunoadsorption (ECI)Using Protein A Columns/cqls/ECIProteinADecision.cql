library ECIProteinADecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

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

define QT:
	"QuestionnaireResponse".item

define QA15:
	("QT".item I
		where I.linkId.value = '1.5')QR
		return First(QR.answer).value

define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

define ITResource:
	([Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Idiopathic thrombocytopenic purpura"))

define RAResource:
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Rheumatoid Arthritis")

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

define "DiagnosesAssessment":
	if (exists("ITResource")
			and exists("RAResource"R where First(R.severity.coding).display.value = 'Severe'))
	then true
	else false

define "JointsAssessment":
	if (Length("SwollenJointsResource") >5
			and Length("TenderJointsResource") >20
			and Last("MorningStiffnessResource") is not null
			and First("QA15") > 60)
	then true
	else false

define "FailedDMARDsAssessment":
	if (Length("FailedDMARDsResources") >=3
			and First("QA22") = false)
	then true
	else false

define "FinalDecision":
	if ("DiagnosesAssessment"=true)
		and ("JointsAssessment"=true)
		and ("FailedDMARDsAssessment"=true)
	then 'YES'
	else 'NO'