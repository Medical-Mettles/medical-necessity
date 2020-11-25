library AntigastroesophagealRefluxDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include AntigastroesophagealReflux version '1.0.0' called AGR

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Procedure Contraindicated": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.71'
valueset "Valvuloplasty Procedure": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.72'
valueset "Gastroesophageal reflux disease": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.73'
valueset "Systemic sclerosis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.74'
valueset "Esophagus bodysite": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.75'
valueset "Foreshortening of esophagus": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.76'
valueset "Insufficient esophageal tissue": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.77'
valueset "Esophageal valve reconstruction": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.78'
valueset "Procedure Unsuccessful": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define QA13:
	("QT".item I
		where I.linkId.value = '1.3')QR
		return First(QR.answer).value

define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

define "DiagnosesAssessment":
	if (Last(AGR."PrimaryDiagnosesResources") is not null
    and First("QA13").value = true)
	then true
	else false

define "TreatmentsAssessment":
	if (Last(AGR."ValvuloplastyContraindicated") is not null)
	then true
	else false

define "OtherConditions":
  if (Last(AGR."SystemicSclerosisCondition") is not null
      or (Last(AGR."EsophagealForeshortening") is not null
          and Last(AGR."ValveReconstruction") is not null)
  )
	then true
	else false

define "FinalDecision":
	if ("DiagnosesAssessment"=true)
		and (("TreatmentsAssessment"=true)
		  or ("OtherConditions"=true)
      or First("QA22").value = true)
	then 'YES'
	else 'NO'
