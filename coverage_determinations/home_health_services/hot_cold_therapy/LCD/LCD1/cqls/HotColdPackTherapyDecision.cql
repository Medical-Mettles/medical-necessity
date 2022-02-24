library HotColdPackTherapyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include HotColdPackTherapy version '1.0.0' called HCT

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Physical Therapy": '2.16.840.1.113883.3.6037.1001.23.93.256'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define QT:
	"QuestionnaireResponse".item

//Service Request Info
define TypeOfRequestResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfRequest')QR
		return First(QR.answer).value

define TypeOfRequestService:
  HCT."TypeOfRequest"

define TypeOfRequest:
    Coalesce(First("TypeOfRequestResponse").code, "TypeOfRequestService")

define MaintenanceProgramsPTResponse:
  ("QT".item I
		where I.linkId.value = 'MaintenanceProgramsPT')QR
		return First(QR.answer).value

define MaintenanceProgramsPTServ:
  HCT."MaintenanceProgramsPT"

define MaintenanceProgramsPT:
    Coalesce(First("MaintenanceProgramsPTResponse").code, "MaintenanceProgramsPTServ")

define HotOrColdTherapy:
  ("QT".item I
		where I.linkId.value = 'HotOrColdTherapy')QR
		return First(QR.answer).value

define RequiredHotColdPackServiceDecision:
  if (("TypeOfRequest" = 'Maintenance Program')
    and ("MaintenanceProgramsPT" = 'Hot or Cold Packs Therapy')
      and (First("HotOrColdTherapy") is not null))
          then true
            else false

//Diagnosis Information
define HotColdTherapyReasonsResponse:
  ("QT".item I
		where I.linkId.value = 'HotColdTherapyReasons')QR
		return First(QR.answer).value

define HotColdTherapyReasonsCond:
  LBS."HotColdTherapyReasons"

define HotColdTherapyReasons:
    Coalesce(First("HotColdTherapyReasonsResponse").code, "HotColdTherapyReasonsCond")

define HotColdTherapyDiagnosisDecision:
  if ("HotColdTherapyReasons" is not null)
         then true
           else false

//Therapy Info
define HotColdDevices:
  ("QT".item I
		where I.linkId.value = 'HotColdDevices')QR
		return First(QR.answer).value

define HotColdConjuction:
  ("QT".item I
		where I.linkId.value = 'HotColdConjuction')QR
		return First(QR.answer).value

define TherapyDecision:
  if (First("HotColdDevices") = 1
        and First("HotColdConjuction") = true)
          then true
            else false

//Authorization
define FToFEncounterResponse:
  ("QT".item I
		where I.linkId.value = 'FToFEncounter')QR
		return First(QR.answer).value

define FToFEncounterEncounter:
  LBS."FToFEncounter"

define FToFEncounter:
    Coalesce(First("FToFEncounterResponse"), "FToFEncounterEncounter")

define AuthorizationByPT:
  if ("FToFEncounter" = true)
            then true
              else false

//Decisions
define TypeOfTherapy:
  if ("TypeOfRequest" = 'Maintenance Program')
    then 'Maintenance Program'
      else null

define FinalDiagnosis:
  if ("HotColdTherapyReasons" = 'To relieve muscle spasms')
    then 'Muscle Spasms'
      else if ("HotColdTherapyReasons" = 'To reduce inflammation or swelling')
        then 'Inflammation or Swelling'
          else 'No confirmed diagnosis'

define IntermediateDecision:
  if (("RequiredHotColdPackServiceDecision" = true)
      and ("HotColdTherapyDiagnosisDecision" = true)
        and ("TherapyDecision" = true)
          and ("AuthorizationByPT" = true))
              then 'YES FOR HOME HEALTH THERAPY'
                else 'HUMAN REVIEW NEEDED'

define FinalDecision:
  if ("IntermediateDecision" = 'YES FOR HOME HEALTH THERAPY')
              then 'YES, HOME HEALTH THERAPY can be approved'
                else 'HUMAN REVIEW NEEDED'