library FingerSplintDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include FingerSplint version '1.0.0' called FS

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Physical Therapy": '2.16.840.1.113883.3.6037.1001.23.93.256'
valueset "Occupational Therapy": '2.16.840.1.113883.3.6037.1001.23.93.257'
valueset "Application of Finger Splint Service": '2.16.840.1.113883.3.6037.1001.23.93.285'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define QT:
	"QuestionnaireResponse".item

define PTorOTResponse:
  ("QT".item I
		where I.linkId.value = 'PTOrOT')QR
		return First(QR.answer).value

define PTOrOTService:
  FS."PTOrOT"

define PTOrOT:
    Coalesce(First("PTorOTResponse").code, "PTOrOTService")

define TypeOfRequestResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfRequest')QR
		return First(QR.answer).value

define TypeOfRequestService:
  FS."TypeOfRequest"

define TypeOfRequest:
    Coalesce(First("TypeOfRequestResponse").code, "TypeOfRequestService")

define RestorativeServicePTResponse:
  ("QT".item I
		where I.linkId.value = 'RestorativeServicePT')QR
		return First(QR.answer).value

define RestorativeServicePTServ:
  FS."RestorativeServicePT"

define RestorativeServicePT:
    Coalesce(First("RestorativeServicePTResponse").code, "RestorativeServicePTServ")

define RestorativeServiceOTResponse:
  ("QT".item I
		where I.linkId.value = 'RestorativeServiceOT')QR
		return First(QR.answer).value

define RestorativeServiceOTServ:
  FS."RestorativeServiceOT"

define RestorativeServiceOT:
    Coalesce(First("RestorativeServiceOTResponse").code, "RestorativeServiceOTServ")

define TypeOfSplintingResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfSplinting')QR
		return First(QR.answer).value

define TypeOfSplintingServ:
  FS."TypeOfSplinting"

define TypeOfSplinting:
    Coalesce(First("TypeOfSplintingResponse").code, "TypeOfSplintingServ")

define FingerSplintReqDecision:
  if (("PTOrOT" = 'Physical Therapy'
        and "TypeOfRequest" = 'Restorative or Rehabilitative Therapy'
          and "RestorativeServicePT" = 'Application of a Splint'
            and "TypeOfSplinting" = 'Application of Finger Splint')
              or ("PTOrOT" = 'Occupational Therapy'
                and "TypeOfRequest" = 'Restorative or Rehabilitative Therapy'
                  and "RestorativeServiceOT" = 'Application of a Splint'
                    and "TypeOfSplinting" = 'Application of Finger Splint'))
                      then true
                        else false

define FingerSplintConditionsResponse:
  ("QT".item I
		where I.linkId.value = 'FingerSplintConditions')QR
		return First(QR.answer).value

define FingerSplintConditionsCond:
  FS."FingerSplintConditions"

define FingerSplintConditions:
    Coalesce(First("FingerSplintConditionsResponse").code, "FingerSplintConditionsCond")

define FingerAffectedResponse:
  ("QT".item I
		where I.linkId.value = 'FingerAffected')QR
		return First(QR.answer).value

define FingerAffectedCond:
  FS."FingerAffected"

define FingerAffected:
    Coalesce(First("FingerAffectedResponse").code, "FingerAffectedCond")

define FingerSplintReasons:
  ("QT".item I
		where I.linkId.value = 'FingerSplintReasons')QR
		return First(QR.answer).value

define TemporaryFingerImmobilization:
  ("QT".item I
		where I.linkId.value = 'TemporaryFingerImmobilization')QR
		return First(QR.answer).value

define DiagnosisDecision:
  if ("FingerSplintConditions" is not null
        and "FingerAffected" is not null
          and First("FingerSplintReasons") is not null
            and First("TemporaryFingerImmobilization") = true)
              then true
                else false

define TypeOfFingerSplint:
  ("QT".item I
		where I.linkId.value = 'TypeOfFingerSplint')QR
		return First(QR.answer).value

define CertifiedPT:
  ("QT".item I
		where I.linkId.value = 'CertifiedPT')QR
		return First(QR.answer).value

define CertifiedOT:
  ("QT".item I
		where I.linkId.value = 'CertifiedOT')QR
		return First(QR.answer).value

define FToFEncounterPTResponse:
  ("QT".item I
		where I.linkId.value = 'FToFEncounterPT')QR
		return First(QR.answer).value

define FToFEncounterPTEnc:
  FS."FToFEncounterPT"

define FToFEncounterPT:
    Coalesce(First("FToFEncounterPTResponse"), "FToFEncounterPTEnc")

define FToFEncounterOTResponse:
  ("QT".item I
		where I.linkId.value = 'FToFEncounterOT')QR
		return First(QR.answer).value

define FToFEncounterOTEnc:
  FS."FToFEncounterOT"

define FToFEncounterOT:
    Coalesce(First("FToFEncounterOTResponse"), "FToFEncounterOTEnc")

define TherapyDecision:
  if (First("TypeOfFingerSplint") is not null
        and (First("CertifiedPT") = true or First("CertifiedOT") = true)
          and ("FToFEncounterPT" = true or "FToFEncounterOT" = true))
            then true
              else false

define TypeOfTherapy:
  if ("TypeOfRequest" = 'Restorative or Rehabilitative Therapy')
    then 'Restorative or Rehabilitative Therapy'
      else null

define TypeOfRestorativeTherapy:
	if ("RestorativeServicePT" = 'Application of a Splint'
				or "RestorativeServiceOT" = 'Application of a Splint')
    			then 'Application of a Splint'
      			else null

define TypeOfSplintTherapy:
	if "TypeOfSplinting" = 'Application of Finger Splint'
				then 'Application of Finger Splint'
      			else null

define FinalDiagnosis:
  if ("FingerSplintConditions" = 'Fracture')
    then 'Fracture'
        else 'No confirmed diagnosis'

define IntermediateDecision:
  if ("FingerSplintReqDecision" = true
         and "DiagnosisDecision" = true
          and "TherapyDecision" = true)
            then 'YES FOR HOME HEALTH THERAPY'
              else 'HUMAN REVIEW NEEDED'

define FinalDecision:
  if ("IntermediateDecision" = 'YES FOR HOME HEALTH THERAPY')
              then 'YES, HOME HEALTH THERAPY can be approved'
                else 'HUMAN REVIEW NEEDED'

