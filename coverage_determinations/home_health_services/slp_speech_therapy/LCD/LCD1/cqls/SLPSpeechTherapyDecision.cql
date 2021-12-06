library SLPSpeechTherapyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include SLPSpeechTherapy version '1.0.0' called SLP

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Speech Fluency Therapy": '2.16.840.1.113883.3.6037.1001.23.93.229'
valueset "Speech Language Pathology Services": '2.16.840.1.113883.3.6037.1001.23.93.209'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define QT:
	"QuestionnaireResponse".item

//Service Request Info
define SpeechTherapyService:
  "Request".code.coding C where C in "Speech Fluency Therapy"

define TypeOfRequestResponse:
  ("QT".item I
		where I.linkId.value = 'TypeOfRequest')QR
		return First(QR.answer).value

define TypeOfRequestService:
  SLP."TypeOfRequest"

define TypeOfRequest:
  Coalesce(First("TypeOfRequestResponse".code), "TypeOfRequestService")

define EvaluationSoundProductionResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationSoundProduction')QR
		return First(QR.answer).value

define EvaluationSoundProductionServ:
  SLP."EvaluationSoundProduction"

define EvaluationSoundProduction:
    Coalesce(First("EvaluationSoundProductionResponse"), "EvaluationSoundProductionServ")

define EvaluationLanguageComprehensionResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationLanguageComprehension')QR
		return First(QR.answer).value

define EvaluationLanguageComprehensionServ:
  SLP."EvaluationLanguageComprehension"

define EvaluationLanguageComprehension:
    Coalesce(First("EvaluationLanguageComprehensionResponse"), "EvaluationLanguageComprehensionServ")

define EvaluationSwallowingFunctionResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationSwallowingFunction')QR
		return First(QR.answer).value

define EvaluationSwallowingFunctionServ:
  SLP."EvaluationSwallowingFunction"

define EvaluationSwallowingFunction:
    Coalesce(First("EvaluationSwallowingFunctionResponse"), "EvaluationSwallowingFunctionServ")

define EvaluationCognitiveFunctionResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationCognitiveFunction')QR
		return First(QR.answer).value

define EvaluationCognitiveFunctionServ:
  SLP."EvaluationCognitiveFunction"

define EvaluationCognitiveFunction:
    Coalesce(First("EvaluationCognitiveFunctionResponse"), "EvaluationCognitiveFunctionServ")

define EvaluationAphasiaResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationAphasia')QR
		return First(QR.answer).value

define EvaluationAphasiaServ:
  SLP."EvaluationAphasia"

define EvaluationAphasia:
    Coalesce(First("EvaluationAphasiaResponse"), "EvaluationAphasiaServ")

define EvaluationNeurobehavioralStatusResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationNeurobehavioralStatus')QR
		return First(QR.answer).value

define EvaluationNeurobehavioralStatusServ:
  SLP."EvaluationNeurobehavioralStatus"

define EvaluationNeurobehavioralStatus:
    Coalesce(First("EvaluationNeurobehavioralStatusResponse"), "EvaluationNeurobehavioralStatusServ")

define EvaluationDevelopmentalSkillsResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationDevelopmentalSkills')QR
		return First(QR.answer).value

define EvaluationDevelopmentalSkillsServ:
  SLP."EvaluationDevelopmentalSkills"

define EvaluationDevelopmentalSkills:
    Coalesce(First("EvaluationDevelopmentalSkillsResponse"), "EvaluationDevelopmentalSkillsServ")

define EvaluationProstheticUsageResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationProstheticUsage')QR
		return First(QR.answer).value

define EvaluationProstheticUsageServ:
  SLP."EvaluationProstheticUsage"

define EvaluationProstheticUsage:
  Coalesce(First("EvaluationProstheticUsageResponse"), "EvaluationProstheticUsageServ")

define EvaluationSpeechGeneratingDevicesResponse:
  ("QT".item I
		where I.linkId.value = 'EvaluationSpeechGeneratingDevices')QR
		return First(QR.answer).value

define EvaluationSpeechGeneratingDevicesServ:
  SLP."EvaluationSpeechGeneratingDevices"

define EvaluationSpeechGeneratingDevices:
  Coalesce(First("EvaluationSpeechGeneratingDevicesResponse"), "EvaluationSpeechGeneratingDevicesServ")

define RequiredTherapyResponse:
  ("QT".item I
		where I.linkId.value = 'RequiredTherapy')QR
		return First(QR.answer).value

define RequiredTherapyServ:
  SLP."RequiredTherapy"

define RequiredTherapy:
  Coalesce(First("RequiredTherapyResponse".code), "RequiredTherapyServ")

//Voice Resonance Evaluation
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

//Speech Influency Evaluation
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

define EarlierEvaluationsDoneResponse:
  ("QT".item I
		where I.linkId.value = 'EarlierEvaluationsDone')QR
		return First(QR.answer).value

define EarlierEvaluationsDoneProcedure:
  SLP."EarlierEvaluationsDone"

define EarlierEvaluationsDone:
  Coalesce(First("EarlierEvaluationsDoneResponse".code), "EarlierEvaluationsDoneProcedure")

//Authorization
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

//Speech Fluency Therapy
define SpeechFluencyDisorderResponse:
  ("QT".item I
		where I.linkId.value = 'SpeechFluencyDisorder')QR
		return First(QR.answer).value

define SpeechFluencyDisorderCondition:
  SLP."SpeechFluencyDisorder"

define SpeechFluencyDisorder:
  Coalesce(First("SpeechFluencyDisorderResponse"), "SpeechFluencyDisorderCondition")

define SpeechFluencyDisorderPatternResponse:
  ("QT".item I
		where I.linkId.value = 'SpeechFluencyDisorderPattern')QR
		return First(QR.answer).value

