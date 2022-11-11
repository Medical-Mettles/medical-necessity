library BreastCancerChemoSDC version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Breast Cancer": '2.16.840.1.113883.3.1434.1000.1095'
valueset "Estrogen Receptor Positive": '2.16.840.1.113762.1.4.1116.320'
valueset "Breast Cancer ER or PR Positive": '2.16.40.1.113883.3.526.2.1387'
valueset "Breast Cancer Primary Tumor Size T1": '2.16.840.1.113883.3.526.3.1305'
valueset "Breast Cancer Primary Tumor Size T1a": '2.16.840.1.113883.3.526.3.1164'
valueset "Breast Cancer Regional Lymph Node Status N0": '2.16.840.1.113883.3.526.3.1310'
valueset "Breast Distant Metastasis Status M0": '2.16.840.1.113883.3.526.3.1302'
valueset "HER2 Presence in Tissue": '2.16.840.1.113883.3.1444.5.207'
valueset "Docetaxel, Carboplatin and Trastuzumab Chemotherapy drugs": '2.16.840.1.113883.3.6037.1001.23.96.13'
valueset "Chemotherapy drugs allergy": '2.16.840.1.113883.3.6037.1001.23.96.14'
valueset "Cardiac Disease": '2.16.840.1.113762.1.4.1029.341'
valueset "Chronic Obstructive Pulmonary Diseases": '2.16.840.1.113883.17.4077.3.2063'
valueset "Liver Disease": '2.16.840.1.113762.1.4.1047.42'
valueset "Renal Disease": '2.16.840.1.113762.1.4.1029.335'
valueset "Bleeding Disorder": '2.16.840.1.113762.1.4.1029.287'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Progesterone receptor": '2.16.840.1.113883.3.6037.1001.23.96.16'
valueset "Estrogen receptor": '2.16.840.1.113883.3.6037.1001.23.96.15'
valueset "Neutrophil": '2.16.840.1.113883.3.6037.1001.23.96.17'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Breasts BodySite": '2.16.840.1.113883.3.6037.1001.23.96.18'
valueset "Left breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.19'
valueset "Right breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.20'
valueset "Bilateral breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.21'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "Mastectomy and Lumpectomy": '2.16.840.1.113883.3.6037.1001.23.96.22'
valueset "Stage type Clinical": '2.16.840.1.113883.3.6037.1001.23.96.23'
valueset "Stage type Pathological": '2.16.840.1.113883.3.6037.1001.23.96.24'
valueset "Clinical Tumor stage": '2.16.840.1.113883.3.6037.1001.23.96.25'
valueset "Pathological Regional Lymph Nodes": '2.16.840.1.113883.3.6037.1001.23.96.26'
valueset "Clinical Regional Lymph Nodes": '2.16.840.1.113883.3.6037.1001.23.96.27'
valueset "Pathological Metastasis Stages": '2.16.840.1.113883.3.6037.1001.23.96.28'
valueset "Clinical Metastasis Stages": '2.16.840.1.113883.3.6037.1001.23.96.29'
valueset "Tumor stage T0": '2.16.840.1.113883.3.6037.1001.23.94.02'
valueset "Tumor stage T1a": '2.16.840.1.113883.3.6037.1001.23.94.08'
valueset "Tumor stage T1b": '2.16.840.1.113883.3.6037.1001.23.94.09'
valueset "Tumor stage T1mi": '2.16.840.1.113883.3.6037.1001.23.94.07'
valueset "Tumor stage Tis(DCIS)": '2.16.840.1.113883.3.6037.1001.23.94.04'
valueset "Tumor stage Tis(LCIS)": '2.16.840.1.113883.3.6037.1001.23.94.05'
valueset "Tumor stage Tis(Pagets)": '2.16.840.1.113883.3.6037.1001.23.94.06'
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
valueset "Metastasis Stages M1": '2.16.840.1.113883.3.6037.1001.23.94.18'
valueset "Regional Lymph Nodes Nx": '2.16.840.1.113883.3.6037.1001.23.94.19'
valueset "Regional Lymph Nodes N1": '2.16.840.1.113883.3.6037.1001.23.94.20'
valueset "Regional Lymph Nodes N2": '2.16.840.1.113883.3.6037.1001.23.94.21'
valueset "Regional Lymph Nodes N3": '2.16.840.1.113883.3.6037.1001.23.94.22'
valueset "Metastasis stage M0": '2.16.840.1.113883.3.6037.1001.23.94.23'

parameter "MedicationRequest" MedicationRequest

context Patient

define "BreastCancerCondition":
	[Condition] C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Breast Cancer")


