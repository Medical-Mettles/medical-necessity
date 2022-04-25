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

define QuestionnaireResponseItems:
	   "QuestionnaireResponse".item

define BotulinumConditionsResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'BotulinumConditions')QR
		      return First(QR.answer).value

define BotulinumConditionsCond:
	Botox."BotoxDiagnosisConditions"

define BotoxDiagnosisConditions:
  Coalesce((First("BotulinumConditionsResponse")).code, "BotulinumConditionsCond")

define BotoxConditionsDecision:
  if ("BotoxDiagnosisConditions" = 'Spasticity')
    then true
      else false

define SpasticityMuscleGroupsResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-MuscleGroups')QR
		      return First(QR.answer).value

define SpasticityMuscleGroupsServ:
	Botox."SpasticityMuscleGroups"

define SpasticityMuscleGroups:
  Coalesce(First("SpasticityMuscleGroupsResponse").code, "SpasticityMuscleGroupsServ")

define SpasticityFaceInjectionSideResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-SideInjection')QR
		      return First(QR.answer).value

define SpasticityFaceInjectionSideServ:
	Botox."SpasticityFaceInjectionSide"

define SpasticityFaceInjectionSide:
  Coalesce(First("SpasticityFaceInjectionSideResponse").code, "SpasticityFaceInjectionSideServ")

define InjectionSideExtremityResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-Extremity')QR
		      return First(QR.answer).value

define InjectionSideExtremityServ:
	Botox."InjectionSideExtremity"

define InjectionSideExtremity:
  Coalesce(First("InjectionSideExtremityResponse").code, "InjectionSideExtremityServ")

define InjectionSideTrunkResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-TrunkInjectionSide')QR
		      return First(QR.answer).value

define InjectionSideTrunkServ:
	Botox."InjectionSideTrunk"

define InjectionSideTrunk:
  Coalesce(First("InjectionSideTrunkResponse").code, "InjectionSideTrunkServ")

define EtiologyResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-Etiology')QR
		      return First(QR.answer).value

define EtiologyCondition:
	Botox."Etiology"

define Etiology:
  Coalesce(First("EtiologyResponse").code, "EtiologyCondition")

define AdjunctivePhysiotherapyResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-AdjunctivePhysiotherapy')QR
		      return First(QR.answer).value

define AdjunctivePhysiotherapyCond:
	Botox."AdjunctivePhysiotherapy"

define AdjunctivePhysiotherapy:
  Coalesce(First("AdjunctivePhysiotherapyResponse"), "AdjunctivePhysiotherapyCond")

define SpasticityCondition:
	Botox."SpasticityCondition"

define ChemodenervationOneExtremityQualifiedConditions:
      if ("BotoxConditionsDecision" = true)
          then true
            else false

define SpasticityPrevBotoxResponse:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-PriorBotoxAdministration')QR
		      return First(QR.answer).value

define SpasticityBotulinumAdministration:
  Botox."SpasticityEarlierBotulinumAdministration"

define SpasticityEarlierBotulinumAdministration:
  Coalesce(First("SpasticityPrevBotoxResponse"), "SpasticityBotulinumAdministration")

define SpasticitySpecifyBotoxAdministrationRes:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-PriorBotoxStrain')QR
		      return First(QR.answer).value

define SpasticitySpecifyBotoxAdministrationProc:
	Botox."SpasticitySpecifyBotoxAdministration"

define SpasticitySpecifyBotoxAdministration:
  Coalesce("SpasticitySpecifyBotoxAdministrationRes", "SpasticitySpecifyBotoxAdministrationProc")

define SpasticityPostBotoxImprovementRes:
  ("QuestionnaireResponseItems".item I
		   where I.linkId.value = 'Spasticity-PriorBotoxStrain')QR
		      return First(QR.answer).value

define SpasticityPostBotoxImprovementProc:
	Botox."SpasticityPostBotoxImprovement"

define SpasticityPostBotoxImprovement:
  Coalesce(First("SpasticityPostBotoxImprovementRes"), "SpasticityPostBotoxImprovementProc")

define ChemodenervationOneExtremityServiceRequest:
if (exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 1-4 Muscle(S)")
      or exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 5 Or More Muscles"))
  	    then true
	        else false

define PrimaryDecision:
      if (("ChemodenervationOneExtremityServiceRequest" = true)
            and ("ChemodenervationOneExtremityQualifiedConditions" = true))
        then true
          else false

define DecisionPending:
    if ("SpasticityEarlierBotulinumAdministration" = true
          and ("SpasticityPostBotoxImprovement" = false))
            then true
              else false

define FinalDecision:
      if  ("PrimaryDecision" = true
          and "DecisionPending" = false)
              then 'YES'
                else 'HUMAN REVIEW NEEDED'