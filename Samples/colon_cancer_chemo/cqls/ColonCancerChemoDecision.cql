library ColonCancerChemoDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ColonCancerChemo version '1.0.0' called ColonChemo

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Colon Cancer": '2.16.840.1.113883.3.526.3.391'
valueset "Colon Cancer Primary Tumor Size T3": '2.16.840.1.113883.3.526.3.1294'
valueset "Colon Cancer Regional Lymph Node Status N1b": '2.16.840.1.113883.3.526.3.1328'
valueset "Colon Distant Metastasis Status M0": '2.16.840.1.113883.3.526.3.1337'
valueset "Colon Tumor Stage TX": '2.16.840.1.113883.3.6037.1001.23.93.22'
valueset "Colon Tumor Stage T0": '2.16.840.1.113883.3.6037.1001.23.93.21'
valueset "Colon Tumor Stage Tis": '2.16.840.1.113883.3.6037.1001.23.93.01'
valueset "Colon Tumor Stage T1": '2.16.840.1.113883.3.6037.1001.23.93.02'
valueset "Colon Tumor Stage T2": '2.16.840.1.113883.3.6037.1001.23.93.03'
valueset "Colon Tumor Stage T3": '2.16.840.1.113883.3.6037.1001.23.93.04'
valueset "Colon Tumor Stage T4a": '2.16.840.1.113883.3.6037.1001.23.93.05'
valueset "Colon Tumor Stage T4b": '2.16.840.1.113883.3.6037.1001.23.93.06'
valueset "Colon Regional Lymph Nodes NX": '2.16.840.1.113883.3.6037.1001.23.93.07'
valueset "Colon Regional Lymph Nodes N0": '2.16.840.1.113883.3.6037.1001.23.93.08'
valueset "Colon Regional Lymph Nodes N1": '2.16.840.1.113883.3.6037.1001.23.93.09'
valueset "Colon Regional Lymph Nodes N1a": '2.16.840.1.113883.3.6037.1001.23.93.10'
valueset "Colon Regional Lymph Nodes N1b": '2.16.840.1.113883.3.6037.1001.23.93.11'
valueset "Colon Regional Lymph Nodes N1c": '2.16.840.1.113883.3.6037.1001.23.93.12'
valueset "Colon Regional Lymph Nodes N2": '2.16.840.1.113883.3.6037.1001.23.93.13'
valueset "Colon Regional Lymph Nodes N2a": '2.16.840.1.113883.3.6037.1001.23.93.14'
valueset "Colon Regional Lymph Nodes N2b": '2.16.840.1.113883.3.6037.1001.23.93.15'
valueset "Colon Metastasis Stage M0": '2.16.840.1.113883.3.6037.1001.23.93.16'
valueset "Colon Metastasis Stage M1": '2.16.840.1.113883.3.6037.1001.23.93.17'
valueset "Colon Metastasis Stage M1a": '2.16.840.1.113883.3.6037.1001.23.93.18'
valueset "Colon Metastasis Stage M1b": '2.16.840.1.113883.3.6037.1001.23.93.19'
valueset "Colon Metastasis Stage M1c": '2.16.840.1.113883.3.6037.1001.23.93.20'
valueset "Stage type Pathological": '2.16.840.1.113883.3.6037.1001.23.96.24'
valueset "Stage type Clinical": '2.16.840.1.113883.3.6037.1001.23.96.23'
valueset "MMR Deficiency Test": '2.16.840.1.113883.3.6037.1001.23.93.23'
valueset "MSI Test": '2.16.840.1.113883.3.6037.1001.23.93.24'
valueset "CEA Level In Blood": '2.16.840.1.113883.3.6037.1001.23.93.25'
valueset "KRAS Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.26'
valueset "NRAS Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.27'
valueset "BRAF Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.28'
valueset "Neutrophil": '2.16.840.1.113883.3.6037.1001.23.96.17'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Sigmoid Colectomy": '2.16.840.1.113883.3.6037.1001.23.93.29'
valueset "Folinic acid, 5-fluorouracil and Oxaliplatin Chemotherapy drugs": '2.16.840.1.113883.3.6037.1001.23.93.30'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "FOLFOX Chemotherapy drugs allergy": '2.16.840.1.113883.3.6037.1001.23.93.31'
valueset "DPD Condition": '2.16.840.1.113883.3.6037.1001.23.93.32'
valueset "Vit B12 Deficiency": '2.16.840.1.113883.3.6037.1001.23.93.33'
valueset "Oxaliplatin": '2.16.840.1.113883.3.6037.1001.23.93.34'
valueset "Folinic acid": '2.16.840.1.113883.3.6037.1001.23.93.35'
valueset "5-fluorouracil": '2.16.840.1.113883.3.6037.1001.23.93.36'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Negative Result": '2.16.840.1.113762.1.4.1116.292'


parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "MedicationRequest" MedicationRequest
parameter "suggest_biosimilar" Boolean

context Patient

define ColonCancerCondition:
      ColonChemo."ColonCancerCondition"

define ColonCancerStaging:
      ColonChemo."ColonCancerStaging"

define TStage:
      ColonChemo."TStage"

define NStage:
      ColonChemo."NStage"

define MStage:
      ColonChemo."MStage"

define CancerStage:
      if (("TStage" = 'T3') and ("NStage" = 'N1b') and ("MStage" = 'M0'))
      then true
      else false

define MMRDeficiencyObservation:
      ColonChemo."MMRDeficiencyObservation"

define MMRDeficiency:
      ColonChemo."MMRDeficiency"

define MicrosatelliteInstabilityObservation:
      ColonChemo."MicrosatelliteInstabilityObservation"

define MISResult:
      ColonChemo."MISResult"

define CEALevelInBloodObservation:
      ColonChemo."CEALevelInBloodObservation"

define CEALevelInBloodResult:
      ColonChemo."CEALevelInBloodResult"

define CEALevelInBlood:
      ColonChemo."CEALevelInBlood"

define NRASMutation:
      ColonChemo."NRASMutation"

define BRAFMutation:
      ColonChemo."BRAFMutation"

define TumorGenomicsObservations:
      ColonChemo."TumorGenomicsObservations"

define TumorGenomics:
      ColonChemo."TumorGenomics"

define NeutrophilObservation:
      ColonChemo."NeutrophilObservation"

define NeutrophilResult:
	   ColonChemo."NeutrophilResult"

define ChemoDrugsAdministration:
      ColonChemo."ChemoDrugsAdministration"

define ChemoDrugsAllergy:
      ColonChemo."ChemoDrugsAllergy"

define TumorSizeObservation:
      ColonChemo."TumorSizeObservation"

define TumorSize:
      ColonChemo."TumorSize"

define OxaliplatinMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "Oxaliplatin"

define FolinicAcidMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "Folinic acid"

define FluorouracilMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "5-fluorouracil"

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define TumorGenomicsPositive:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '3.2')QR
		      return First(QR.answer).value

define NeutrophilLessThan1500:
    ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '5.1')QR
		      return First(QR.answer).value

define ChemoNotNeeded:
    if ((First("TumorGenomicsPositive") = "BRAF")
         or
        ("CancerStage" = false)
        )
        then true
        else false

define PrimaryDecision:
      if (
               ("OxaliplatinMedication" = true)
            or
               ("FolinicAcidMedication" = true)
            or
               ("FluorouracilMedication" = true)
         )
      then true
      else false

define FinalDecision:
      if
          (("PrimaryDecision" = true))
              then 'YES'
                  else if
                        ("ChemoNotNeeded" = true)
                              then 'HUMAN REVIEW NEEDED'


