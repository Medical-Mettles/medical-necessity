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

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define InflammatoryBreastCancer:
	exists([Condition]C
    where exists(C.code.coding C where C in "Inflammatory Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

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

define PagetsDisease:
	exists([Condition]C
    where exists(C.code.coding C where C in "Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and exists(C.stage s where exists(s.summary.coding C where C in "Tumor stage Tis(Pagets)")))

define InvasiveBreastCancer:
	exists([Condition]C
    where exists(C.code.coding C where C in "Invasive Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

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

define GeneticPredisposition:
	exists([Condition]C
    where exists(C.code.coding C where C in "Genetic Susceptibility to Breast Cancer")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

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

define "Laterality":
	if exists("BreastCancerCondition" B
		where (exists(B.code.coding x where x in "Left breast cancer")
			or exists(B.code.coding x where x in "Left breast cancer")))
				then 'Unilateral'
					else if exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Bilateral breast cancer"))
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