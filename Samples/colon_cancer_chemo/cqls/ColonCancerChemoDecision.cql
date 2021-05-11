library ColonCancerChemoDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ColonCancerChemo version '1.0.0' called ColonChemo

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Oxaliplatin": '2.16.840.1.113883.3.6037.1001.23.93.34'
valueset "Folinic acid": '2.16.840.1.113883.3.6037.1001.23.93.35'
valueset "5-fluorouracil": '2.16.840.1.113883.3.6037.1001.23.93.36'
valueset "Folinic acid, 5-fluorouracil and Oxaliplatin Chemotherapy drugs": '2.16.840.1.113883.3.6037.1001.23.93.30'



parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "MedicationRequest" MedicationRequest


context Patient

define ColonCancerCondition:
      ColonChemo."ColonCancerCondition"

define ColonCancerStaging:
      ColonChemo."ColonCancerStaging"

define OxaliplatinMedication:
     First(("MedicationRequest".medication as CodeableConcept).coding) in "Oxaliplatin"

define FolinicAcidMedication:
    First(("MedicationRequest".medication as CodeableConcept).coding) in "Folinic acid"

define FluorouracilMedication:
      First(("MedicationRequest".medication as CodeableConcept).coding) in "5-fluorouracil"

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define TStageT3:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '1.2')QR
		      return First(QR.answer).value

define NStageN1b:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '1.3')QR
		      return First(QR.answer).value

define MStageM0:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '1.4')QR
		      return First(QR.answer).value

define CancerStage:
      if ((First("TStageT3") = 'T3')
        and (First("NStageN1b") = 'N1b')
        and (First("MStageM0") = 'M0'))
      then true
      else false

define ChemoNotNeeded:
    if ("CancerStage" = false)
        then true
        else false

define PrimaryDecision:
      if (("OxaliplatinMedication" = true)
          or ("FolinicAcidMedication" = true )
          or ("FluorouracilMedication" = true )
         )
      then true
      else false

define FinalDecision:
      if
          (("PrimaryDecision" = true)
            and ("ChemoNotNeeded" = false))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'



