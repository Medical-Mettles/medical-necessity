library ChemodenervationParotidDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BotulinumToxin version '1.0.0' called Botox

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral": '2.16.840.1.113883.3.6037.1001.23.99.37'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define ChemodenervationParotidServiceRequest:
	if exists("Request".code.coding C where C in "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral")
  	    then true
	        else false

define SialorrheaCondition:
      Botox."SialorrheaCondition"

define SialorrheaConditionDecision:
      if exists("SialorrheaCondition")
        then true
          else false

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define ImprovementPostBiofeedbackTherapy:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostBiofeedback')QR
		      return First(QR.answer).value

define ImprovementPostBotoxTreatment:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostBotox')QR
		      return First(QR.answer).value

define ImprovementPostGlycopyrrolate:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostGlycopyrrolate')QR
		      return First(QR.answer).value

define ImprovementPostScopolamine:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Sialorrhea-ImprovementPostScopolamine')QR
		      return First(QR.answer).value

define AnticholinergicContraindications:
      Botox."SialorrheaAnticholinergicContraindications"

define PrimaryDecision:
      if (("SialorrheaConditionDecision" = true)
            and ("ChemodenervationParotidServiceRequest" = true))
        then true
          else false

define Contraindications:
  if ("AnticholinergicContraindications") is not null
    then true
      else false

define DecisionPending:
    if ((First("ImprovementPostBiofeedbackTherapy") = true)
        or (First("ImprovementPostBotoxTreatment") = false)
            or (First("ImprovementPostGlycopyrrolate") = true)
              or (First("ImprovementPostScopolamine") = true)
                or ("Contraindications" = false))
                  then true
                    else false

define FinalDecision:
      if  (("PrimaryDecision" = true)
            and ("DecisionPending" = false))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'