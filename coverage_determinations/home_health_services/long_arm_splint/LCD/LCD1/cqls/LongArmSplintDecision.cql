library LongArmSplintDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include LongArmSplint version '1.0.0' called LAS

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Application of Long Arm Splint Service": '2.16.840.1.113883.3.6037.1001.23.93.254'
valueset "Physical Therapy": '2.16.840.1.113883.3.6037.1001.23.93.256'
valueset "Occupational Therapy": '2.16.840.1.113883.3.6037.1001.23.93.257'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define QT:
	"QuestionnaireResponse".item

//Service Request Info
define PTOrOTResponse:
  ("QT".item I
		where I.linkId.value = 'PTOrOT')QR
		return First(QR.answer).value

define PTOrOTService:
  LAS."PTOrOT"

define PTOrOT:
  Coalesce(First("PTOrOTResponse".code), "PTOrOTService")

define TypeOfRequestResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfRequest')QR
		return First(QR.answer).value

define TypeOfRequestService:
  LAS."TypeOfRequest"

define TypeOfRequest:
    Coalesce(First("TypeOfRequestResponse").code, "TypeOfRequestService")

define RestorativeServicePTResponse:
  ("QT".item I
		where I.linkId.value = 'RestorativeServicePT')QR
		return First(QR.answer).value

define RestorativeServicePTServ:
  LAS."RestorativeServicePT"

define RestorativeServicePT:
    Coalesce(First("RestorativeServicePTResponse").code, "RestorativeServicePTServ")

define RestorativeServiceOTResponse:
  ("QT".item I
		where I.linkId.value = 'RestorativeServiceOT')QR
		return First(QR.answer).value

define RestorativeServiceOTServ:
  LAS."RestorativeServiceOT"

define RestorativeServiceOT:
    Coalesce(First("RestorativeServiceOTResponse").code, "RestorativeServiceOTServ")

define TypeOfSplintingResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfSplinting')QR
		return First(QR.answer).value

define TypeOfSplintingServ:
  LAS."TypeOfSplinting"

define TypeOfSplinting:
    Coalesce(First("TypeOfSplintingResponse").code, "TypeOfSplintingServ")

define RequiredLongArmServiceDecision:
  if (("PTOrOT" in {'Physical Therapy','Occupational Therapy'})
    and ("TypeOfRequest" = 'Restorative or Rehabilitative Therapy')
      and (("RestorativeServicePT" = 'Application of a Splint')
              or ("RestorativeServiceOT" = 'Application of a Splint'))
        and ("TypeOfSplinting" = 'Application of Long Arm Splint'))
          then true
            else false

//Diagnosis Information
define LongArmSplintConditionsResponse:
  ("QT".item I
		where I.linkId.value = 'LongArmSplintConditions')QR
		return First(QR.answer).value

define LongArmSplintConditionsCond:
  LAS."LongArmSplintConditions"

define LongArmSplintConditions:
    Coalesce(First("LongArmSplintConditionsResponse").code, "LongArmSplintConditionsCond")

define LongArmFracturePartResponse:
  ("QT".item I
		where I.linkId.value = 'LongArmFracturePart')QR
		return First(QR.answer).value

define LongArmFracturePartCondition:
  LAS."LongArmFracturePart"

define LongArmFracturePart:
    Coalesce(First("LongArmFracturePartResponse"), "LongArmFracturePartCondition")

define LongArmDislocationPartResponse:
  ("QT".item I
		where I.linkId.value = 'LongArmDislocationPart')QR
		return First(QR.answer).value

define LongArmDislocationPartCondition:
  LAS."LongArmDislocationPart"

define LongArmDislocationPart:
  Coalesce(First("LongArmDislocationPartResponse"), "LongArmDislocationPartCondition")

define LongArmTissueDeformityTypeResponse:
  ("QT".item I
		where I.linkId.value = 'LongArmTissueDeformityType')QR
		return First(QR.answer).value

define LongArmTissueDeformityTypeCondition:
  LAS."LongArmTissueDeformityType"

define LongArmTissueDeformityType:
  Coalesce(First("LongArmTissueDeformityTypeResponse"), "LongArmTissueDeformityTypeCondition")

define LongArmTissueDeformityPartResponse:
  ("QT".item I
		where I.linkId.value = 'LongArmTissueDeformityPart')QR
		return First(QR.answer).value