define "BreastCancerStaging":
  "BreastCancerCondition"B
    where (exists(B.stage s where exists(s.summary.coding x where x in "Breast Cancer Primary Tumor Size T1"))
          or exists(B.stage s where exists(s.summary.coding x where x in "Breast Cancer Primary Tumor Size T1a")))
    and exists(B.stage s where exists(s.summary.coding x where x in "Breast Cancer Regional Lymph Node Status N0"))
    and exists(B.stage s where exists(s.summary.coding x where x in "Breast Distant Metastasis Status M0"))

define "pTStage":
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

define "pNStagePathological":
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

define "pMStagePathological":
    if exists("BreastCancerCondition".stage S
			where exists(S.summary.coding C where C in "Metastasis Stages M1"))
			then 'M1'
			else if exists("BreastCancerCondition".stage S
					where exists(S.summary.coding C where C in "Metastasis stage M0"))
							then 'M0'
							else ''

define "StagingType":
	if exists("BreastCancerCondition"B
    where exists(B.stage s where exists(s.type.coding x where x in "Stage type Pathological")))
	then 'Pathological'
	else (if exists("BreastCancerCondition"B
					where exists(B.stage s where exists(s.type.coding x where x in "Stage type Clinical")))
				then 'Clinical'
				else ''
			)

