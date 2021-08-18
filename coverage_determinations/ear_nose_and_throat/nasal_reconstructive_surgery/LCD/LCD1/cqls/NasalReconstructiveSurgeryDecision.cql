library NasalReconstructiveSurgeryDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include NasalReconstructiveSurgery version '1.0.0' called NasalSurgery

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Nasal Reconstructive Surgery Codes": '2.16.840.1.113883.3.6037.1001.23.93.120'
valueset "Nasal Reconstructive Surgery Including Septoplasty": '2.16.840.1.113883.3.6037.1001.23.93.121'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define NasalReconstructiveSurgeryRequest:
  if exists("Request".code.coding C where C in "Nasal Reconstructive Surgery Codes")
  	    then true
	        else false

define NasalReconstructiveSurgeryWithSeptalRequest:
  if exists("Request".code.coding C where C in "Nasal Reconstructive Surgery Including Septoplasty")
  	    then true
	        else false

define SurgeryPurpose:
      NasalSurgery."SurgeryPurpose"

define SurgeryPurposeDecision:
  if ("SurgeryPurpose" = 'Reconstructive')
      then true
        else false

define NasalObstruction:
   NasalSurgery."NasalAirwayObstruction"

define CheckNasalObstruction:
  if ("NasalObstruction" = true)
      then true
        else false

define NasalSeptumDeviation:
   NasalSurgery."NasalSeptumDeviationOrDeformity"

define CheckNasalSeptumDeviation:
  if ("NasalSeptumDeviation" = true)
      then true
        else false

//Conservative Medical Therapy
define ProsthesisMedicalTherapyForSixWeeks:
  exists(NasalSurgery."ProsthesisUsageMoreThanSixWeeks")

define PostProsthesisMedicalTherapy:
  NasalSurgery."ImprovementPostProsthesis"

define AntiHistamineMedicalTherapyForSixWeeks:
  NasalSurgery."AntiHistamineTherapyForSixWeeks"

define PostAntiHistamineMedicalTherapy:
  NasalSurgery."ImprovementPostAntiHistamineMedicalTherapy"

define ImmunosuppressantsTherapyForSixWeeks:
  NasalSurgery."ImmunosuppressantsTherapyForSixWeeks"

define PostImmunosuppressantsMedicalTherapy:
  NasalSurgery."PostImmunosuppressantsMedicalTherapy"

define DecongestantsTherapyForSixWeeks:
  NasalSurgery."DecongestantsTherapyForSixWeeks"

define PostDecongestantsMedicalTherapy:
  NasalSurgery."PostDecongestantsMedicalTherapy"

define AntibioticTherapyForSixWeeks:
  NasalSurgery."AntibioticTherapyForSixWeeks"

define PostAntibioticMedicalTherapy:
  NasalSurgery."PostAntibioticMedicalTherapy"

//Congenital Defect
define CongenitalDefect:
  exists(NasalSurgery."CongenitalDeflectDiagnosis")

define FunctionalImpairment:
  exists(NasalSurgery."SecondaryFunctionalImpairmentConditions")

define CleftLipOrPalateRepair:
  NasalSurgery."ClefLipOrPalateRepair"

define CongenitalDefectPostMedicalTherapyOutcome:
  if ("PostProsthesisMedicalTherapy" = true)
      then true
        else false

define CongenitalDefectDecisionForRhinoplasty:
  if ("CongenitalDefect" = true
        and "FunctionalImpairment" = true
          and "ProsthesisMedicalTherapyForSixWeeks" = true
            and "CongenitalDefectPostMedicalTherapyOutcome" = false)
              then true
                else false

define CongenitalDefectDecisionForSeptoplasty:
  if ("CleftLipOrPalateRepair" = true
        and "ProsthesisMedicalTherapyForSixWeeks" = true
            and "CongenitalDefectPostMedicalTherapyOutcome" = false)
              then true
                else false

//Benign Disease
define BenignDiseases:
  NasalSurgery."BenignDiseasesCausingNasalObstruction"

