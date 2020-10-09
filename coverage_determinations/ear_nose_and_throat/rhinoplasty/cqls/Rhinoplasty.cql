library Rhinoplasty version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include RhinoplastyDecision version '1.0.0' called RhinoplastyDecision

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Rhinoplasty Procedures": '2.16.840.1.113883.3.6037.1001.23.97.7'
valueset "Rhinoplasty Diagnoses": '2.16.840.1.113883.3.6037.1001.23.97.8'
valueset "Operative / procedure report": '2.16.840.1.113883.3.6037.1001.23.97.9'
valueset "Practitioner, nurse, and ancillary progress notes": '2.16.840.1.113883.3.6037.1001.23.97.10'
valueset "Physician consultations": '2.16.840.1.113883.3.6037.1001.23.97.11'
valueset "Advanced beneficiary notice": '2.16.840.1.113883.3.6037.1001.23.97.12'
valueset "Documentation of presurgical conservative measures/treatments":'2.16.840.1.113883.3.6037.1001.23.97.13'
valueset "Imaging reports prior to the visits or treatments": '2.16.840.1.113883.3.6037.1001.23.97.14'

parameter "ServiceRequest" ServiceRequest
parameter "QuevstionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "PrimaryDiagnosesResources":
	RhinoplastyDecision."Diagnoses"

define "PrimaryDiagnoses":
	"PrimaryDiagnosesResources" P
	return P.code.coding[0].display.value+'\n'
