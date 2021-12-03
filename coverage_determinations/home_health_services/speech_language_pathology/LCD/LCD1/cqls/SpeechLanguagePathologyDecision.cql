library SpeechLanguagePathologyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include SpeechLanguagePathology version '1.0.0' called SLP

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Speech Language Pathology Services": '2.16.840.1.113883.3.6037.1001.23.93.209'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define QT:
	"QuestionnaireResponse".item

define SpeechLanguagePathologyService:
  "Request".code.coding C where C in "Speech Language Pathology Services"

define TypeOfRequestResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfRequest')QR
		return First(QR.answer).value

define TypeOfRequestService:
  SLP."TypeOfRequest"

define TypeOfRequest:
  Coalesce(First("TypeOfRequestResponse".code), "TypeOfRequestService")

//Voice Resonance
define BehavioralQualitativeAnalysisResponse:
	("QT".item I
		where I.linkId.value = 'BehavioralQualitativeAnalysis')QR
		return First(QR.answer).value

define BehavioralQualitativeAnalysisService:
      SLP."BehavioralQualitativeAnalysis"

define BehavioralQualitativeAnalysis:
  Coalesce(First("BehavioralQualitativeAnalysisResponse"), "BehavioralQualitativeAnalysisService")

define VoiceResonanceSymptomsResponse:
  ("QT".item I
		where I.linkId.value = 'VoiceResonanceSymptoms')QR
		return First(QR.answer).value

define VoiceResonanceSymptomsCondition:
   SLP."VoiceResonanceSymptoms"

define VoiceResonanceSymptoms:
  Coalesce(First("VoiceResonanceSymptomsResponse"), "VoiceResonanceSymptomsCondition")

define SpecifyVoiceResonanceSymptomsResponse:
  ("QT".item I
		where I.linkId.value = 'SpecifyVoiceResonanceSymptoms')QR
		return First(QR.answer).value

define SpecifyVoiceResonanceSymptomsCondition:
   SLP."SpecifyVoiceResonanceSymptoms"

define SpecifyVoiceResonanceSymptoms:
  Coalesce(First("SpecifyVoiceResonanceSymptomsResponse"), "SpecifyVoiceResonanceSymptomsCondition")

define VoiceResonanceCausedByDiseaseResponse:
  ("QT".item I
		where I.linkId.value = 'VoiceResonanceCausedByDisease')QR
		return First(QR.answer).value

define VoiceResonanceCausedByDiseaseCondition:
  SLP."VoiceResonanceCausedByDisease"

define VoiceResonanceCausedByDisease:
  Coalesce(First("VoiceResonanceCausedByDiseaseResponse"), "VoiceResonanceCausedByDiseaseCondition")

define VoiceResonanceUnwantedResultResponse:
  ("QT".item I
		where I.linkId.value = 'VoiceResonanceUnwantedResult')QR
		return First(QR.answer).value

define VoiceResonanceUnwantedResultProcedure:
  SLP."VoiceResonanceUnwantedResult"

define VoiceResonanceUnwantedResult:
    Coalesce(First("VoiceResonanceUnwantedResultResponse"), "VoiceResonanceUnwantedResultProcedure")

define ArticulationErrorsResponse:
  ("QT".item I
		where I.linkId.value = 'ArticulationErrors')QR
		return First(QR.answer).value

define ArticulationErrorsCondition:
  SLP."ArticulationErrors"

define ArticulationErrors:
  Coalesce(First("ArticulationErrorsResponse"), "ArticulationErrorsCondition")

define RequestDecisionForVoiceResonance:
  if (exists("SpeechLanguagePathologyService")
    and ("BehavioralQualitativeAnalysis" = true))
        then true
            else false

//Speech Influency
define StutteringClutteringSymptomsResponse:
  ("QT".item I
		where I.linkId.value = 'StutteringClutteringSymptoms')QR
		return First(QR.answer).value

define StutteringClutteringSymptomsCondition:
  SLP."StutteringClutteringSymptoms"

define StutteringClutteringSymptoms:
  Coalesce(First("StutteringClutteringSymptomsResponse"), "StutteringClutteringSymptomsCondition")

define EvaluationSpeechFluencyResponse:
 ("QT".item I
		where I.linkId.value = 'EvaluationSpeechFluency')QR
		return First(QR.answer).value

