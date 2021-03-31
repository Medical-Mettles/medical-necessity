library BreastsCancerChemoDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BreastsCancerChemo version '1.0.0' called BCChemo

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Breast Cancer": '2.16.840.1.113883.3.1434.1000.1095'
valueset "Estrogen Receptor Positive": '2.16.840.1.113762.1.4.1116.320'
valueset "Breast Cancer ER or PR Positive": '2.16.40.1.113883.3.526.2.1387'
valueset "Breast Cancer Primary Tumor Size T1": '2.16.840.1.113883.3.526.3.1305'
valueset "Breast Cancer Primary Tumor Size T1a": '2.16.840.1.113883.3.526.3.1164'
valueset "Breast Cancer Regional Lymph Node Status N0": '2.16.840.1.113883.3.526.3.1310'
valueset "Breast Distant Metastasis Status M0": '2.16.840.1.113883.3.526.3.1302'
valueset "HER2 Presence in Tissue": '2.16.840.1.113883.3.1444.5.207'
valueset "Docetaxel, Carboplatin and Trastuzumab Chemotherapy drugs": '2.16.840.1.113883.3.6037.1001.23.96.13'
valueset "Chemotherapy drugs allergy": '2.16.840.1.113883.3.6037.1001.23.96.14'
valueset "Cardiac Disease": '2.16.840.1.113762.1.4.1029.341'
valueset "Chronic Obstructive Pulmonary Diseases": '2.16.840.1.113883.17.4077.3.2063'
valueset "Liver Disease": '	2.16.840.1.113762.1.4.1047.42'
valueset "Renal Disease": '2.16.840.1.113762.1.4.1029.335'
valueset "Bleeding Disorder": '2.16.840.1.113762.1.4.1029.287'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Progesterone receptor": '2.16.840.1.113883.3.6037.1001.23.96.16'
valueset "Estrogen receptor": '2.16.840.1.113883.3.6037.1001.23.96.15'
valueset "Neutrophil": '2.16.840.1.113883.3.6037.1001.23.96.17'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Breasts BodySite": '2.16.840.1.113883.3.6037.1001.23.96.18'
valueset "Left breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.19'
valueset "Right breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.20'
valueset "Bilateral breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.21'
valueset "Docetaxel": '2.16.840.1.113883.3.6037.1001.23.94.24'
valueset "Trastuzumab": '2.16.840.1.113883.3.6037.1001.23.94.25'
valueset "Carboplatin": '2.16.840.1.113883.3.6037.1001.23.94.26'
valueset "ado-trastuzumab emtansine": '2.16.840.1.113883.3.6037.1001.23.94.27'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "MedicationRequest" MedicationRequest
parameter "suggest_biosimilar" Boolean

context Patient

define BreastCancerCondition:
      BCChemo."BreastCancerCondition"

define BreastCancerStaging:
      BCChemo."BreastCancerStaging"

define pTStage:
      BCChemo."pTStage"

define pNStagePathological:
      BCChemo.pNStagePathological

define pMStagePathological:
      BCChemo.pMStagePathological

define CancerStage:
      if (("pTStage" = 'T1') and ("pNStagePathological" = 'N0') and ("pMStagePathological" = 'M0'))
      then true
      else false

define HER2Observation:
      BCChemo."HER2Observation"

define PRObservation:
      BCChemo."PRObservation"

define ERObservation:
      BCChemo."ERObservation"

define NeutrophilObservation:
      BCChemo."NeutrophilObservation"

define NeutrophilResult:
	   BCChemo."NeutrophilResult"

define ChemoDrugsAdministration:
      BCChemo."ChemoDrugsAdministration"

define ChemoDrugsAllergy:
      BCChemo."ChemoDrugsAllergy"

define CardiacConditions:
      BCChemo."CardiacConditions"

define LiverConditions:
      BCChemo."LiverConditions"

define RenalConditions:
      BCChemo."RenalConditions"

define PreExistingConditions:
      BCChemo."PreExistingConditions"

define PulmonaryConditionsHistory:
      BCChemo."PulmonaryConditionsHistory"

define BleedingConditions:
      BCChemo."BleedingConditions"

define TumorSizeObservation:
      BCChemo."TumorSizeObservation"

define TumourSize:
      BCChemo."TumourSize"

define DocetaxelMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "Docetaxel"

define CarboplatinMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "Carboplatin"

define TrastuzumabMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "Trastuzumab"

define adoTrastuzumabMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "ado-trastuzumab emtansine"

define BiosimilarDrugSuggestion:
      "suggest_biosimilar"

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define IsERPositive:
	   ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '3.1')QR
		      return First(QR.answer).value

define IsPRPositive:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '3.2')QR
		      return First(QR.answer).value

define IsHER2Positive:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '3.3')QR
		      return First(QR.answer).value

define KnownAllergiesBoolean:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '5.1')QR
		      return First(QR.answer).value

define LineOfTherapy:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '4.1')QR
		      return First(QR.answer).value

define PreExistingConditionsBoolean:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.4')QR
		      return First(QR.answer).value

define ConditionsManagementBoolean:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.5')QR
		      return First(QR.answer).value

define PulmonaryDiseaseHistory:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.7')QR
		   return First(QR.answer).value

define IsPulmonaryDiseaseManaged:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.8')QR
		      return First(QR.answer).value

define BleedingDisorderBoolean:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.1')QR
		      return First(QR.answer).value

define IsBleedingDisorderManaged:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.2')QR
		      return First(QR.answer).value

define NeutrophilLessThan1500:
    ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.3')QR
		      return First(QR.answer).value

define ChemoNotNeeded:
    if (
        ((First("IsERPositive") = true)
            and (First("IsPRPositive")= true)
               and (First("IsHER2Positive")= true)
                  and (First("LineOfTherapy") >1))
         or
         ((First("IsERPositive") = false)
            or (First("IsPRPositive")= false)
               or (First("IsHER2Positive")= false))
         or
         ("CancerStage" = false)
        )
        then true
        else false

define TrastuzumabFinalDecision:
      if (("ChemoNotNeeded" = false)
            and ("TrastuzumabMedication" = true)
                  and (First("IsERPositive") = true)
                     and (First("IsPRPositive")= true)
                        and (First("IsHER2Positive")= true)
                           and (First("LineOfTherapy")= 1)
                              and ("CancerStage" = true))
                                          then true
                                          else false

define adoTrastuzumabFinalDecision:
      if (("ChemoNotNeeded" = false)
            and (First("IsERPositive") = true)
               and (First("IsPRPositive")= true)
                  and (First("IsHER2Positive")= true)
                     and (First("LineOfTherapy")= 1)
                        and ("CancerStage" = true))
                                    then true
                                    else false

define DocetaxelFinalDecision:
      if (("ChemoNotNeeded" = false)
            and ("DocetaxelMedication" = true)
                  and (First("IsERPositive") = true)
                     and (First("IsPRPositive")= true)
                        and (First("IsHER2Positive")= true)
                           and (First("LineOfTherapy")= 1)
                              and ("CancerStage" = true))
      then true
      else false


define CarboplatinFinalDecision:
      if (("ChemoNotNeeded" = false)
         and ("CarboplatinMedication" = true)
               and  (First("IsERPositive") = true)
                  and  (First("IsPRPositive")= true)
                     and  (First("IsHER2Positive")= true)
                        and  (First("LineOfTherapy")= 1)
                           and ("CancerStage" = true))
         then true
         else false

define PrimaryDecision:
      if (
               (("TrastuzumabFinalDecision" = true) and ("TrastuzumabMedication" = true))
            or 
               (("DocetaxelFinalDecision" = true) and ("DocetaxelMedication" = true))
            or 
               (("CarboplatinFinalDecision" = true) and ("CarboplatinMedication" = true))
         )
      then true
      else false

define "ado-transtuzumabConsideration":
      if (("adoTrastuzumabFinalDecision" = true) and ("adoTrastuzumabMedication" = true))
            then 'As per NCCN Guidelines Ado-transtuzumab emtansine is not approved for adjuvant therapy for the first line of therapy. Please check pathology report.'
            else null

define FinalDecision:
      if 
         (("TrastuzumabFinalDecision" = true) and ("TrastuzumabMedication" = true) and ("BiosimilarDrugSuggestion"= true) )
      then 'HUMAN REVIEW NEEDED'
         else if
               (("adoTrastuzumabFinalDecision" = true) and ("adoTrastuzumabMedication" = true))
            then 'HUMAN REVIEW NEEDED. PATHOLOGY REPORT TO BE REVIEWED'
               else if 
                  (("PrimaryDecision" = true))
                     then 'YES'
                  else if 
                        ("ChemoNotNeeded" = true)
                              then 'NO'
                        else
                              'HUMAN REVIEW NEEDED'

