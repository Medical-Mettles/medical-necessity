library TotalMastectomy version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Inflammatory Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.93.145'
valueset "Preoperative Chemotherapy": '2.16.840.1.113883.3.6037.1001.23.93.146'
valueset "Phyllodes Tumor of Breast": '2.16.840.1.113883.3.6037.1001.23.93.147'
valueset "Breast Cancer": '2.16.840.1.113883.3.1434.1000.1095'
valueset "Tumor stage Tis(Pagets)": '2.16.840.1.113883.3.6037.1001.23.94.06'
valueset "Invasive Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.93.148'
valueset "Ductal Carcinoma": '2.16.840.1.113883.3.6037.1001.23.93.149'
valueset "Lobular Carcinoma": '2.16.840.1.113883.3.6037.1001.23.93.150'
valueset "Mixed Carcinoma of Breast": '2.16.840.1.113883.3.6037.1001.23.93.151'
valueset "Mucinous Carcinoma": '2.16.840.1.113883.3.6037.1001.23.93.152'
valueset "Tubular Carcinoma": '2.16.840.1.113883.3.6037.1001.23.93.153'
valueset "Cribriform Carcinoma": '2.16.840.1.113883.3.6037.1001.23.93.154'
valueset "Papillary Carcinoma": '2.16.840.1.113883.3.6037.1001.23.93.155'
valueset "Progesterone receptor": '2.16.840.1.113883.3.6037.1001.23.96.16'
valueset "Estrogen receptor": '2.16.840.1.113883.3.6037.1001.23.96.15'
valueset "HER2 Presence in Tissue": '2.16.840.1.113883.3.1444.5.207'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Negative Result": '2.16.840.1.113762.1.4.1116.292'
valueset "Stage type Clinical": '2.16.840.1.113883.3.6037.1001.23.96.23'
valueset "Stage type Pathological": '2.16.840.1.113883.3.6037.1001.23.96.24'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Breasts BodySite": '2.16.840.1.113883.3.6037.1001.23.96.18'
valueset "Tumor stage T0": '2.16.840.1.113883.3.6037.1001.23.94.02'
valueset "Tumor stage T1a": '2.16.840.1.113883.3.6037.1001.23.94.08'
valueset "Tumor stage T1b": '2.16.840.1.113883.3.6037.1001.23.94.09'
valueset "Tumor stage T1mi": '2.16.840.1.113883.3.6037.1001.23.94.07'
valueset "Tumor stage Tis(DCIS)": '2.16.840.1.113883.3.6037.1001.23.94.04'
valueset "Tumor stage Tis(LCIS)": '2.16.840.1.113883.3.6037.1001.23.94.05'
valueset "Tumor stage Tx": '2.16.840.1.113883.3.6037.1001.23.94.01'
valueset "Tumor stage Tis": '2.16.840.1.113883.3.6037.1001.23.94.03'
valueset "Tumor stage T2": '2.16.840.1.113883.3.6037.1001.23.94.10'
valueset "Tumor stage T3": '2.16.840.1.113883.3.6037.1001.23.94.11'
valueset "Tumor stage T4": '2.16.840.1.113883.3.6037.1001.23.94.12'
valueset "Tumor stage T4a": '2.16.840.1.113883.3.6037.1001.23.94.13'
valueset "Tumor stage T4b": '2.16.840.1.113883.3.6037.1001.23.94.14'
valueset "Tumor stage T4c": '2.16.840.1.113883.3.6037.1001.23.94.15'
valueset "Tumor stage T4d": '2.16.840.1.113883.3.6037.1001.23.94.16'
valueset "Regional Lymph Nodes N0": '2.16.840.1.113883.3.6037.1001.23.94.17'
valueset "Regional Lymph Nodes Nx": '2.16.840.1.113883.3.6037.1001.23.94.19'
valueset "Regional Lymph Nodes N1": '2.16.840.1.113883.3.6037.1001.23.94.20'
valueset "Regional Lymph Nodes N2": '2.16.840.1.113883.3.6037.1001.23.94.21'
valueset "Regional Lymph Nodes N3": '2.16.840.1.113883.3.6037.1001.23.94.22'
valueset "Metastasis Stages M1": '2.16.840.1.113883.3.6037.1001.23.94.18'
valueset "Metastasis stage M0": '2.16.840.1.113883.3.6037.1001.23.94.23'
valueset "Genetic Susceptibility to Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.93.156'
valueset "Pregnancy": '2.16.840.1.113883.3.6037.1001.23.93.157'
valueset "First Trimester of Pregnancy": '2.16.840.1.113883.3.6037.1001.23.93.158'
valueset "Second Trimester of Pregnancy": '2.16.840.1.113883.3.6037.1001.23.93.159'
valueset "Third Trimester of Pregnancy": '2.16.840.1.113883.3.6037.1001.23.93.160'
valueset "First Trimester Finding": '2.16.840.1.113883.3.6037.1001.23.93.161'
valueset "Second Trimester Finding": '2.16.840.1.113883.3.6037.1001.23.93.162'
valueset "Third Trimester Finding": '2.16.840.1.113883.3.6037.1001.23.93.163'
valueset "Lumpectomy Procedure": '2.16.840.1.113883.3.6037.1001.23.93.164'
valueset "Partial Mastectomy Procedure": '2.16.840.1.113883.3.6037.1001.23.93.165'
valueset "Cardiac Disease": '2.16.840.1.113762.1.4.1029.341'
valueset "Chronic Obstructive Pulmonary Diseases": '2.16.840.1.113883.17.4077.3.2063'
valueset "Liver Disease": '2.16.840.1.113762.1.4.1047.42'
valueset "Renal Disease": '2.16.840.1.113762.1.4.1029.335'
valueset "Bleeding Disorder": '2.16.840.1.113762.1.4.1029.287'
valueset "Partially successful": '2.16.840.1.113883.3.6037.1001.23.93.47'
valueset "Successful": '2.16.840.1.113883.3.6037.1001.23.93.48'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'
valueset "Left breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.19'
valueset "Right breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.20'
valueset "Bilateral breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.21'
valueset "Surgical Margins Involved by Tumor": '2.16.840.1.113883.3.6037.1001.23.93.166'
valueset "AETNA100360 Mastectomy": '2.16.840.1.113762.1.4.1195.300'
valueset "Left Breast BodySite": '2.16.840.1.113883.3.6037.1001.23.93.167'
valueset "Right Breast BodySite": '2.16.840.1.113883.3.6037.1001.23.93.168'
valueset "Entire Breast BodySite": '2.16.840.1.113883.3.6037.1001.23.93.169'
valueset "Mastectomy CPT Codes": '2.16.840.1.113883.3.6037.1001.23.93.170'
valueset "Mastectomy with Axillary Lymph Nodes": '2.16.840.1.113883.3.6037.1001.23.93.171'
valueset "Mastectomy with Pectoral Muscles": '2.16.840.1.113883.3.6037.1001.23.93.172'
valueset "DCIS Breast Cancer Condition": '2.16.840.1.113883.3.6037.1001.23.93.173'
valueset "Carcinoma in Upper Inner Breast": '2.16.840.1.113883.3.6037.1001.23.93.174'
valueset "Carcinoma in Lower Inner Breast": '2.16.840.1.113883.3.6037.1001.23.93.175'
valueset "Carcinoma in Upper Outer Breast": '2.16.840.1.113883.3.6037.1001.23.93.176'
valueset "Carcinoma in Lower Outer Breast": '2.16.840.1.113883.3.6037.1001.23.93.177'
valueset "Borderline Phyllodes Tumor of Breast": '2.16.840.1.113883.3.6037.1001.23.93.178'
valueset "Benign Phyllodes Tumor of Breast": '2.16.840.1.113883.3.6037.1001.23.93.179'
valueset "Malignant Phyllodes Tumor of Breast": '2.16.840.1.113883.3.6037.1001.23.93.180'
valueset "Core Needle or Excisional Biopsy of Breast": '2.16.840.1.113883.3.6037.1001.23.93.181'
valueset "Pagets Disease of Breast": '2.16.840.1.113883.3.6037.1001.23.93.182'
valueset "Punch Biopsy Procedure": '2.16.840.1.113883.3.6037.1001.23.93.183'
valueset "Postmenopausal Diagnosis": '2.16.840.1.113883.3.6037.1001.23.93.184'
valueset "BRCA Gene Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.185'
valueset "Counseling For Mastectomy": '2.16.840.1.113883.3.6037.1001.23.93.186'
valueset "Counseling For Pregnancy Termination": '2.16.840.1.113883.3.6037.1001.23.93.187'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define InflammatoryBreastCancer:
	if exists([Condition]C
    where exists(C.code.coding C where C in "Inflammatory Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')
					then 'Inflammatory'
						else 'Non-Inflammatory'

define NeoadjuvantChemotherapyProcedure:
	[Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Preoperative Chemotherapy")

define NeoadjuvantChemotherapy:
	exists("NeoadjuvantChemotherapyProcedure")

define PostNeoadjuvantChemotherapySuccessfulOutcome:
	if exists("NeoadjuvantChemotherapyProcedure" P
								where (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful"))
					then true
						else false

define PostNeoadjuvantChemotherapyUnsuccessfulOutcome:
	if exists("NeoadjuvantChemotherapyProcedure" P
								where First(P.outcome.coding) in "Unsuccessful")
					then true
						else false

define PostNeoadjuvantChemotherapy:
	if ("PostNeoadjuvantChemotherapySuccessfulOutcome" = true)
		then true
			else if ("PostNeoadjuvantChemotherapyUnsuccessfulOutcome" = true)
				then false
					else null

define PhyllodeTumors:
	exists([Condition]C
    where exists(C.code.coding C where C in "Phyllodes Tumor of Breast")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define CoreNeedleOrExcisionBiopsyProcedure:
	[Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Core Needle or Excisional Biopsy of Breast")

define PhyllodeTumorsBiopsyConfirmation:
	if ("PhyllodeTumors" = true
				and exists("CoreNeedleOrExcisionBiopsyProcedure"))
					then true
						else false

define PhyllodeTumorsMorphology:
	if exists([Condition]C where exists(C.code.coding C where C in "Benign Phyllodes Tumor of Breast")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')
					then 'Benign'
						else if exists([Condition]C where exists(C.code.coding C where C in "Borderline Phyllodes Tumor of Breast")
      				and First(C.clinicalStatus.coding).code.value = 'active'
        				and First(C.verificationStatus.coding).code.value = 'confirmed')
									then 'Borderline'
										else if exists([Condition]C where exists(C.code.coding C where C in "Malignant Phyllodes Tumor of Breast")
      								and First(C.clinicalStatus.coding).code.value = 'active'
        								and First(C.verificationStatus.coding).code.value = 'confirmed')
													then 'Malignant'
														else ''

define PagetsDiseaseOfBreast:
	[Condition]C
    where exists(C.code.coding C where C in "Pagets Disease of Breast")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define BCPagetsDisease:
	exists([Condition]C
    where exists(C.code.coding C where C in "Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and exists(C.stage s where exists(s.summary.coding C where C in "Tumor stage Tis(Pagets)")))

define PagetsDisease:
	if (exists("PagetsDiseaseOfBreast")
			or ("BCPagetsDisease" = true))
				then true
					else false

define PunchBiopsyProcedure:
	[Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Punch Biopsy Procedure")

define PunchBiopsy:
	if (exists("PunchBiopsyProcedure")
		and "BCPagetsDisease" = true)
			then true
				else false

define DuctalHistology:
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Ductal Carcinoma")
			and (P.value as boolean) = true)

define LobularHistology:
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Lobular Carcinoma")
			and (P.value as boolean) = true)

define MixedCarcinoma:
	[Condition]C
    where exists(C.code.coding C where C in "Mixed Carcinoma of Breast")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define MucinousHistology:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Mucinous Carcinoma")
			and (P.value as boolean) = true

define TubularHistology:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Tubular Carcinoma")
			and (P.value as boolean) = true

define CribriformHistology:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Cribriform Carcinoma")
			and (P.value as boolean) = true

define PapillaryHistology:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Papillary Carcinoma")
			and (P.value as boolean) = true

define Histology:
	if exists("DuctalHistology")
			then 'Ductal'
				else if exists("LobularHistology")
					then 'Lobular'
						else if exists("MixedCarcinoma")
							then 'Mixed'
								else if exists("MucinousHistology")
									then 'Mucinous'
										else if exists("TubularHistology")
											then 'Tubular'
												else if exists("CribriformHistology")
													then 'Cribriform'
														else if exists("PapillaryHistology")
															then 'Papillary'
																else ''

define "PRPositiveObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Progesterone receptor")
			and (P.value as CodeableConcept) in "Positive")

define "PRNegativeObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Progesterone receptor")
			and (P.value as CodeableConcept) in "Negative Result")

define PRStatus:
	if exists("PRPositiveObservation")
			then 'Positive'
				else if exists("PRNegativeObservation")
					then 'Negative'
						else ''

define "ERPositiveObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Estrogen receptor")
			and (P.value as CodeableConcept) in "Positive")

define "ERNegativeObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Estrogen receptor")
			and (P.value as CodeableConcept) in "Negative Result")

define ERStatus:
	if exists("ERPositiveObservation")
			then 'Positive'
				else if exists("ERNegativeObservation")
					then 'Negative'
						else ''

define "HER2PositiveObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "HER2 Presence in Tissue")
			and (P.value as CodeableConcept) in "Positive")

