library AntiInhibitorCoagulantDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Hereditary factor VIII deficiency": '2.16.840.1.113883.3.6037.1001.23.96.0'
valueset "Major bleeding episodes": '2.16.840.1.113883.3.6037.1001.23.96.1'
valueset "Hereditary factor IX deficiency": '2.16.840.1.113883.3.6037.1001.23.96.2'
valueset "Von Willebrand's disease": '2.16.840.1.113883.3.6037.1001.23.96.3'
valueset "Acquired hemophilia": '2.16.840.1.113883.3.6037.1001.23.96.4'
valueset "Other coagulation factor deficiencies": '2.16.840.1.113883.3.6037.1001.23.96.5'
valueset "Acquired Factor VIII autoantibodies": '2.16.840.1.113883.3.6037.1001.23.96.6'
valueset "Other hemorrhagic disorder due to intrinsic circulating anticoagulants, antibodies, or inhibitors": '2.16.840.1.113883.3.6037.1001.23.96.7'
valueset "Anti-inhibitor, per IU": '2.16.840.1.113883.3.6037.1001.23.96.8'
valueset "Antiphospholipid antibody with hemorrhagic disorder": '2.16.840.1.113883.3.6037.1001.23.96.9'
valueset "Other less expensive therapies": '2.16.840.1.113883.3.6037.1001.23.96.10'
valueset "Diagnostic Tests for hemophilia": '2.16.840.1.113883.3.6037.1001.23.96.11'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define "HemophiliaDiagnosis":
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Acquired hemophilia"

define "FactorVIIIDiagnosis":
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Hereditary factor VIII deficiency"

define "CoagulationFactorDiagnosis":
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Acquired Factor VIII autoantibodies"

define "HemorrhageDiagnosis":
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Major bleeding episodes"

define "MedicationAdministrationResources":
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and (First((M.medication as CodeableConcept).coding) in "Other less expensive therapies"
		or First([Medication]med
							where (M.medication as Reference).reference.value = 'Medication/'+med.id.value
							and (First(med.code.coding) in "Other less expensive therapies") is not null
				) is not null
			) is not null

define "MedicationResources":
	[Medication]med where (First(med.code.coding) in "Other less expensive therapies") is not null

define "ProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.outcome.coding) in "Procedure Unsuccessful"
		and First(P.code.coding) in "Procedure for Medication Administration"

define "OtherFailedTherapyResources":
	"MedicationAdministrationResources" M
	with "ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "DiagnosticTestResources":
	[DiagnosticReport]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Diagnostic Tests for hemophilia"

define "DiagnosesAssessment":
	if (Last("HemophiliaDiagnosis") is not null
		and Last("FactorVIIIDiagnosis") is not null
		and Last("CoagulationFactorDiagnosis") is not null
		and Last("HemorrhageDiagnosis").severity.coding[0].display.value='Severe')
	then true
	else false

define "OtherTherapiesAssessment":
	if (Last("OtherFailedTherapyResources") is not null)
	then true
	else false

define "DiagnosticTestsAssessment":
	if (Last("DiagnosticTestResources") is not null)
	then true
	else false

define "FinalDecision":
	if ("OtherTherapiesAssessment"=true)
		and ("DiagnosesAssessment"=true)
		and ("DiagnosticTestsAssessment"=true)
	then 'YES'
	else 'NO'
