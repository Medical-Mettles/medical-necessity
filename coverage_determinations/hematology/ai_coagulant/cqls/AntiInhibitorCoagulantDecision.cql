library AntiInhibitorCoagulantDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include AntiInhibitorCoagulant version '1.0.0' called AICC

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Hereditary factor VIII deficiency": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.0'
valueset "Major bleeding episodes": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.1'
valueset "Hereditary factor IX deficiency": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.2'
valueset "Von Willebrand's disease": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.3'
valueset "Acquired hemophilia": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.4'
valueset "Other coagulation factor deficiencies": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.5'
valueset "Acquired Factor VIII autoantibodies": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.6'
valueset "Other hemorrhagic disorder due to intrinsic circulating anticoagulants, antibodies, or inhibitors": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.7'
valueset "Anti-inhibitor, per IU": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.8'
valueset "Antiphospholipid antibody with hemorrhagic disorder": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.9'
valueset "Other less expensive therapies": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.10'
valueset "Diagnostic Tests for hemophilia": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.11'
valueset "Procedure Unsuccessful": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Procedure for Medication Administration": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define "HemophiliaDiagnosis":
	AICC."HemophiliaDiagnosis"

define "FactorVIIIDiagnosis":
	AICC."FactorVIIIDiagnosis"

define "CoagulationFactorDiagnosis":
	AICC."CoagulationFactorDiagnosis"

define "HemorrhageDiagnosis":
	AICC."HemorrhageDiagnosis"

define "DiagnosesAssessment":
	if (Last("HemophiliaDiagnosis") is not null
		and Last("FactorVIIIDiagnosis") is not null
		and Last("CoagulationFactorDiagnosis") is not null
		and Last("HemorrhageDiagnosis").severity.coding[0].display.value='Severe')
	then true
	else false

define "OtherTherapiesAssessment":
	if (Last(AICC."OtherFailedTherapyResources") is not null)
	then true
	else false

define "DiagnosticTestsAssessment":
	if (Last(AICC."DiagnosticTestResources") is not null)
	then true
	else false

define "FinalDecision":
	if ("OtherTherapiesAssessment"=true)
		and ("DiagnosesAssessment"=true)
		and ("DiagnosticTestsAssessment"=true)
	then 'YES'
	else 'NO'
