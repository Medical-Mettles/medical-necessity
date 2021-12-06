library SpeechLanguagePathology version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Congitive Peformance Testing Service": '2.16.840.1.113883.3.6037.1001.23.93.208'
valueset "Behavioral and qualitative analysis of voice and resonance": '2.16.840.1.113883.3.6037.1001.23.93.210'
valueset "Therapeutic interventions for cognitive function": '2.16.840.1.113883.3.6037.1001.23.93.211'
valueset "Evaluation of Speech Fluency": '2.16.840.1.113883.3.6037.1001.23.93.212'
valueset "Evaluation of Sound Production": '2.16.840.1.113883.3.6037.1001.23.93.213'
valueset "Evaluation of Language Comprehension and Expression": '2.16.840.1.113883.3.6037.1001.23.93.214'
valueset "Evaluation of Swallowing Function": '2.16.840.1.113883.3.6037.1001.23.93.215'
valueset "Evaluation of Aphasia": '2.16.840.1.113883.3.6037.1001.23.93.216'
valueset "Neurobehavioral Status Exam": '2.16.840.1.113883.3.6037.1001.23.93.217'
valueset "Evaluation of Developmental Skills": '2.16.840.1.113883.3.6037.1001.23.93.218'
valueset "Evaluation of Voice Prosthetic Usage": '2.16.840.1.113883.3.6037.1001.23.93.219'
valueset "Evaluation of Speech Generating Device": '2.16.840.1.113883.3.6037.1001.23.93.220'
valueset "Hypernasality": '2.16.840.1.113883.3.6037.1001.23.93.221'
valueset "Hyponasality": '2.16.840.1.113883.3.6037.1001.23.93.222'
valueset "Cul De Sac Resonance": '2.16.840.1.113883.3.6037.1001.23.93.223'
valueset "Nasal Complications": '2.16.840.1.113883.3.6037.1001.23.93.225'
valueset "Nasal Complications Surgery": '2.16.840.1.113883.3.6037.1001.23.93.226'
valueset "Articulation Errors": '2.16.840.1.113883.3.6037.1001.23.93.227'
valueset "Congenital Deflect Diagnosis": '2.16.840.1.113883.3.6037.1001.23.93.98'
valueset "Traumatic Injury": '2.16.840.1.113762.1.4.1029.10'
valueset "Speech Fluency Symptoms": '2.16.840.1.113883.3.6037.1001.23.93.228'
valueset "Autism Spectrum and Related Disorders": '2.16.840.1.113883.3.1240.2017.3.2.2003'
valueset "Tourette's Syndrome": '2.16.840.1.113883.3.464.1003.105.11.1170'
valueset "ADHD": '2.16.840.1.113883.3.67.1.101.1.316'
valueset "Anxiety": '2.16.840.1.113762.1.4.1021.76'
valueset "Stress": '2.16.840.1.113762.1.4.1222.1257'
valueset "Emotional Distress caused by Chronic Condition": '2.16.840.1.113762.1.4.1222.506'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'
valueset "Speech Language Pathology Services": '2.16.840.1.113883.3.6037.1001.23.93.209'
valueset "Speech Fluency Therapy": '2.16.840.1.113883.3.6037.1001.23.93.229'
valueset "Speech Language Pathology Therapy Maintenance Services": '2.16.840.1.113883.3.6037.1001.23.93.230'
valueset "Dysphonia": '2.16.840.1.113883.3.6037.1001.23.93.231'
valueset "Aphonia": '2.16.840.1.113883.3.6037.1001.23.93.232'
valueset "Laryngeal spasm": '2.16.840.1.113883.3.6037.1001.23.93.233'
valueset "Chronic Speech Fluency Disorder": '2.16.840.1.113883.3.6037.1001.23.93.234'
valueset "Speech Fluency Childhood Onset": '2.16.840.1.113883.3.6037.1001.23.93.235'
valueset "Speech Fluency Adult Onset": '2.16.840.1.113883.3.6037.1001.23.93.236'
valueset "Speech Fluency Cerebrovascular Onset": '2.16.840.1.113883.3.6037.1001.23.93.237'
valueset "Nasal Deformity": '2.16.840.1.113883.3.6037.1001.23.93.103'
valueset "Voice and Resonance Therapy": '2.16.840.1.113883.3.6037.1001.23.93.238'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define CognitivePerformanceTesting:
  "Request".code.coding C where C in "Congitive Peformance Testing Service"

define VoiceAndResonanceAnalysis:
  "Request".code.coding C where C in "Behavioral and qualitative analysis of voice and resonance"

define TherapyForCognitiveFunction:
  "Request".code.coding C where C in "Therapeutic interventions for cognitive function"

define EvaluationSpeechFluencyService:
  "Request".code.coding C where C in "Evaluation of Speech Fluency"

