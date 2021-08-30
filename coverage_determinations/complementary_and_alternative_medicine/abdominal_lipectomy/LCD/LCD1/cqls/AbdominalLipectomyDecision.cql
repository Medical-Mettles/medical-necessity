library AbdominalLipectomyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include AbdominalLipectomy version '1.0.0' called AL

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Panniculectomy": '2.16.840.1.113883.3.6037.1001.23.99.80'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define PanniculectomySurgeryRequest:
  if exists("Request".code.coding C where C in "Panniculectomy")
  	    then true
	        else false

define SurgeryPurpose:
      AL."SurgeryPurpose"

define SurgeryPurposeDecision:
  if ("SurgeryPurpose" = 'Reconstructive')
      then true
        else false

define PatientValidAge:
   AL."PatientAgeAboveEighteen"

define BariatricSurgery:
   AL."BariatricSurgery"

define StableWeightForSixMonths:
  AL."StableWeightForSixMonths"

define AboveEighteenMonthsPostSurgery:
  AL."AboveEighteenMonthsPostSurgery"

define Debridement:
  AL."Debridement"

define ConservativeMedicalTherapy:
  AL."ConservativeMedicalTherapy"

define ConservativeTherapyForTwelveWeeks:
  AL."ConservativeTherapyForTwelveWeeks"

define PostConservativeTherapyImprovement:
  AL."PostConservativeTherapyImprovement"

define VentralHerniaScreening:
  AL."VentralHerniaScreening"

define PrimaryDecision:
  if ("PanniculectomySurgeryRequest" = true
        and "SurgeryPurposeDecision" = true
          and "PatientValidAge" = true)
            then true
              else false

define WeightLossDecision:
   if ("BariatricSurgery" = true
        and "StableWeightForSixMonths" = true
          and "AboveEighteenMonthsPostSurgery" = true)
            then true
              else false

define ConservativeTherapyDecision:
   if ("ConservativeMedicalTherapy" = true
          and "ConservativeTherapyForTwelveWeeks" = true
            and "PostConservativeTherapyImprovement" = false)
              then true
                else false

define DecisionPending:
  if "WeightLossDecision" = false
        or ("Debridement" = false and "ConservativeTherapyDecision" = false)
          then true
            else false

define FinalDecision:
      if  "PrimaryDecision" = true
            and "DecisionPending" = false
              then 'YES'
                else 'HUMAN REVIEW NEEDED'