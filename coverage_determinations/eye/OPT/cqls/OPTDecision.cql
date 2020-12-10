library OPTDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include OPTPrepopulation version '1.0.0' called OPTherapy

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Optical coherence tomography (OCT)":  '2.16.840.1.113762.1.4.1047.541'
valueset "Photodynamic therapy": '2.16.840.1.113883.3.6037.1001.23.95.19'
valueset "verteporfin": '2.16.840.1.113883.3.6037.1001.23.95.20'
valueset "Fluorescein angiography of eye": '2.16.840.1.113883.3.6037.1001.23.95.18'
valueset "Neovascular age-related macular degeneration": '2.16.840.1.113883.3.6037.1001.23.95.16'
valueset "Ocular age-related macular degeneration": '2.16.840.1.113883.3.6037.1001.23.95.17'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define QA21:
	("QT".item I
		where I.linkId.value = '2.1')QR
		return First(QR.answer).value

define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

define PrimaryDiagnosis:
    OPTherapy."PrimaryDiagnosis"

define DiagnosisEncounter:
    OPTherapy."DiagnosisEncounter"

define NotCoveredCondition:
    OPTherapy."NotCoveredCondition"

define FAProcedure:
    OPTherapy."FAProcedure"

define OCTProcedure:
    OPTherapy."OCTProcedure"

define FAResult:
    OPTherapy."FAResult"

define OCTResult:
    OPTherapy."OCTResult"

define VerteporfinAdministration:
    OPTherapy."VerteporfinAdministration"

define OPTProcedure:
    OPTherapy."OPTProcedure"

define PrimaryDecision:
    if (("PrimaryDiagnosis" is not null)
        and ("FAResult" is not null))
        and ("NotCoveredCondition" is null)
        and (First("QA21").value = true)
        and (First("QA22").value = true)
        and ("OPTProcedure" is not null)
        then true
        else false

define FinalDecision:
    if ("PrimaryDecision" = true)
    then 'YES'
    else 'NO'
