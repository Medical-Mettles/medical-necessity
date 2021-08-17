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

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define NasalReconstructiveSurgeryRequest:
if exists("Request".code.coding C where C in "Nasal Reconstructive Surgery Codes")
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

define ObstructiveSleepDisorder:
  NasalSurgery."ObstructiveSleepDisorder"

define CheckObstructiveSleepDisorder:
  if ("ObstructiveSleepDisorder" = true)
    then true
      else false

define ContraindicationOfCPAP:
  NasalSurgery."ContraindicationOfCPAP"

define CheckContraindicationOfCPAP:
  if ("ContraindicationOfCPAP" = true)
    then true
      else false

define AdditionalSurgeries:
  NasalSurgery."AdditionalSurgeries"

define CheckAdditionalSurgeries:
  if ("AdditionalSurgeries" = true)
    then true
      else false

define PrimaryDecision:
      if ((("CheckNasalSeptumDeviation" = true) or ("CheckNasalObstruction" = true))
            and ("SurgeryPurposeDecision" = true)
              and ("NasalReconstructiveSurgeryRequest" = true))
        then true
          else false

define DecisionPendingForSleepDisorder:
    if (("ContraindicationOfCPAP" = false)
        or ("CheckObstructiveSleepDisorder" = false)
          or ("CheckAdditionalSurgeries" = true))
            then true
              else false

define FinalDecisionForSleepDisorder:
      if  (("PrimaryDecision" = true)
            and ("DecisionPendingForSleepDisorder" = false))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'