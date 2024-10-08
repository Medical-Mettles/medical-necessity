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
valueset "Rehabilitation Services": '2.16.840.1.113883.3.117.1.7.1.221'
valueset "Procedures Performed": '2.16.840.1.113762.1.4.1195.30'
valueset "Medication Clinical Drug": '2.16.840.1.113762.1.4.1195.62'
valueset "ACE inhibitor allergy/intolerance codes": '2.16.840.1.113762.1.4.1078.45'
valueset "Home Health Procedure": '2.16.840.1.113762.1.4.1219.104'


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

define CarePlan:
	HomeHealth."QualifiedCarePlan"

define QualifyingCarePlan:
	if ("CarePlan" is not null)
		then true
		else false

define PertinentCondition:
	HomeHealth."PertinentCondition"
	
define QualifyingCondition:
	if("PertinentCondition" is not null)
		then true
		else false

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define PatientFunctionalAssessment:
	("QuestionnaireResponseItems".item I
		   where I.linkId.value = '8.1')QR
		      return (First(QR.answer).value as Coding).code.value

define FunctionalAssessmentLimitation:
	if ((First("PatientFunctionalAssessment") is not null))
		then true
		else false

define PermittedActivitiesforPatient:
	("QuestionnaireResponseItems".item I
		   where I.linkId.value = '8.3')QR
		      return (First(QR.answer).value as Coding).code.value

define PermittedActivitiesLimitation:
	if ((First("PermittedActivitiesforPatient") = 'No restrictions')
		or (First("PermittedActivitiesforPatient") = 'Independent at home'))
		then true
		else false

define PatientMentalStatus:
	("QuestionnaireResponseItems".item I
		   where I.linkId.value = '8.5')QR
		      return (First(QR.answer).value as Coding).code.value

define MentalStatusLimitation:
	if ((First("PatientMentalStatus") = 'Comatose')
		or (First("PatientMentalStatus") = 'Depressed')
		or (First("PatientMentalStatus") = 'Disoriented')
		or (First("PatientMentalStatus") = 'Agitated'))
		then true
		else false

define PatientPrognosis:
	("QuestionnaireResponseItems".item I
		   where I.linkId.value = '10.1')QR
		      return (First(QR.answer).value as Coding).code.value

define Prognosis:
	if ((First("PatientPrognosis") = 'Fair')
		or (First("PatientPrognosis") = 'Good')
		or (First("PatientPrognosis") = 'Excellent'))
		then true
		else false

define PrimaryDecision:
	if (("FToFEncounter" = true)
		and ("QualifyingCarePlan" = true)
		and ("QualifyingCondition" = true)
		and (("FunctionalAssessmentLimitation" = true)
				or ("PermittedActivitiesLimitation" =true)
				or ("MentalStatusLimitation" = true))
		and ("Prognosis" = true))
		then true
		else false

define FinalDecision:
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'PENDING'
	

    

