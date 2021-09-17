library TotalMastectomyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include TotalMastectomy version '1.0.0' called Mastectomy

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Mastectomy CPT Codes": '2.16.840.1.113883.3.6037.1001.23.93.170'
valueset "Mastectomy with Axillary Lymph Nodes": '2.16.840.1.113883.3.6037.1001.23.93.171'
valueset "Mastectomy with Pectoral Muscles": '2.16.840.1.113883.3.6037.1001.23.93.172'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define MastectomySurgeryRequest:
  if exists("Request".code.coding C where C in "Mastectomy CPT Codes")
  	    then true
	        else false

define MastectomyWithLymphNodesSurgeryRequest:
  if exists("Request".code.coding C where C in "Mastectomy with Axillary Lymph Nodes")
  	    then true
	        else false

define MastectomyWithPectoralSurgeryRequest:
  if exists("Request".code.coding C where C in "Mastectomy with Pectoral Muscles")
  	    then true
	        else false

define SurgeryType:
      Mastectomy."SurgeryType"

define SurgeryTypeDecision:
  if ("SurgeryType" = 'Ipsilateral')
      then true
        else false

define InflammatoryBreastCancer:
   Mastectomy."InflammatoryBreastCancer"

define NeoadjuvantChemotherapy:
   Mastectomy."NeoadjuvantChemotherapy"

define PostNeoadjuvantChemotherapy:
  Mastectomy."PostNeoadjuvantChemotherapy"

define InflammatoryBCDecision:
  if ("InflammatoryBreastCancer" = 'Inflammatory'
    and "NeoadjuvantChemotherapy" = true
      and "PostNeoadjuvantChemotherapy" = true)
        then true
          else false

define InvasiveBreastCancerCondition:
  Mastectomy."InvasiveBreastCancer"

define PhyllodeTumorsCondition:
  Mastectomy."PhyllodeTumors"

define PreviousSurgeryProcedure:
   exists(Mastectomy."PreviousSurgeryProcedure")

define MarginsPostSurgery:
  Mastectomy."MarginsPostSurgery"

define PhyllodeTumorDecision:
  if ("PhyllodeTumorsCondition" = true
    and "PreviousSurgeryProcedure" = true
      and "MarginsPostSurgery" = true)
        then true
          else false

define PagetsDiseaseCondition:
  Mastectomy."PagetsDisease"

define PregnancyTrimester:
  Mastectomy."PregnancyTrimester"

define PregnancyBCDecision:
  if ("PregnancyTrimester" = 'First')
    then true
      else false

define QualifiedCondtionsDecision:
  if ("InflammatoryBCDecision" = true
      or "InvasiveBreastCancerCondition" = true
        or "PhyllodeTumorDecision" = true
          or "PagetsDiseaseCondition" = true
            or "PregnancyBCDecision" = true)
              then true
                else false

define TStage:
  Mastectomy."TStage"

define NStage:
  Mastectomy."NStage"

define MStage:
  Mastectomy."MStage"

define AnatomicStage:
  if ({'Tis', 'N0', 'M0'} properly includes {"TStage", "NStage", "MStage"})
		then 'Stage0'
			else if ({'T1','T1mi','T1a','T1b','T1c', 'N0', 'M0'} properly includes {"TStage", "NStage", "MStage"})
				then 'StageIA'
					else if ({'T0', 'T1','T1mi','T1a','T1b','T1c','N1mi', 'M0'} properly includes {"TStage", "NStage", "MStage"})
						then 'StageIB'
							else if ({'T0', 'T1','T1mi','T1a','T1b','T1c', 'T2','N0','N1','N1a','N1b','N1c', 'M0' } properly includes {"TStage", "NStage", "MStage"})
								then 'StageIIA'
									else if ({'T2', 'T3', 'N0', 'N1', 'M0'} properly includes {"TStage", "NStage", "MStage"})
										then 'StageIIB'
											else if ({'T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'N1', 'N2', 'M0'} properly includes {"TStage", "NStage", "MStage"})
												then 'StageIIIA'
													else if ({'T4', 'N0', 'N1', 'N2', 'M0'} properly includes {"TStage", "NStage", "MStage"})
														then 'StageIIIB'
															else if ({'Tis','T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'T4', 'N3', 'M0'} included in {"TStage", "NStage", "MStage"})
																then 'StageIIIC'
																	else if ({'Tis','T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'T4', 'N0','N1','N1a','N1b','N1c','N1mi', 'N2', 'N3', 'M1'} included in {"TStage", "NStage", "MStage"})
																		then 'StageIV'
																			else ''

define AnatomicStageDecision:
  if ("AnatomicStage" in {'StageIA', 'StageIB', 'StageIIA', 'StageIIB', 'StageIIIA', 'StageIIIB', 'StageIIIC', 'StageIV'})
      then true
        else false

define SimpleMastectomyDecision:
  if ("QualifiedCondtionsDecision" = true
        and "MastectomySurgeryRequest" = true
          and "SurgeryTypeDecision" = true
            and "AnatomicStageDecision" = true)
              then true
                else false

define MastectomyWithLymphNodeDecision:
  if ("QualifiedCondtionsDecision" = true
        and "MastectomyWithLymphNodesSurgeryRequest" = true
          and "SurgeryTypeDecision" = true
            and "AnatomicStageDecision" = true
              and "NStage" in {'N1', 'N2', 'N3'})
              then true
                else false

define MastectomyWithPectoralDecision:
  if ("QualifiedCondtionsDecision" = true
        and "MastectomyWithLymphNodesSurgeryRequest" = true
          and "SurgeryTypeDecision" = true
            and "AnatomicStageDecision" = true
              and "MStage" = 'M1')
              then true
                else false

define FinalDecision:
      if  (("SimpleMastectomyDecision" = true)
            or ("MastectomyWithLymphNodeDecision" = true)
              or ("MastectomyWithPectoralDecision" = true))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'