define BenignDiseasesMedicalTherapyForSixWeeks:
  if ("ProsthesisMedicalTherapyForSixWeeks" = true
        or "ImmunosuppressantsTherapyForSixWeeks" = true
          or "DecongestantsTherapyForSixWeeks" = true
            or "AntiHistamineMedicalTherapyForSixWeeks" = true)
              then true
                else false

define BenignDiseasesPostMedicalTherapy:
  if ("PostProsthesisMedicalTherapy" = false
        or "PostAntiHistamineMedicalTherapy" = false
          or "PostImmunosuppressantsMedicalTherapy" = false
            or "PostDecongestantsMedicalTherapy" = false)
              then true
                else false

define BenignDiseaseDecision:
  if ("BenignDiseases" = true
        and "BenignDiseasesMedicalTherapyForSixWeeks" = true
          and "BenignDiseasesPostMedicalTherapy" = true)
              then true
                else false

//Trauma
define NasalTrauma:
  NasalSurgery."NasalTrauma"

define NasalFracture:
  NasalSurgery."NasalFracture"

define NasalTraumaMedicalTherapyForSixWeeks:
  if ("ProsthesisMedicalTherapyForSixWeeks" = true
        or "ImmunosuppressantsTherapyForSixWeeks" = true
          or "DecongestantsTherapyForSixWeeks" = true
            or "AntiHistamineMedicalTherapyForSixWeeks" = true)
              then true
                else false

define NasalTraumaPostMedicalTherapy:
  if ("PostProsthesisMedicalTherapy" = false
        or "PostAntiHistamineMedicalTherapy" = false
          or "PostImmunosuppressantsMedicalTherapy" = false
            or "PostDecongestantsMedicalTherapy" = false)
              then true
                else false

define NasalTraumaDecision:
  if (exists("NasalTrauma")
        and "NasalTraumaMedicalTherapyForSixWeeks" = true
          and "NasalTraumaPostMedicalTherapy" = true)
              then true
                else false

define NasalFracutreDecision:
  if exists("NasalFracture")
    then true
      else false

define TraumaDecision:
    if (("NasalTraumaDecision" = true)
          or "NasalFracutreDecision" = true)
            then true
              else false

//Vestibular Stenosis
define VestibularStenosis:
  NasalSurgery."VestibularStenosisCondition"

define VestibularStenosisMedicalTherapyForSixWeeks:
  if ("ProsthesisMedicalTherapyForSixWeeks" = true
        or "ImmunosuppressantsTherapyForSixWeeks" = true)
           then true
            else false

define VestibularStenosisPostMedicalTherapy:
  if ("PostProsthesisMedicalTherapy" = false
        or "PostImmunosuppressantsMedicalTherapy" = false)
          then true
            else false

define VestibularStenosisDecision:
  if (exists("VestibularStenosis")
        and "VestibularStenosisMedicalTherapyForSixWeeks" = true
          and "VestibularStenosisPostMedicalTherapy" = true)
              then true
                else false

//Recurrent Sinusitis
define RecurrentSinusitis:
  NasalSurgery."RecurrentSinusitisCondition"

define RecurrentSinusitisMedicalTherapy:
  if ("AntibioticTherapyForSixWeeks" = true
        or "ImmunosuppressantsTherapyForSixWeeks" = true
          or "DecongestantsTherapyForSixWeeks" = true
            or "AntiHistamineMedicalTherapyForSixWeeks" = true)
              then true
                else false

define RecurrentSinusitisPostMedicalTherapy:
  if ("PostAntibioticMedicalTherapy" = false
        or "PostAntiHistamineMedicalTherapy" = false
          or "PostImmunosuppressantsMedicalTherapy" = false
            or "PostDecongestantsMedicalTherapy" = false)
              then true
                else false

define RecurrentSinusitisDecision:
  if (exists("RecurrentSinusitis")
        and "RecurrentSinusitisMedicalTherapy" = true
          and "RecurrentSinusitisPostMedicalTherapy" = true)
              then true
                else false

//Epistaxis
define RecurrentEpistaxis:
  NasalSurgery."RecurrentEpistaxisCondition"

define RecurrentEpistaxisDecision:
  if exists("RecurrentEpistaxis")
      then true
        else false

