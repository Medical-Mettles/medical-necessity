library RheumaticDrugTherapyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include RheumaticDrugTherapy version '1.0.0' called RDT

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "Etanercept Medication": '2.16.840.1.113883.3.6037.1001.23.93.245'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "MedicationRequest" MedicationRequest

context Patient

define EtanerceptMedicationRequest:
  First(("MedicationRequest".medication as CodeableConcept).coding) in "Etanercept Medication"

define QT:
	"QuestionnaireResponse".item

define PsoriaticArthritisResponse:
  ("QT".item I
		where I.linkId.value = 'PsoriaticArthritis')QR
		return First(QR.answer).value

define PsoriaticArthritisCondition:
  RDT."PsoriaticArthritis"

define PsoriaticArthritis:
  Coalesce(First("PsoriaticArthritisResponse"), "PsoriaticArthritisCondition")

define RheumatoidArthritisResponse:
	("QT".item I
		where I.linkId.value = 'RheumatoidArthritis')QR
		return First(QR.answer).value

define RheumatoidArthritisCondition:
      RDT."RheumatoidArthritis"

define RheumatoidArthritis:
  Coalesce(First("RheumatoidArthritisResponse"), "RheumatoidArthritisCondition")

define AnkylosingSpondylitisResponse:
  ("QT".item I
		where I.linkId.value = 'AnkylosingSpondylitis')QR
		return First(QR.answer).value

define AnkylosingSpondylitisCondition:
   RDT."AnkylosingSpondylitis"

define AnkylosingSpondylitis:
  Coalesce(First("AnkylosingSpondylitisResponse"), "AnkylosingSpondylitisCondition")

define PlaquePsoriasisResponse:
  ("QT".item I
		where I.linkId.value = 'PlaquePsoriasis')QR
		return First(QR.answer).value

define PlaquePsoriasisCondition:
   RDT."PlaquePsoriasis"

define PlaquePsoriasis:
  Coalesce(First("PlaquePsoriasisResponse"), "PlaquePsoriasisCondition")

define PrimaryDiagnosisDecision:
  if (("PsoriaticArthritis" = true)
        or ("RheumatoidArthritis" = true)
          or ("AnkylosingSpondylitis" = true)
            or ("PlaquePsoriasis" = true))
              then true
                else false

define RheumatoidFactorTestResponse:
  ("QT".item I
		where I.linkId.value = 'RheumatoidFactorTest')QR
		return First(QR.answer).value

define RheumatoidFactorTestObservation:
  RDT."RheumatoidFactorTest"

define RheumatoidFactorTest:
  Coalesce(First("RheumatoidFactorTestResponse"), "RheumatoidFactorTestObservation")

define RheumatoidFactorTestResultResponse:
  ("QT".item I
		where I.linkId.value = 'RheumatoidFactorTestResult')QR
		return First(QR.answer).value

define RheumatoidFactorTestResultObservation:
  RDT."RheumatoidFactorTestResult"

define RheumatoidFactorTestResult:
    Coalesce(First("RheumatoidFactorTestResultResponse"), "RheumatoidFactorTestResultObservation")

define AntiCCPTestResponse:
  ("QT".item I
		where I.linkId.value = 'AntiCCPTest')QR
		return First(QR.answer).value

define AntiCCPTestObservation:
  RDT."AntiCCPTest"

define AntiCCPTest:
  Coalesce(First("AntiCCPTestResponse"), "AntiCCPTestObservation")

define AntiCCPTestResultResponse:
  ("QT".item I
		where I.linkId.value = 'AntiCCPTestResult')QR
		return First(QR.answer).value

define AntiCCPTestResultObservation:
  RDT."AntiCCPTestResult"

define AntiCCPTestResult:
  Coalesce(First("AntiCCPTestResultResponse"), "AntiCCPTestResultObservation")

define BiomarkersDecision:
  if (("RheumatoidFactorTestResult" = true)
        or ("AntiCCPTestResult" = true))
              then true
                else false

define PastConventionalDMARDTherapyResponse:
  ("QT".item I
		where I.linkId.value = 'PastConventionalDMARDTherapy')QR
		return First(QR.answer).value

define PastConventionalDMARDTherapyProc:
  RDT."PastConventionalDMARDTherapy"

define PastConventionalDMARDTherapy:
    Coalesce(First("PastConventionalDMARDTherapyResponse"), "PastConventionalDMARDTherapyProc")

define PastConventionalDMARDTherapyDurationResponse:
  ("QT".item I
		where I.linkId.value = 'PastConventionalDMARDTherapyDuration')QR
		return First(QR.answer).value

define PastConventionalDMARDTherapyDurationProc:
  RDT."PastConventionalDMARDTherapyDuration"

define "PastConventionalDMARDTherapyDuration":
  Coalesce(First("PastConventionalDMARDTherapyDurationResponse"), "PastConventionalDMARDTherapyDurationProc")

define PastConventionalDMARDTherapyOutcomeResponse:
  ("QT".item I
		where I.linkId.value = 'ThyroidEyeCondition')QR
		return First(QR.answer).value

define PastConventionalDMARDTherapyOutcomeProc:
    RDT."PastConventionalDMARDTherapyOutcome"

define PastConventionalDMARDTherapyOutcome:
  Coalesce(First("PastConventionalDMARDTherapyOutcomeResponse"), "PastConventionalDMARDTherapyOutcomeProc")

define ContraindicationDMARDTherapyResponse:
  ("QT".item I
		where I.linkId.value = 'ContraindicationDMARDTherapy')QR
		return First(QR.answer).value

