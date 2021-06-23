library BotulinumLaryngoscopyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BotulinumToxin version '1.0.0' called Botox

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Laryngoscopy Codes": '2.16.840.1.113883.3.6037.1001.23.93.80'
valueset "Larynx Condition Codes": '2.16.840.1.113883.3.6037.1001.23.93.81'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "MedicationRequest" MedicationRequest


context Patient

define LaryngoscopyMedicationRequest:
  Botox."SpasticityLarygoscopy"

define SialorrheaCondition:
      Botox."SialorrheaCondition"

define SialorrheaConditionDecision:
      if exists("SialorrheaCondition")
        then true
          else false

define LarynxCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Larynx Condition Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define LaryngoscopyQualifiedConditionsDecision:
  if (exists("LarynxCondition")
        or exists("SialorrheaCondition"))
          then true
            else false

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define BiofeedbackTherapy:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostBiofeedback')QR
		      return First(QR.answer).value

define SialorrheaBotoxTreatment:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostBotox')QR
		      return First(QR.answer).value

define Glycopyrrolate:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostGlycopyrrolate')QR
		      return First(QR.answer).value

define Scopolamine:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostScopolamine')QR
		      return First(QR.answer).value

define Contraindications:
      Botox."SialorrheaAnticholinergicContraindications"

define SpasticityBotoxTreatment:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-ImprovementPostBotox')QR
		      return First(QR.answer).value

define PrimaryDecision:
      if (("LaryngoscopyQualifiedConditionsDecision" = true)
            and ("LaryngoscopyMedicationRequest" = true))
        then true
          else false

define ContraindicationsDecision:
  if ("Contraindications") is null
    then true
      else false

define DecisionPending:
    if (First("BiofeedbackTherapy") = true)
        or (First("SialorrheaBotoxTreatment") = false)
          or (First("SpasticityBotoxTreatment") = false)
            or (First("Glycopyrrolate") = true)
              or (First("Scopolamine") = true)
                or ("ContraindicationsDecision" = true)
                  then true
                    else false

define FinalDecision:
      if  (("PrimaryDecision" = true)
            and ("DecisionPending" = false))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'