define "HER2NegativeObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "HER2 Presence in Tissue")
			and (P.value as CodeableConcept) in "Negative Result")

define HERTwoProtienStatus:
	if exists("HER2PositiveObservation")
			then 'Positive'
				else if exists("HER2NegativeObservation")
					then 'Negative'
						else ''

define "BreastCancerCondition":
	[Condition] C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Breast Cancer")

define CancerStagingType:
	if exists("BreastCancerCondition"B
    where exists(B.stage s where exists(s.type.coding x where x in "Stage type Pathological")))
			then 'Pathological'
				else (if exists("BreastCancerCondition"B
					where exists(B.stage s where exists(s.type.coding x where x in "Stage type Clinical")))
						then 'Clinical'
							else ''
						)

define "TumorSizeObservation":
  Last(([Observation]P where P.status.value in {'final', 'amended', 'corrected'}
			and First(P.code.coding C where C in "Tumor size") is not null
			and exists(P.bodySite.coding co where co in "Breasts BodySite")))

define "TumorSize":
  if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'mm'
	then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value/10
  else (if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'cm'
        then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value
        else 0)

define "TStage":
	if exists("BreastCancerCondition".stage S
				where exists(S.summary.coding C where C in "Tumor stage Tx"))
				then 'Tx'
			else if exists("BreastCancerCondition".stage S
					where exists(S.summary.coding C where C in "Tumor stage T0"))
					then 'T0'
				else if exists("BreastCancerCondition".stage S
						where (exists(S.summary.coding C where C in "Tumor stage Tis")
							or exists(S.summary.coding C where C in "Tumor stage Tis(DCIS)")
							or exists(S.summary.coding C where C in "Tumor stage Tis(LCIS)")
							or exists(S.summary.coding C where C in "Tumor stage Tis(Pagets)")))
							then 'Tis'
						else if exists("BreastCancerCondition".stage S
							where (exists(S.summary.coding C where C in "Tumor stage T1a")
									or exists(S.summary.coding C where C in "Tumor stage T1b")
									or exists(S.summary.coding C where C in "Tumor stage T1mi")))
									then 'T1'
								else if exists("BreastCancerCondition".stage S
										where exists(S.summary.coding C where C in "Tumor stage T2"))
										then 'T2'
									else if exists("BreastCancerCondition".stage S
											where exists(S.summary.coding C where C in "Tumor stage T3"))
											then 'T3'
										else if exists("BreastCancerCondition".stage S
												where (exists(S.summary.coding C where C in "Tumor stage T4")
													or exists(S.summary.coding C where C in "Tumor stage T4a")
													or exists(S.summary.coding C where C in "Tumor stage T4b")
													or exists(S.summary.coding C where C in "Tumor stage T4c")
													or exists(S.summary.coding C where C in "Tumor stage T4d")))
													then 'T4'
													else ''