define EvaluationSpeechFluencyService:
  SLP."EvaluationSpeechFluency"

define EvaluationSpeechFluency:
  Coalesce(First("EvaluationSpeechFluencyResponse"), "EvaluationSpeechFluencyService")

define SpeechConditionCausedByDiseaseResponse:
  ("QT".item I
		where I.linkId.value = 'SpeechConditionCausedByDisease')QR
		return First(QR.answer).value

define SpeechConditionCausedByDiseaseCondition:
  SLP."SpeechConditionCausedByDisease"

define SpeechConditionCausedByDisease:
  Coalesce(First("SpeechConditionCausedByDiseaseResponse"), "SpeechConditionCausedByDiseaseCondition")

define SpecifyDiseaseCausingSpeechConditionResponse:
  ("QT".item I
		where I.linkId.value = 'SpecifyDiseaseCausingSpeechCondition')QR
		return First(QR.answer).value

define SpecifyDiseaseCausingSpeechConditionDiag:
  SLP."SpecifyDiseaseCausingSpeechCondition"

define SpecifyDiseaseCausingSpeechCondition:
  Coalesce(First("SpeechConditionCausedByDiseaseResponse"), "SpeechConditionCausedByDiseaseCondition")

define SpeechConditionCausedByStressResponse:
  ("QT".item I
		where I.linkId.value = 'SpeechConditionCausedByStress')QR
		return First(QR.answer).value

define SpeechConditionCausedByStressCondition:
  SLP."SpeechConditionCausedByStress"

define SpeechConditionCausedByStress:
  Coalesce(First("SpeechConditionCausedByDiseaseResponse"), "SpeechConditionCausedByDiseaseCondition")

define RequestDecisionForSpeechInfluency:
  if (exists("SpeechLanguagePathologyService")
    and ("EvaluationSpeechFluency" = true))
        then true
            else false

//Common Past Medical History
define CongenitalDefectCauseResponse:
  ("QT".item I
		where I.linkId.value = 'CongenitalDefectCause')QR
		return First(QR.answer).value

define CongenitalDefectCauseCondition:
  SLP."CongenitalDefectCause"

define CongenitalDefectCause:
    Coalesce(First("CongenitalDefectCauseResponse"), "CongenitalDefectCauseCondition")

define TraumaCauseResponse:
  ("QT".item I
		where I.linkId.value = 'TraumaCause')QR
		return First(QR.answer).value

define TraumaCauseCondition:
  SLP."TraumaCause"

define TraumaCause:
  Coalesce(First("TraumaCauseResponse"), "TraumaCauseCondition")

define ConditionPreviousHistoryResponse:
  ("QT".item I
		where I.linkId.value = 'ConditionPreviousHistory')QR
		return First(QR.answer).value

define ConditionPreviousHistoryCondition:
  SLP."ConditionPreviousHistory"

define ConditionPreviousHistory:
    Coalesce(First("ConditionPreviousHistoryResponse"), "ConditionPreviousHistoryCondition")

define CertifiedSLP:
  ("QT".item I
		where I.linkId.value = 'CertifiedSLP')QR
		return First(QR.answer).value

define FToFEncounterResponse:
  ("QT".item I
		where I.linkId.value = 'FToFEncounter')QR
		return First(QR.answer).value

define FToFEncounterType:
  SLP."FToFEncounter"

define FToFEncounter:
    Coalesce(First("FToFEncounterResponse"), "FToFEncounterType")

define AuthorizationBySLP:
  if (First("CertifiedSLP") = true
        and ("FToFEncounter" = true))
          then true
            else false

define PrimaryDecisionForVoiceResonance:
  if ("RequestDecisionForVoiceResonance" = true
        and "VoiceResonanceSymptoms" = true
          and "AuthorizationBySLP" = true)
            then true
              else false

define PrimaryDecisionForSpeechInfluency:
  if ("RequestDecisionForSpeechInfluency" = true
        and "StutteringClutteringSymptoms" = true
          and "AuthorizationBySLP" = true)
            then true
              else false

define FinalDecision:
  if ("PrimaryDecisionForVoiceResonance" = true
        or "PrimaryDecisionForSpeechInfluency" = true)
    then 'HUMAN REVIEW NEEDED'
      else 'NO'
