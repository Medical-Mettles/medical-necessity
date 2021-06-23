library ChemodenervationOneExtremityDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BotulinumToxin version '1.0.0' called Botox

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Chemodenervation Of One Extremity; 1-4 Muscle(S)": '2.16.840.1.113883.3.6037.1001.23.93.76'
valueset "Chemodenervation Of One Extremity; 5 Or More Muscles": '2.16.840.1.113883.3.6037.1001.23.93.77'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define ChemodenervationOneExtremityServiceRequest:
if (exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 1-4 Muscle(S)")
      or exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 5 Or More Muscles"))
  	    then true
	        else false

define SpasticityCondition:
	Botox."SpasticityCondition"

define ChemodenervationOneExtremityQualifiedConditions:
      if exists("SpasticityCondition")
          then true
            else false

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define ImprovementPostBotox:
      ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-ImprovementPostBotox')QR
		      return First(QR.answer).value

define PrimaryDecision:
      if (("ChemodenervationOneExtremityServiceRequest" = true)
            and ("ChemodenervationOneExtremityQualifiedConditions" = true))
        then true
          else false

define DecisionPending:
    if First("ImprovementPostBotox") = false
          then true
            else false

define FinalDecision:
      if  ("PrimaryDecision" = true
          and "DecisionPending" = false)
              then 'YES'
                else 'HUMAN REVIEW NEEDED'