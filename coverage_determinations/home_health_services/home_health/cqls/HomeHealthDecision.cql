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

define Service:
	"ServiceRequest"

define HomeHealthCare:
	HomeHealth."HomeHealthCare"
	
define Agency: 
	HomeHealth."Agency"
    
define AgencyName: 
    HomeHealth."AgencyName"

define AgencyNPI: 
	HomeHealth."AgencyNPI"
    
define AgencyPTAN:
	HomeHealth."AgencyPTAN"

define CMSCertificationNumber: 
	HomeHealth."CMSCertificationNumber"

define AgencyAddressObject:  
    HomeHealth."AgencyAddressObject"

define AgencyLineAddress: 
	HomeHealth."AgencyLineAddress"
	
define AgencyCityAddress: 
	HomeHealth."AgencyCityAddress"
	
define AgencyStateAddress: 
	HomeHealth."AgencyStateAddress"
	
define AgencyPostalAddress: 
	HomeHealth."AgencyPostalAddress"

define AgencyAddress: 
	HomeHealth."AgencyAddress"

define SubmissionDate: 
	HomeHealth."SubmissionDate"

define Episode: 
	HomeHealth."Episode"

define EncounterResource:
	HomeHealth."EncounterResource"

define EncPractitioner:
    HomeHealth."EncPractitioner"

define FacetoFaceEncounter:
	HomeHealth."FacetoFaceEncounter"

define FToFEncounter:
	HomeHealth."FToFEncounter"

define FToFEncounterDate:
	HomeHealth."FToFEncounterDate"

define EpisodeEncounter: 
	HomeHealth."EpisodeEncounter"

define UnderCare:
	HomeHealth."UnderCare"

define StartDateEpisode: 
	HomeHealth."StartDateEpisode"
	
define EndDate: 
	HomeHealth."EndDate" 

define state: 
	HomeHealth."state"

define InabilityToLeaveHome: 
	HomeHealth."InabilityToLeaveHome"

define Mobility:
	HomeHealth."Mobility"
	
define DeviceSpecified:
	HomeHealth."DeviceSpecified"

define DeviceUsage:
	HomeHealth."DeviceUsage"

define AgencyDetails:
	if (("AgencyName" is not null)
		and ("AgencyNPI" is not null)
		and ("AgencyPTAN" is not null)
		and ("CMSCertificationNumber" is not null)
		and ("AgencyAddress" is not null))
		then true
		else false

define PlanOfCare:
	if (("Episode" is not null)
		and ("UnderCare" is not null)
		and ("StartDateEpisode" is not null)
		and ("state" is not null)
		and (("InabilityToLeaveHome" is not null)
				or ("DeviceUsage" = true)))
		then true
		else false

define QT:
	"QuestionnaireResponse".item

define QA32:
	("QT".item I
		where I.linkId.value = '3.2')QR
		return First(QR.answer).value

define QA34:
	("QT".item I
		where I.linkId.value = '3.4')QR
		return First(QR.answer).value

define PrimaryDecision:
	if (("AgencyDetails" = true)
		and ("PlanOfCare" = true)
		and ("FToFEncounter" = true)
		and (First("QA32") = true)
		and (First("QA34") = true))
		then true
		else false

define FinalDecision:
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'NO'
	

    