define EvaluationSoundProductionService:
  "Request".code.coding C where C in "Evaluation of Sound Production"

define EvaluationLanguageComprehensionService:
  "Request".code.coding C where C in "Evaluation of Language Comprehension and Expression"

define EvaluationSwallowingFunctionService:
  "Request".code.coding C where C in "Evaluation of Swallowing Function"

define EvaluationAphasiaService:
  "Request".code.coding C where C in "Evaluation of Aphasia"

define EvaluationNeurobehavioralStatusService:
  "Request".code.coding C where C in "Neurobehavioral Status Exam"

define EvaluationDevelopmentalSkillsService:
  "Request".code.coding C where C in "Evaluation of Developmental Skills"

define EvaluationProstheticUsageService:
  "Request".code.coding C where C in "Evaluation of Voice Prosthetic Usage"

define EvaluationSpeechGeneratingDevicesService:
  "Request".code.coding C where C in "Evaluation of Speech Generating Device"

define SpeechFluencyTherapyService:
  "Request".code.coding C where C in "Evaluation of Speech Generating Device"

define SpeechLanguagePathologyEvalService:
  "Request".code.coding C where C in "Speech Language Pathology Services"

define SpeechLanguagePathologyTherapyService:
    "Request".code.coding C where C in "Speech Language Pathology Therapy Maintenance Services"

define VoiceResonanceTherapyService:
    "Request".code.coding C where C in "Voice and Resonance Therapy"

define TypeOfRequest:
	if (exists("CognitivePerformanceTesting")
				or exists("VoiceAndResonanceAnalysis")
          or exists("EvaluationSpeechFluencyService")
            or exists("EvaluationSoundProductionService")
              or exists("EvaluationSwallowingFunctionService")
                or exists("EvaluationAphasiaService")
                  or exists("EvaluationNeurobehavioralStatusService")
                    or exists("EvaluationDevelopmentalSkillsService")
                      or exists("EvaluationProstheticUsageService")
                        or exists("EvaluationSpeechGeneratingDevicesService"))
                          then 'A speech language evaluation'
                            else if (exists("TherapyForCognitiveFunction")
                              or exists("SpeechFluencyTherapyService")
                                or exists("VoiceResonanceTherapyService"))
                                  then 'A speech language restorative or rehabilitative therapy'
                                    else null

define EvaluationSpeechFluency:
  if exists("EvaluationSpeechFluencyService")
    then true
      else false

define EvaluationSoundProduction:
   if exists("EvaluationSoundProductionService")
    then true
      else false

define EvaluationLanguageComprehension:
  if exists("EvaluationLanguageComprehensionService")
    then true
      else false

define BehavioralQualitativeAnalysis:
	if exists("VoiceAndResonanceAnalysis")
		then true
			else false

define EvaluationSwallowingFunction:
	if exists("EvaluationSwallowingFunctionService")
		then true
			else null

define EvaluationCognitiveFunction:
	if exists("CognitivePerformanceTesting")
		then true
			else false

define EvaluationAphasia:
	if exists("EvaluationAphasiaService")
		then true
			else false

define EvaluationNeurobehavioralStatus:
	if exists("EvaluationNeurobehavioralStatusService")
			then true
				else false

define EvaluationDevelopmentalSkills:
	if exists("EvaluationDevelopmentalSkillsService")
		then true
			else false

define EvaluationProstheticUsage:
	if exists("EvaluationProstheticUsageService")
		then true
			else false

define EvaluationSpeechGeneratingDevices:
		if exists("EvaluationSpeechGeneratingDevicesService")
				then true
					else null

define HypernasalityCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Hypernasality")
      and First(C.clinicalStatus.coding).code.value = 'active'

define HyponasalityCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Hyponasality")
      and First(C.clinicalStatus.coding).code.value = 'active'

define CulDeSacResonanceCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Cul De Sac Resonance")
      and First(C.clinicalStatus.coding).code.value = 'active'

define MixedResonanceCondition:
  if (exists("HypernasalityCondition")
    and exists("HyponasalityCondition")
      and exists("CulDeSacResonanceCondition"))
        then true
          else false

define VoiceResonanceSymptoms:
  if (exists("HypernasalityCondition")
    or exists("HyponasalityCondition")
      or exists("CulDeSacResonanceCondition"))
        then true
          else false

define SpecifyVoiceResonanceSymptoms:
  if exists("HypernasalityCondition")
    then 'Hypernasality'
      else if exists("HyponasalityCondition")
        then 'Hyponasality'
          else if exists("CulDeSacResonanceCondition")
            then 'Cul-de-sac resonance'
              else if ("MixedResonanceCondition" = true)
                then 'Mixed resonance'
                  else null