define "AnatomicStage":
	if ({'Tis', 'N0', 'M0'} included in {"pTStage", "pNStagePathological", "pMStagePathological"})
	then 'Stage0'
	else (if ({'T1','T1mi','T1a','T1b','T1c', 'N0', 'M0'} properly includes {"pTStage", "pNStagePathological", "pMStagePathological"})
				then 'StageIA'
				else (if ({'T0', 'T1','T1mi','T1a','T1b','T1c','N1mi', 'M0'} properly includes {"pTStage", "pNStagePathological", "pMStagePathological"})
							then 'StageIB'
							else (if ({'T0', 'T1','T1mi','T1a','T1b','T1c', 'T2','N0','N1','N1a','N1b','N1c', 'M0' } included in {"pTStage", "pNStagePathological", "pMStagePathological"})
										then 'StageIIA'
										else (if ({'T2', 'T3', 'N0', 'N1', 'M0'} included in {"pTStage", "pNStagePathological", "pMStagePathological"})
												then 'StageIIB'
												else (if ({'T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'N1', 'N2', 'M0'} included in {"pTStage", "pNStagePathological", "pMStagePathological"})
															then 'StageIIIA'
															else (if ({'T4', 'N0', 'N1', 'N2', 'M0'} included in {"pTStage", "pNStagePathological", "pMStagePathological"})
																		then 'StageIIIB'
																		else (if ({'Tis','T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'T4', 'N3', 'M0'} included in {"pTStage", "pNStagePathological", "pMStagePathological"})
																					then 'StageIIIC'
																					else (if ({'Tis','T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'T4', 'N0','N1','N1a','N1b','N1c','N1mi', 'N2', 'N3', 'M1'} included in {"pTStage", "pNStagePathological", "pMStagePathological"})
																								then 'StageIV'
																								else ''
																							)
																				)
																	)
														)
												)
										)
							)
				)



define "HER2Observation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "HER2 Presence in Tissue")
			and (P.value as CodeableConcept) in "Positive") O
		with "MastectomyProcedure" P
		such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
	sort by end of "Normalize Interval"(effective)

define "PRObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Progesterone receptor")
			and (P.value as CodeableConcept) in "Positive") O
		with "MastectomyProcedure" P
		such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
	sort by end of "Normalize Interval"(effective)

define "ERObservation":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Estrogen receptor")
			and (P.value as CodeableConcept) in "Positive") O
		with "MastectomyProcedure" P
		such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
	sort by end of "Normalize Interval"(effective)

define "NeutrophilObservation":
  Last(([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Neutrophil")) O
		with "MastectomyProcedure" P
		such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
	sort by end of "Normalize Interval"(effective)
	)

define "NeutrophilResult":
	if FHIRHelpers.ToQuantity("NeutrophilObservation".value).unit = '/mm3'
	then FHIRHelpers.ToQuantity("NeutrophilObservation".value).value
  else 0

define "ChemoDrugsAdministration":
  [MedicationAdministration]M
	where M.status.value = 'completed'
	and (First((M.medication as CodeableConcept).coding) in "Docetaxel, Carboplatin and Trastuzumab Chemotherapy drugs"
		or First([Medication]med
							where (M.medication as Reference).reference.value = 'Medication/'+med.id.value
							and (First(med.code.coding) in "Docetaxel, Carboplatin and Trastuzumab Chemotherapy drugs") is not null
				) is not null
			) is not null

define "ProcedureResources":
	[Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Procedure for Medication Administration")

define "ChemoDrugsProcedure":
  Count("ProcedureResources" P
	with "ChemoDrugsAdministration" M
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value))

define "DrugsAdministration":
	"ChemoDrugsAdministration" M
	with "ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "ChemoDrugsAllergy":
	[AllergyIntolerance]A
		where First(A.clinicalStatus.coding).code.value = 'active'
    and exists(A.code.coding x where x in "Chemotherapy drugs allergy")

define "SpecificAllergies":
	"ChemoDrugsAllergy" A
	return A.code.coding[0].display.value+'\n'

define "AdverseEventsDrugs":
	[AdverseEvent]A
		where A.actuality in {'actual', 'potential'}
    and exists(A.event.coding x where x in "Chemotherapy drugs allergy")

define "MastectomyProcedure":
	Last([Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "Mastectomy and Lumpectomy")
		sort by end of "Normalize Interval"(performed)
		)

define "CardiacConditions":
	First([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Cardiac Disease"))

define "LiverConditions":
	First([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Liver Disease"))

define "RenalConditions":
	First([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Renal Disease"))

define "PreExistingConditionsResources":
	exists([Condition]C
	with [Condition]S
	such that C.subject.reference.value = 'Patient/'+ Patient.id.value
    and First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where (x in "Renal Disease")
										or (x in "Liver Disease")
										or (x in "Cardiac Disease"))
	and exists(S.code.coding x where x in "Breast Cancer")
	and start of "Normalize Onset"(C.onset) before start of "Normalize Onset"(S.onset))

define "PulmonaryConditionsHistory":
	[Condition]C
		where First(C.clinicalStatus.coding).code.value in {'active', 'recurrence', 'relapse','remission','resolved'}
    and exists(C.code.coding x where x in "Chronic Obstructive Pulmonary Diseases")

define "BleedingConditions":
	[Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Bleeding Disorder")

define "TumorSizeObservation":
  Last(([Observation]P where P.status.value in {'final', 'amended', 'corrected'}
			and First(P.code.coding C where C in "Tumor size") is not null
			and exists(P.bodySite.coding co where co in "Breasts BodySite")) O
		with "MastectomyProcedure" P
		such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
	sort by end of "Normalize Interval"(effective)
	)

define "TumourSize":
  if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'mm'
	then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value/10
  else (if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'cm'
        then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value
        else 0)

define "Laterality":
	if exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Left breast cancer"))
	then 'Left'
	else (if exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Right breast cancer"))
				then 'Right'
				else (if exists("BreastCancerCondition" B where exists(B.code.coding x where x in "Bilateral breast cancer"))
							then 'Bilateral'
							else ''
							)
				)

define "ERPositive":
	if Last("ERObservation") is not null
	then true
	else false

define "PRPositive":
	if Last("PRObservation") is not null
	then true
	else false

define "HER2Positive":
	if Last("HER2Observation") is not null
	then true
	else false

define "LineOfTherapy":
	if ("ChemoDrugsProcedure" =0 )
	then 1
	else "ChemoDrugsProcedure"

define "PreviousChemotherapyDrug":
	"DrugsAdministration" P
	return (if (P.medication as CodeableConcept) is not null
					then ((P.medication as CodeableConcept).coding[0].display.value+'\n')
					else (First([Medication]med
							where (P.medication as Reference).reference.value = 'Medication/'+med.id.value).code.coding[0].display.value+'\n')
				)

define "ChemotherapyAdverseEffectsBoolean":
	if Last("AdverseEventsDrugs") is not null
	then true
	else false

define "KnownAllergies":
	if Last("ChemoDrugsAllergy") is not null
	then true
	else false

define "PreExistingConditions":
	if ("PreExistingConditionsResources" = true) 
	then true
	else false

define "PulmonaryDiseaseHistory":
	if Last("PulmonaryConditionsHistory") is not null
	then true
	else false

define "BleedingDisorder":
	if Last("BleedingConditions") is not null
	then true
	else false

define "NeutrophilCount":
	if ("NeutrophilObservation" is not null)
	then FHIRHelpers.ToQuantity("NeutrophilObservation".value).value < 1500
	else false

//define "TumorStage":
//	if First(TumorCondition.stage).summary is not null
//	then First(First(TumorCondition.stage).summary.coding).display.value
//	else ''


define function "Normalize Interval"(choice Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
		else if choice is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	  else if choice is FHIR.Age then
	 	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age),
 		FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age) + 1 year)
		else if choice is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).high) + 1 year)
	  else null

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