define LongArmTissueDeformityPartCondition:
  LAS."LongArmTissueDeformityPart"

define LongArmTissueDeformityPart:
  Coalesce(First("LongArmTissueDeformityPartResponse".code), "LongArmTissueDeformityPartCondition")

define LongArmTemporaryImmobilization:
	("QT".item I
		where I.linkId.value = 'LongArmTemporaryImmobilization')QR
		return First(QR.answer).value

define LongArmSplintReasons:
  ("QT".item I
		where I.linkId.value = 'LongArmSplintReasons')QR
		return First(QR.answer).value

define LongArmFractureDecision:
  if (("LongArmSplintConditions" = 'Fracture')
        and ("LongArmFracturePart" in {'Distal Humerus','Olecranon','Radial Head/Radius','Capitellum','Elbow','Ulna'}))
          then true
            else false

define LongArmDislocationDecision:
  if (("LongArmSplintConditions" = 'Dislocation')
        and ("LongArmDislocationPart" in {'Distal Humerus','Olecranon','Radial Head/Radius','Capitellum','Elbow','Ulna'}))
          then true
            else false

define LongArmDeformityDecision:
  if (("LongArmSplintConditions" = 'Soft Tissue Deformity')
        and ("LongArmTissueDeformityType" in {'Contracture','Sprain/Strain','Tendonitis'}))
          then true
            else false

define LongArmPostOperativeSplint:
   if ("LongArmSplintConditions" = 'Post-operative Reconstructive Purposes')
          then true
            else false

define LongArmDiagnosisDecision:
  if (("LongArmFractureDecision" = true
        or "LongArmDislocationDecision" = true
          or "LongArmDeformityDecision" = true
            or "LongArmPostOperativeSplint" = true)
              and ("LongArmTemporaryImmobilization" = true)
                and (("LongArmSplintReasons").code is not null))
                  then true
                    else false

//Authorization
define DiagnosisImprovePostTherapy:
  ("QT".item I
		where I.linkId.value = 'DiagnosisImprovePostTherapy')QR
		return First(QR.answer).value

define CertifiedPT:
  ("QT".item I
		where I.linkId.value = 'CertifiedPT')QR
		return First(QR.answer).value

define FToFEncounterResponse:
  ("QT".item I
		where I.linkId.value = 'FToFEncounter')QR
		return First(QR.answer).value

define FToFEncounterEncounter:
  LAS."FToFEncounter"

define FToFEncounter:
    Coalesce(First("FToFEncounterResponse"), "FToFEncounterEncounter")

define AuthorizationByPT:
  if (First("CertifiedPT") = true
        and (First("DiagnosisImprovePostTherapy") = true)
          and ("FToFEncounter" = true))
            then true
              else false

//Decisions
define FinalRequiredTherapy:
  if ("PTOrOT" = 'Physical Therapy')
    then 'Physical Therapy'
      else if ("PTOrOT" = 'Occupational Therapy')
        then 'Occupational Therapy'
          else 'Does not require Home Health Therapy'

define TypeOfTherapy:
  if ("TypeOfRequest" = 'Restorative or Rehabilitative Therapy')
    then 'Restorative or Rehabilitative Therapy'
      else null

define FinalDiagnosis:
  if (("LongArmSplintConditions" = 'Fracture'))
    then 'Fracture'
      else if ("LongArmSplintConditions" = 'Dislocation')
        then 'Dislocation'
          else if ("LongArmSplintConditions" = 'Soft Tissue Deformity')
            then 'Soft Tissue Deformity'
              else if ("LongArmSplintConditions" = 'Post-operative Reconstructive Purposes')
                then 'Post-operative Requirement'
                  else 'No confirmed diagnosis'

define IntermediateDecision:
  if (("RequiredLongArmServiceDecision" = true)
      and ("LongArmDiagnosisDecision" = true )
        and ("AuthorizationByPT" = true))
              then 'YES FOR HOME HEALTH THERAPY'
                else 'HUMAN REVIEW NEEDED'

define FinalDecision:
  if ("IntermediateDecision" = 'YES FOR HOME HEALTH THERAPY')
              then 'YES, HOME HEALTH THERAPY can be approved'
                else 'HUMAN REVIEW NEEDED'