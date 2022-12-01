library HomeHealthDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include HomeHealthService version '1.0.0' called HomeHealth

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'
codesystem "Version2Tables": 'http://terminology.hl7.org/CodeSystem/v2-0203'

valueset "Immobilization": '2.16.840.1.113883.17.4077.2.2006'
valueset "Serious or Life Threatening Illness": '2.16.840.1.113883.3.464.1003.199.12.1055'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'
valueset "Frailty Device": '2.16.840.1.113883.3.464.1003.118.11.1114'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient
	
define "prior-auth":
  true

define "documentation":
  false

define "dtr-clin":
  true

define FToFEncounter:
	HomeHealth."FToFEncounter"

define FinalDecision:
	if ("FToFEncounter" = true)
	then 'YES'
	else 'NO'
	

    