define VoiceResonanceCausedByDisease:
	exists([Condition]C
    where exists(C.code.coding C where C in "Nasal Complications")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define VoiceResonanceUnwantedResult:
	exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Nasal Complications Surgery")

define ArticulationErrors:
	exists([Condition]C
    where exists(C.code.coding C where C in "Articulation Errors")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define CongenitalDefectCause:
  exists([Condition]C
    where exists(C.code.coding C where C in "Congenital Deflect Diagnosis")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define TraumaCause:
  exists([Condition]C
    where exists(C.code.coding C where C in "Traumatic Injury")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define PrevHypernasalityCondition:
  exists([Condition]C
    where exists(C.code.coding C where C in "Hypernasality")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
          and "Normalize Interval"(C.onset) after (Today()-60 days))

define PrevHyponasalityCondition:
  exists([Condition]C
    where exists(C.code.coding C where C in "Hyponasality")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
          and "Normalize Interval"(C.onset) after (Today()-60 days))

define PreviousCulDeSacResonanceCondition:
  exists([Condition]C
    where exists(C.code.coding C where C in "Cul De Sac Resonance")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
          and "Normalize Interval"(C.onset) after (Today()-60 days))

define StutteringClutteringSymptoms:
  exists([Condition]C
    where exists(C.code.coding C where C in "Speech Fluency Symptoms")
      and First(C.clinicalStatus.coding).code.value = 'active')

define ConditionPreviousHistoryVoiceResonance:
 if ("PrevHypernasalityCondition" = true and exists("HypernasalityCondition"))
      or ("PrevHyponasalityCondition" = true and exists("HyponasalityCondition"))
        or ("PreviousCulDeSacResonanceCondition" = true and exists("CulDeSacResonanceCondition"))
          then true
            else false

define ConditionPreviousHistorySpeechFluency:
 exists([Condition]C
    where exists(C.code.coding C where C in "Speech Fluency Symptoms")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
          and "Normalize Interval"(C.onset) after (Today()-60 days))

define ConditionPreviousHistory:
  if ("ConditionPreviousHistoryVoiceResonance" = true
        or "ConditionPreviousHistorySpeechFluency" = true)
    then true
      else false

define SpeechInfluencyByAutism:
  exists([Condition]C
    where exists(C.code.coding C where C in "Autism Spectrum and Related Disorders")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechInfluencyByTourette:
  exists([Condition]C
    where exists(C.code.coding C where C in "Tourette's Syndrome")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechInfluencyByADHD:
  exists([Condition]C
    where exists(C.code.coding C where C in "ADHD")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechConditionCausedByDisease:
  if ("SpeechInfluencyByAutism" = true
        or "SpeechInfluencyByTourette" = true
          or "SpeechInfluencyByADHD" = true)
            then true
              else false

define SpecifyDiseaseCausingSpeechCondition:
  if ("SpeechInfluencyByAutism" = true)
    then 'Autism Spectrum Disorder'
      else if ("SpeechInfluencyByTourette" = true)
        then 'Tourette Syndrome'
          else if ("SpeechInfluencyByADHD" = true)
            then 'Attention Deficit or Hyperactivity Disorder'
              else null

define SpeechConditionCausedByStress:
  exists([Condition]C
    where (exists(C.code.coding C where C in "Anxiety")
            or exists(C.code.coding C where C in "Stress")
            or exists(C.code.coding C where C in "Emotional Distress caused by Chronic Condition"))
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define EncounterResource:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value )

define FacetoFaceEncounter:
	"EncounterResource" F2FEncounter
	where First(First(F2FEncounter.type).coding) in "Face to Face Encounter"

define FToFEncounter:
	if ("FacetoFaceEncounter" is not null)
	then true
	else false

define EvaluationSpeechFluencyProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Speech Fluency")

define CognitivePerformanceTestingProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Congitive Peformance Testing Service")

define VoiceAndResonanceAnalysisProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Behavioral and qualitative analysis of voice and resonance")

define EvaluationSoundProductionProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Sound Production")

define EvaluationLanguageComprehensionProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Language Comprehension and Expression")

define EvaluationSwallowingFunctionProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Swallowing Function")

define EvaluationAphasiaProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Aphasia")

define EvaluationNeurobehavioralStatusProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Neurobehavioral Status Exam")

define EvaluationDevelopmentalSkillsProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Developmental Skills")

define EvaluationProstheticUsageProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Voice Prosthetic Usage")

define EvaluationSpeechGeneratingDevicesProcedure:
  exists([Procedure]P
          where P.status.value = 'completed'
		        and First(P.code.coding) in "Evaluation of Speech Generating Device")

define EarlierEvaluationsDone:
  if ("EvaluationSpeechFluencyProcedure" = true)
    then 'Evaluation of speech fluency'
      else if ("CognitivePerformanceTestingProcedure" = true)
        then 'Standardized cognitive performance testing'
          else if ("VoiceAndResonanceAnalysisProcedure" = true)
            then 'Behavioral and qualitative analysis of voice and resonance'
              else if ("EvaluationSoundProductionProcedure" = true or ("EvaluationLanguageComprehensionProcedure" = true))
                then 'Evaluation of sound production'
                  else if ("EvaluationSwallowingFunctionProcedure" = true)
                    then 'Clinical evaluation of swallowing function'
                      else if ("EvaluationAphasiaProcedure" = true)
                        then 'Evaluation and assessment of aphasia'
                          else if ("EvaluationNeurobehavioralStatusProcedure" = true)
                            then 'Neurobehavioral status exam'
                              else if ("EvaluationDevelopmentalSkillsProcedure" = true)
                                then 'Developmental testing'
                                  else if ("EvaluationProstheticUsageProcedure" = true)
                                    then 'Evaluation for use or fitting of a voice prosthetic'
                                      else if ("EvaluationSpeechGeneratingDevicesProcedure" = true)
                                        then 'Evaluation or re-evaluation for the usage of speech generating devices'
                                          else ''

define SpeechFluencyDisorder:
  exists([Condition]C
    where exists(C.code.coding C where C in "Speech Fluency Symptoms")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define ChronicSpeechFluencyDisorder:
  exists([Condition]C
    where exists(C.code.coding C where C in "Chronic Speech Fluency Disorder")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechFluencyDisorderPattern:
  if ("ChronicSpeechFluencyDisorder" = true)
    then 'Continuous'
      else if ("SpeechConditionCausedByStress" = true)
        then 'Variable'
          else ''

define SpeechFluencyDisorderDuration:
  if ("SpeechConditionCausedByDisease" = true)
    then 'Permanent'
      else if ("SpeechConditionCausedByStress" = true)
        then 'Temporary'
          else ''

define SpeechInfluencyChildhoodOnset:
  exists([Condition]C
    where exists(C.code.coding C where C in "Speech Fluency Childhood Onset")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechInfluencyAdultOnset:
  exists([Condition]C
    where exists(C.code.coding C where C in "Speech Fluency Adult Onset")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechInfluencyCerebrovascularOnset:
  exists([Condition]C
    where exists(C.code.coding C where C in "Speech Fluency Cerebrovascular Onset")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define SpeechFluencyDisorderCause:
  if ("SpeechInfluencyChildhoodOnset" = true)
    then 'Childhood onset'
      else if ("SpeechInfluencyAdultOnset" = true)
        then 'Adult onset'
          else if ("SpeechInfluencyCerebrovascularOnset" = true)
            then 'Fluency disorder following cerebrovascular disease/ trauma'
              else ''

define HypernasalityConditionConfirmed:
  [Condition]C
    where exists(C.code.coding C where C in "Hypernasality")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define HyponasalityConditionConfirmed:
  [Condition]C
    where exists(C.code.coding C where C in "Hyponasality")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define CulDeSacResonanceConditionConfirmed:
  [Condition]C
    where exists(C.code.coding C where C in "Cul De Sac Resonance")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define DysphoniaCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Dysphonia")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define AphoniaCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Aphonia")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define LaryngealSpasmCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Laryngeal spasm")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define VoiceResonanceDisorder:
  if (exists("HypernasalityConditionConfirmed") or exists("HyponasalityConditionConfirmed")
        or exists("HyponasalityConditionConfirmed") or exists("DysphoniaCondition")
          or exists("AphoniaCondition") or exists("LaryngealSpasmCondition"))
            then true
              else false

define SpecifyVoiceResonanceDisorder:
 if exists("HypernasalityConditionConfirmed")
    then 'Hypernasality'
      else if exists("HyponasalityConditionConfirmed")
        then 'Hyponasality'
          else if exists("DysphoniaCondition")
            then 'Dysphonia'
              else if exists("AphoniaCondition")
                then 'Aphonia'
                  else if exists("LaryngealSpasmCondition")
                    then 'Laryngospasm'
                      else ''

define VoiceResonanceCausedByDeformity:
	exists([Condition]C
    where exists(C.code.coding C where C in "Nasal Deformity")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define VoiceResonanceDisorderCause:
  if ("VoiceResonanceCausedByDeformity" = true)
    then 'Structural deformity/ disorder'
      else if ("ArticulationErrors" = true)
        then 'Misarticulation'
          else ''

define RequiredTherapy:
  if (exists("SpeechLanguagePathologyTherapyService") and ("SpeechFluencyDisorder" = true))
    then 'Speech fluency therapy'
      else if (exists("SpeechLanguagePathologyTherapyService") and ("VoiceResonanceDisorder" = true))
        then 'Voice and resonance therapy'
          else ''

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.date, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
	if onset is FHIR.date then
	  Interval[ToDateTime(onset as FHIR.date), ToDateTime(onset as FHIR.date)]
        else if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null
