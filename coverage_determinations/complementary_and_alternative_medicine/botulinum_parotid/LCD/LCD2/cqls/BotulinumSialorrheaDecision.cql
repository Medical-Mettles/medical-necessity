library BotulinumSialorrheaDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BotulinumSialorrhea version '1.0.0' called Sialorrhea

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Onabotulinumtoxina": '2.16.840.1.113883.3.6037.1001.23.99.78'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "MedicationRequest" MedicationRequest


context Patient

define ColonCancerCondition:
      Sialorrhea."Sialorrhea"

define OnabotulinumtoxinaDrugReq:
     First(("MedicationRequest".medication as CodeableConcept).coding) in "Onabotulinumtoxina"

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define BiofeedbackTherapy:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.2')QR
		      return First(QR.answer).value

define BotoxTreatment:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '2.4')QR
		      return First(QR.answer).value

define Glycopyrrolate:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '3.2')QR
		      return First(QR.answer).value

define Scopolamine:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = '3.4')QR
		      return First(QR.answer).value

define Contraindications:
      Sialorrhea."AnticholinergicContraindications"

define PrimaryDecision:
      if ("OnabotulinumtoxinaDrugReq" = true)
        then true
          else false

define ContraindicationsDecision:
  if ("Contraindications") is null
    then true
      else false

define DecisionPending:
    if (First("BiofeedbackTherapy") = true)
        or (First("BotoxTreatment") = false)
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