define "NStage":
	if exists("BreastCancerCondition".stage S
		where exists(S.summary.coding C where C in "Regional Lymph Nodes Nx"))
				then 'Nx'
				else if exists("BreastCancerCondition".stage S
							where exists(S.summary.coding C where C in "Regional Lymph Nodes N0"))
									then 'N0'
						else if exists("BreastCancerCondition".stage S
								where exists(S.summary.coding C where C in "Regional Lymph Nodes N1"))
										then 'N1'
								else if exists("BreastCancerCondition".stage S
										where exists(S.summary.coding C where C in "Regional Lymph Nodes N2"))
												then 'N2'
										else if exists("BreastCancerCondition".stage S
												where exists(S.summary.coding C where C in "Regional Lymph Nodes N3"))
														then 'N3'
														else ''

define "MStage":
    if exists("BreastCancerCondition".stage S
			where exists(S.summary.coding C where C in "Metastasis Stages M1"))
			then 'M1'
			else if exists("BreastCancerCondition".stage S
					where exists(S.summary.coding C where C in "Metastasis stage M0"))
							then 'M0'
							else ''

define "AnatomicStage":
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

define AnatomicStageInvasive:
  if ("AnatomicStage" in {'StageIA', 'StageIB', 'StageIIA', 'StageIIB', 'StageIIIA', 'StageIIIB', 'StageIIIC', 'StageIV'})
      then true
        else false