define SpeechFluencyDisorderPatternCondition:
  SLP."SpeechFluencyDisorderPattern"

define SpeechFluencyDisorderPattern:
  Coalesce(First("SpeechFluencyDisorderPatternResponse".code), "SpeechFluencyDisorderPatternCondition")

define SpeechFluencyDisorderDurationResponse:
  ("QT".item I
		where I.linkId.value = 'SpeechFluencyDisorderDuration')QR
		return First(QR.answer).value

define SpeechFluencyDisorderDurationCondition:
  SLP."SpeechFluencyDisorderDuration"

define SpeechFluencyDisorderDuration:
  Coalesce(First("SpeechFluencyDisorderDurationResponse".code), "SpeechFluencyDisorderDurationCondition")

define SpeechFluencyDisorderCauseResponse:
  ("QT".item I
		where I.linkId.value = 'SpeechFluencyDisorderCause')QR
		return First(QR.answer).value

define SpeechFluencyDisorderCauseCondition:
  SLP."SpeechFluencyDisorderCause"

define SpeechFluencyDisorderCause:
  Coalesce(First("SpeechFluencyDisorderCauseResponse".code), "SpeechFluencyDisorderCauseCondition")

define EarlierEvaluationsDoneSpeechDecision:
  if ("EarlierEvaluationsDone" = 'Evaluation of speech fluency')
        then true
          else false

//Voice and Resonance Therapy
define VoiceResonanceDisorderResponse:
  ("QT".item I
		where I.linkId.value = 'VoiceResonanceDisorder')QR
		return First(QR.answer).value

define VoiceResonanceDisorderCondition:
  SLP."VoiceResonanceDisorder"

define VoiceResonanceDisorder:
  Coalesce(First("VoiceResonanceDisorderResponse"), "VoiceResonanceDisorderCondition")

define SpecifyVoiceResonanceDisorderResponse:
  ("QT".item I
		where I.linkId.value = 'SpecifyVoiceResonanceDisorder')QR
		return First(QR.answer).value

define SpecifyVoiceResonanceDisorderCondition:
  SLP."SpecifyVoiceResonanceDisorder"

define SpecifyVoiceResonanceDisorder:
    Coalesce(First("VoiceResonanceDisorderResponse".code), "SpecifyVoiceResonanceDisorderCondition")

define VoiceResonanceDisorderCauseResponse:
  ("QT".item I
		where I.linkId.value = 'VoiceResonanceDisorderCause')QR
		return First(QR.answer).value

define VoiceResonanceDisorderCauseCondition:
  SLP."VoiceResonanceDisorderCause"

define VoiceResonanceDisorderCause:
    Coalesce(First("VoiceResonanceDisorderCauseResponse".code), "VoiceResonanceDisorderCauseCondition")

define EarlierEvaluationsDecisionVoiceResonance:
  if ("EarlierEvaluationsDone" = 'Behavioral and qualitative analysis of voice and resonance')
        then true
          else false

//Therapy Info
define DiagnosisImprovePostTherapy:
 ("QT".item I
		where I.linkId.value = 'DiagnosisImprovePostTherapy')QR
		return First(QR.answer).value

//Decisions
define FinalRequiredTherapy:
  if ("RequiredTherapy" = 'Speech fluency therapy')
    then 'Speech Fluency Therapy'
      else if ("RequiredTherapy" = 'Voice and resonance therapy')
        then 'Voice and Resonance Therapy'
          else 'Does not require Speech Therapy'

define PreviousEvaluationsDone:
  if ("EarlierEvaluationsDone" = 'Evaluation of speech fluency')
    then 'Evaluation of Speech Fluency'
      else if ("EarlierEvaluationsDone" = 'Behavioral and qualitative analysis of voice and resonance')
        then 'Behavioral and Qualitative Analysis of Voice and Resonance'
          else 'Evaluation for Speech Therapy were not done'

define FinalDiagnosis:
  if ("SpeechFluencyDisorder" = true)
    then 'Speech Fluency Disorder'
      else if ("VoiceResonanceDisorder" = true)
        then 'Voice and Resonance Disorder'
          else 'No confirmed diagnosis'

define AuthorizationBySLP:
  if (First("CertifiedSLP") = true
        and ("FToFEncounter" = true))
          then true
            else false

define PrimaryDecisionForSpeechFluencyTherapy:
  if ("EarlierEvaluationsDoneSpeechDecision" = true
        and "SpeechFluencyDisorder" = true
          and First("DiagnosisImprovePostTherapy") = true
            and "RequiredTherapy" = 'Speech fluency therapy'
              and "AuthorizationBySLP" = true)
                then true
                  else false

define PrimaryDecisionForVoiceResonanceTherapy:
  if ("EarlierEvaluationsDecisionVoiceResonance" = true
        and "VoiceResonanceDisorder" = true
          and First("DiagnosisImprovePostTherapy") = true
            and "RequiredTherapy" = 'Voice and resonance therapy'
              and "AuthorizationBySLP" = true)
                then true
                  else false

define IntermediateDecision:
  if (("PrimaryDecisionForVoiceResonanceTherapy" = true)
      and exists("SpeechTherapyService"))
        then 'YES FOR VOICE AND RESONANCE THERAPY'
          else if (("PrimaryDecisionForVoiceResonanceTherapy" = true)
            and exists("SpeechTherapyService"))
              then 'YES FOR SPEECH FLUENCY THERAPY'
                else 'HUMAN REVIEW NEEDED'

define FinalDecision:
  if (("IntermediateDecision" = 'YES FOR VOICE AND RESONANCE THERAPY')
      or ("IntermediateDecision" = 'YES FOR SPEECH FLUENCY THERAPY'))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'