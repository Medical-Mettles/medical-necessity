library DiagnosticEES version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Cardiac arrhythmia": '2.16.840.1.113883.3.6037.1001.23.97.19'
valueset "Diagnostic Endocardial Electrical Stimulation (Pacing)":'2.16.840.1.113883.3.6037.1001.23.97.20'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "PrimaryDiagnoses":
	First([Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
    and First(P.severity.coding).display.value = 'Severe'
		and First(P.code.coding) in "Cardiac arrhythmia").code.coding[0].display.value