define InvasiveBreastCancerCondition:
	exists([Condition]C
    where exists(C.code.coding C where C in "Invasive Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define InvasiveBreastCancer:
	if ("InvasiveBreastCancerCondition" = true)
		or ("AnatomicStageInvasive" = true)
		then true
			else false

define GeneticPredisposition:
	exists([Condition]C
    where exists(C.code.coding C where C in "Genetic Susceptibility to Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define BRCAMutationTest:
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "BRCA Gene Mutation Test")
			and (P.value as CodeableConcept) in "Positive")

define PregnantPatient:
	exists([Condition]C
    where exists(C.code.coding C where C in "Pregnancy")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define PregnancyFirstTrimesterCondition:
	([Condition]C
    where exists(C.code.coding C where C in "First Trimester of Pregnancy")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define PregnancyFirstTrimesterObservation:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "First Trimester Finding")
			and (P.value as boolean) = true

define PregnancyFirstTrimester:
	if (exists("PregnancyFirstTrimesterCondition")
				or exists("PregnancyFirstTrimesterObservation"))
					then true
						else false

define PregnancySecondTrimesterCondition:
	([Condition]C
    where exists(C.code.coding C where C in "Second Trimester of Pregnancy")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define PregnancySecondTrimesterObservation:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Second Trimester Finding")
			and (P.value as boolean) = true

define PregnancySecondTrimester:
	if (exists("PregnancySecondTrimesterCondition")
				or exists("PregnancySecondTrimesterObservation"))
					then true
						else false

define PregnancyThirdTrimesterCondition:
	([Condition]C
    where exists(C.code.coding C where C in "Third Trimester of Pregnancy")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define PregnancyThirdTrimesterObservation:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Third Trimester Finding")
			and (P.value as boolean) = true

define PregnancyThirdTrimester:
	if (exists("PregnancyThirdTrimesterCondition")
				or exists("PregnancyThirdTrimesterObservation"))
					then true
						else false

define PregnancyTrimester:
	if ("PregnancyFirstTrimester" = true)
		then 'First'
			else if ("PregnancySecondTrimester" = true)
				then 'Second'
					else if ("PregnancyThirdTrimester" = true)
						then 'Third'
							else ''

define TerminationCounselling:
	exists([Procedure]P
		where P.status.value = 'completed'
			and (exists(P.code.coding C where C in "Counseling For Mastectomy")
				or exists (P.code.coding C where C in "Counseling For Pregnancy Termination")))

define MastectomyCounseling:
	exists([Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "Counseling For Mastectomy"))

define "Laterality":
	if exists("BreastCancerCondition" B
		where (exists(B.code.coding x where x in "Left breast cancer")
			or exists(B.bodySite.coding co where co in "Left Breast BodySite")
				or exists(B.code.coding x where x in "Right breast cancer")
					or exists(B.bodySite.coding co where co in "Right Breast BodySite")))
						then 'Unilateral'
							else if exists("BreastCancerCondition" B
								where (exists(B.code.coding x where x in "Bilateral breast cancer")
									or exists(B.bodySite.coding co where co in "Right Breast BodySite")))
										then 'Bilateral'
											else ''

define PreviousSurgeryProcedure:
	[Procedure]P
		where P.status.value = 'completed'
			and (exists(P.code.coding C where C in "Lumpectomy Procedure")
						or exists(P.code.coding C where C in "Partial Mastectomy Procedure"))

define PreviousSurgery:
	exists("PreviousSurgeryProcedure")

define MarginsPostSurgery:
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Surgical Margins Involved by Tumor")
			and (P.value as boolean) = true)

define "SystemicDisorders":
	exists([Condition]C
		with [Condition]S
				such that C.subject.reference.value = 'Patient/'+ Patient.id.value
    				and First(C.clinicalStatus.coding).code.value = 'active'
    						and exists(C.code.coding x where (x in "Renal Disease")
											or (x in "Liver Disease")
												or (x in "Cardiac Disease")
													or (x in "Chronic Obstructive Pulmonary Diseases"))
						and exists(S.code.coding x where x in "Breast Cancer")
							and start of "Normalize Onset"(C.onset) before start of "Normalize Onset"(S.onset))

define BleedingDisorders:
	exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Bleeding Disorder"))

define LateralityOfCancer:
	if (exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Left breast cancer"))
				or exists("BreastCancerCondition" B where exists(B.bodySite.coding co where co in "Left Breast BodySite")))
					then 'Left'
						else if (exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Right breast cancer"))
												or exists("BreastCancerCondition" B where exists(B.bodySite.coding co where co in "Right Breast BodySite")))
													then 'Right'
														else if (exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Bilateral breast cancer"))
																				or exists("BreastCancerCondition" B where exists(B.bodySite.coding co where co in "Right Breast BodySite")))
																					then 'Bilateral'
																						else ''

define LeftBreastMastectomySurgeryRequest:
  if (exists("Request".code.coding C where C in "Mastectomy CPT Codes")
				or exists("Request".code.coding C where C in "Mastectomy with Axillary Lymph Nodes")
					or exists("Request".code.coding C where C in "Mastectomy with Pectoral Muscles"))
			and exists("Request".bodySite.coding co where co in "Left Breast BodySite")
  	    then true
	        else false

define RightBreastMastectomySurgeryRequest:
  if (exists("Request".code.coding C where C in "Mastectomy CPT Codes")
				or exists("Request".code.coding C where C in "Mastectomy with Axillary Lymph Nodes")
					or exists("Request".code.coding C where C in "Mastectomy with Pectoral Muscles"))
			and exists("Request".bodySite.coding co where co in "Right Breast BodySite")
  	    then true
	        else false

define BilateralBreastMastectomySurgeryRequest:
  if (exists("Request".code.coding C where C in "Mastectomy CPT Codes")
				or exists("Request".code.coding C where C in "Mastectomy with Axillary Lymph Nodes")
					or exists("Request".code.coding C where C in "Mastectomy with Pectoral Muscles"))
			and exists("Request".bodySite.coding co where co in "Entire Breast BodySite")
  	    then true
	        else false

define SurgeryType:
	if (("LeftBreastMastectomySurgeryRequest" = true and "LateralityOfCancer" = 'Right')
		or ("RightBreastMastectomySurgeryRequest" = true and "LateralityOfCancer" = 'Left'))
			then 'Contralateral'
				else if (("LeftBreastMastectomySurgeryRequest" = true and "LateralityOfCancer" = 'Left')
					or ("RightBreastMastectomySurgeryRequest" = true and "LateralityOfCancer" = 'Right')
						or ("BilateralBreastMastectomySurgeryRequest" = true and "LateralityOfCancer" = 'Bilateral'))
							then 'Ipsilateral'
								else ''

define DCISBreastCancerCondition:
	exists([Condition]C
    where exists(C.code.coding C where C in "DCIS Breast Cancer Condition")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define DCISStageBreastCancer:
	exists([Condition]C
    where exists(C.code.coding C where C in "Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and exists(C.stage s where exists(s.summary.coding C where C in "Tumor stage Tis(DCIS)")))

define DCISBreastCancer:
	if ("DCISBreastCancerCondition" = true
				or "DCISStageBreastCancer" = true)
					then true
						else false

define DCISQuadrants:
	[Condition]C
		where (exists(C.code.coding C where C in "Carcinoma in Upper Inner Breast") or exists (C.code.coding C where C in "Carcinoma in Lower Inner Breast")
			or exists (C.code.coding C where C in "Carcinoma in Upper Outer Breast")	or exists (C.code.coding C where C in "Carcinoma in Lower Outer Breast"))
				and First(C.clinicalStatus.coding).code.value = 'active'
					and First(C.verificationStatus.coding).code.value = 'confirmed'

define DCISQuadrantsOfBreast:
	if Length("DCISQuadrants")>2
		and Length("DCISQuadrants")<4
			then true
				else false

define PatientGender:
	if Patient.gender.value = 'female'
		then 'Female'
			else if Patient.gender.value = 'male'
				then 'Male'
					else ''

define MenopauseCondition:
	if exists([Condition]C
    where exists(C.code.coding C where C in "Postmenopausal Diagnosis")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')
					then 'Post-menopausal'
						else 'Pre-menopausal'





define function "Normalize Onset"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else if onset is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).high) + 1 year)
	else null