define ContraindicationDMARDTherapyProc:
  RDT."ContraindicationDMARDTherapy"

define ContraindicationDMARDTherapy:
    Coalesce(First("ContraindicationDMARDTherapyResponse"), "ContraindicationDMARDTherapyProc")

define DMARDTherapyDecision:
  if ((("PastConventionalDMARDTherapy" = true) and ("PastConventionalDMARDTherapyDuration" = true)
          and "PastConventionalDMARDTherapyOutcome" = false)
            or "ContraindicationDMARDTherapy" = true)
              then true
                else false

define PastConventionalNSAIDTherapyResponse:
  ("QT".item I
		where I.linkId.value = 'PastConventionalNSAIDTherapy')QR
		return First(QR.answer).value

define PastConventionalNSAIDTherapyProc:
  RDT."PastConventionalNSAIDTherapy"

define PastConventionalNSAIDTherapy:
  Coalesce(First("PastConventionalNSAIDTherapyResponse"), "PastConventionalNSAIDTherapyProc")

define PastConventionalNSAIDTherapyOutcomeResponse:
  ("QT".item I
		where I.linkId.value = 'PastConventionalNSAIDTherapyOutcome')QR
		return First(QR.answer).value

define PastConventionalNSAIDTherapyOutcomeProc:
  RDT."PastConventionalNSAIDTherapyOutcome"

define PastConventionalNSAIDTherapyOutcome:
  Coalesce(First("PastConventionalNSAIDTherapyOutcomeResponse"), "PastConventionalNSAIDTherapyOutcomeProc")

define NSAIDContraindicationResponse:
  ("QT".item I
		where I.linkId.value = 'NSAIDContraindication')QR
		return First(QR.answer).value

define NSAIDContraindicationProc:
  RDT."NSAIDContraindication"

define NSAIDContraindication:
  Coalesce(First("NSAIDContraindicationResponse"), "NSAIDContraindicationProc")

define NSAIDTherapyDecision:
  if (("PastConventionalNSAIDTherapy" = true and ("PastConventionalNSAIDTherapyOutcome" = false))
        or "NSAIDContraindication" = true)
          then true
            else false

define PreviousBiologicDrugsResponse:
  ("QT".item I
		where I.linkId.value = 'PreviousBiologicDrugs')QR
		return First(QR.answer).value

define PreviousBiologicDrugsMed:
  RDT."PreviousBiologicDrugs"

define PreviousBiologicDrugs:
  Coalesce(First("PreviousBiologicDrugsResponse"), "PreviousBiologicDrugsMed")

define BiologicOutcomeResponse:
  ("QT".item I
		where I.linkId.value = 'BiologicOutcome')QR
		return First(QR.answer).value

define BiologicOutcomeMed:
  RDT."BiologicOutcome"

define BiologicOutcome:
  Coalesce(First("BiologicOutcomeResponse"), "BiologicOutcomeMed")

define BiologicDecision:
  if ((("PreviousBiologicDrugs" = true) and ("BiologicOutcome" = true))
        or ("PreviousBiologicDrugs" = false))
          then true
            else false

define CombinationOtherDrugsResponse:
  ("QT".item I
		where I.linkId.value = 'CombinationOtherDrugs')QR
		return First(QR.answer).value

define CombinationOtherDrugsProc:
  RDT."CombinationOtherDrugs"

define CombinationOtherDrugs:
  Coalesce(First("CombinationOtherDrugsResponse"), "CombinationOtherDrugsProc")

define BacterialFungalInfectionsResponse:
  ("QT".item I
		where I.linkId.value = 'BacterialFungalInfections')QR
		return First(QR.answer).value

define BacterialFungalInfectionsCondition:
  RDT."BacterialFungalInfections"

define BacterialFungalInfections:
  Coalesce(First("BacterialFungalInfectionsResponse"), "BacterialFungalInfectionsCondition")

define COPDResponse:
  ("QT".item I
		where I.linkId.value = 'COPD')QR
		return First(QR.answer).value

define COPDCondition:
  RDT."COPD"

define COPD:
  Coalesce(First("COPDResponse"), "COPDCondition")

define ContraindicationDecision:
  if ("BacterialFungalInfections" = true
        or "COPD" = true)
          then true
            else false

define RheumatologistAuthroizationResponse:
  ("QT".item I
		where I.linkId.value = 'RheumatologistAuthroization')QR
		return First(QR.answer).value

define RheumatologistAuthroization:
  if (First("RheumatologistAuthroizationResponse") = true)
    then true
      else false

define DecisionForPSA:
  if ("PsoriaticArthritis" = true
          and "DMARDTherapyDecision" = true)
          then true
            else false

define DecisionForRA:
   if ("RheumatoidArthritis" = true
          and "DMARDTherapyDecision" = true)
          then true
            else false

define DecisionForAS:
  if ("AnkylosingSpondylitis" = true
        and "NSAIDTherapyDecision" = true)
          then true
            else false

define QualifiedDiagnosisDecision:
  if ("DecisionForPSA" = true
        or "DecisionForRA" = true
          or "DecisionForAS" = true
            or "PlaquePsoriasis" = true)
              then true
                else false

define PrimaryDecision:
  if ("QualifiedDiagnosisDecision" = true
        and "BiomarkersDecision" = true
          and "BiologicDecision" = true)
            then true
              else false

define DecisionPending:
  if ("CombinationOtherDrugs" = true
        and "ContraindicationDecision" = true)
          then true
            else false

define FinalDecision:
  if ("PrimaryDecision" = true
        and "DecisionPending" = false)
          then 'YES'
            else 'HUMAN REVIEW NEEDED'