//ObstructiveSleepDisorder
define ObstructiveSleepDisorder:
  NasalSurgery."ObstructiveSleepDisorder"


define ContraindicationOfCPAP:
  NasalSurgery."ContraindicationOfCPAP"

define CheckContraindicationOfCPAP:
  if ("ContraindicationOfCPAP" = true)
    then true
      else false

define SleepDisorderMedicalTherapyForSixWeeks:
  if ("ImmunosuppressantsTherapyForSixWeeks" = true
          or "DecongestantsTherapyForSixWeeks" = true
            or "AntiHistamineMedicalTherapyForSixWeeks" = true)
              then true
                else false

define SleepDisorderPostMedicalTherapy:
   if ("PostAntiHistamineMedicalTherapy" = false
          or "PostImmunosuppressantsMedicalTherapy" = false
            or "PostDecongestantsMedicalTherapy" = false)
              then true
                else false

define SleepDisorderDecisionForRhinoplasty:
  if ("ObstructiveSleepDisorder" = true
        and (("CongenitalDefectDecisionForRhinoplasty" = true) or ("BenignDiseaseDecision" = true)
                or ("TraumaDecision" = true) or ("VestibularStenosisDecision" = true)))
          then true
            else false

define SleepDisorderDecisionForSeptoplasty:
    if ("ObstructiveSleepDisorder" = true
          and "ContraindicationOfCPAP" = true
            and "SleepDisorderMedicalTherapyForSixWeeks" = true
              and "SleepDisorderPostMedicalTherapy" = true)
            then true
              else false

//Asymptomatic Septal Deviation
define IntranasalSurgeriesInterference:
  NasalSurgery."IntranasalSurgeriesInterference"

//Previous Septoplasty/Turbinectomy
define PreviousSeptoplastyOrTurbinectomy:
  NasalSurgery."PreviousSeptoplastyOrTurbinectomy"

define PreviousSeptoplastyOrTurbinectomyOutcome:
  NasalSurgery."SeptoplastyOrTurbinectomyOutcome"

define PreviousSurgeryDecision:
  if ("PreviousSeptoplastyOrTurbinectomy" = false)
    then true
      else if ("PreviousSeptoplastyOrTurbinectomy" = true
                and "PreviousSeptoplastyOrTurbinectomyOutcome" = false)
        then true
          else false

//Additional Surgeries
define AdditionalSurgeries:
  NasalSurgery."AdditionalSurgeries"

define CheckAdditionalSurgeries:
  if ("AdditionalSurgeries" = true)
    then true
      else false

define PrimaryDecisionForRhinoplasty:
  if ((("CongenitalDefectDecisionForRhinoplasty" = true) or ("BenignDiseaseDecision" = true)
        or ("TraumaDecision" = true) or ("VestibularStenosisDecision" = true) or ("SleepDisorderDecisionForRhinoplasty" = true))
          and "CheckNasalObstruction" = true
            and "CheckNasalSeptumDeviation" = false
              and "SurgeryPurposeDecision" = true
                and "NasalReconstructiveSurgeryRequest" = true
                  and "PreviousSurgeryDecision" = true
                    and "CheckAdditionalSurgeries" = false)
                      then true
                        else false

define PrimaryDecisionForSeptoplasty:
  if ((("CongenitalDefectDecisionForSeptoplasty" = true) or ("BenignDiseaseDecision" = true)
          or ("TraumaDecision" = true) or ("VestibularStenosisDecision" = true)
          or ("RecurrentSinusitisDecision" = true) or ("RecurrentEpistaxisDecision" = true)
          or ("SleepDisorderDecisionForSeptoplasty" = true) or ("IntranasalSurgeriesInterference" = true))
            and "CheckNasalSeptumDeviation" = true
              and "SurgeryPurposeDecision" = true
                and "NasalReconstructiveSurgeryWithSeptalRequest" = true
                  and "PreviousSurgeryDecision" = true
                    and "CheckAdditionalSurgeries" = false)
                      then true
                        else false

define FinalDecision:
      if  (("PrimaryDecisionForRhinoplasty" = true)
            or ("PrimaryDecisionForSeptoplasty" = true))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'