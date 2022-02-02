library RadiationOncology version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "Left breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.19'
valueset "Right breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.20'
valueset "Bilateral breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.21'
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
valueset "Stage type Clinical": '2.16.840.1.113883.3.6037.1001.23.96.23'
valueset "Stage type Pathological": '2.16.840.1.113883.3.6037.1001.23.96.24'
valueset "Breast cancer, unspecified site": '2.16.840.1.113883.3.6037.1001.23.93.260'
valueset "Breast cancer, upper quadrant": '2.16.840.1.113883.3.6037.1001.23.93.261'
valueset "Breast Cancer": '2.16.840.1.113883.3.1434.1000.1095'
valueset "Gene Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.41'
valueset "BRCA Gene": '2.16.840.1.113883.3.6037.1001.23.93.262'
valueset "Surgical Margins Involved by Tumor": '2.16.840.1.113883.3.6037.1001.23.93.166'
valueset "Distance of tumor from closest margin": '2.16.840.1.113883.3.6037.1001.23.93.263'
valueset "Lymphovascular invasion in Cancer": '2.16.840.1.113883.3.6037.1001.23.93.264'
valueset "Screening Mammography": '2.16.840.1.113883.3.6037.1001.23.93.265'
valueset "Histologic Grade": '2.16.840.1.113883.3.6037.1001.23.93.266'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Breasts BodySite": '2.16.840.1.113883.3.6037.1001.23.96.18'
valueset "IORT Electron": '2.16.840.1.113883.3.6037.1001.23.93.267'
valueset "IORT Xrays": '2.16.840.1.113883.3.6037.1001.23.93.268'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "HER2 Presence in Tissue": '2.16.840.1.113883.3.1444.5.207'
valueset "Progesterone receptor": '2.16.840.1.113883.3.6037.1001.23.96.16'
valueset "Estrogen receptor": '2.16.840.1.113883.3.6037.1001.23.96.15'
valueset "Image guided radiaiton therapy": '2.16.840.1.113883.3.6037.1001.23.93.269'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define "EncounterResource":
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define "EncounterPatient":
	"EncounterResource"

define Patient:
	([Patient]P with "EncounterResource" E
    		such that ('Patient/' + P.id.value) = E.subject.reference.value)

define PatientMedicaidNumber:
	"Patient".identifier.value

define BreastCancerConditionLeft:
	First([Condition]C
		where exists(C.code.coding C where C in "Left breast cancer")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define BreastCancerConditionRight:
	First([Condition]C
		where exists(C.code.coding C where C in "Right breast cancer")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define BreastCancerConditionBilateral:
	First([Condition]C
		where exists(C.code.coding C where C in "Bilateral breast cancer")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define CancerCondition:
  if (("BreastCancerConditionRight" is not null)
				or ("BreastCancerConditionRight" is not null)
					or ("BreastCancerConditionBilateral" is not null))
    then 'Breast Cancer'
      else ''

define Laterality:
	if ("BreastCancerConditionLeft" is not null)
		then 'Left'
			else if ("BreastCancerConditionRight" is not null)
				then 'Right'
					else if ("BreastCancerConditionBilateral" is not null)
							then 'Bilateral'
								else ''

define BCUnspecifiedSite:
	[Condition]C
		where exists(C.code.coding C where C in "Breast cancer, unspecified site")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define BCUpperQuadrant:
	[Condition]C
		where exists(C.code.coding C where C in "Breast cancer, upper quadrant")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define TumorLocation:
	if exists("BCUnspecifiedSite")
		then 'Unspecified Site'
			else if exists("BCUpperQuadrant")
				then 'Upper-Outer Quadrant'
					else ''

define BreastCancerCondition:
	[Condition] C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Breast Cancer")

define StagingType:
	if exists("BreastCancerCondition"B
    where exists(B.stage s where exists(s.type.coding x where x in "Stage type Pathological")))
			then 'Pathological'
				else (if exists("BreastCancerCondition"B
					where exists(B.stage s where exists(s.type.coding x where x in "Stage type Clinical")))
						then 'Clinical'
							else ''
						)

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

define AnatomicStage:
	if ({'Tis', 'N0', 'M0'} included in {"TStage", "NStage", "MStage"})
		then 'Stage0'
			else (if ({'T1','T1mi','T1a','T1b','T1c', 'N0', 'M0'} properly includes {"TStage", "NStage", "MStage"})
				then 'StageIA'
					else (if ({'T0', 'T1','T1mi','T1a','T1b','T1c','N1mi', 'M0'} properly includes {"TStage", "NStage", "MStage"})
						then 'StageIB'
							else (if ({'T0', 'T1','T1mi','T1a','T1b','T1c', 'T2','N0','N1','N1a','N1b','N1c', 'M0' } included in {"TStage", "NStage", "MStage"})
								then 'StageIIA'
									else (if ({'T2', 'T3', 'N0', 'N1', 'M0'} included in {"TStage", "NStage", "MStage"})
										then 'StageIIB'
											else (if ({'T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'N1', 'N2', 'M0'} included in {"TStage", "NStage", "MStage"})
												then 'StageIIIA'
													else (if ({'T4', 'N0', 'N1', 'N2', 'M0'} included in {"TStage", "NStage", "MStage"})
														then 'StageIIIB'
															else (if ({'Tis','T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'T4', 'N3', 'M0'} included in {"TStage", "NStage", "MStage"})
																then 'StageIIIC'
																	else (if ({'Tis','T0', 'T1','T1mi','T1a','T1b','T1c','T2', 'T3', 'T4', 'N0','N1','N1a','N1b','N1c','N1mi', 'N2', 'N3', 'M1'} included in {"TStage", "NStage", "MStage"})
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

define BRCAMutation:
	exists([Observation] O
    where O.meta.profile[0].value = 'http://hl7.org/fhir/StructureDefinition/observation-genetics'
    and exists(O.code.coding C where C in "Gene Mutation Test")
    and exists(O.extension E
                where E.url = 'http://hl7.org/fhir/StructureDefinition/observation-geneticsGene'
                and exists(((E.value as CodeableConcept).coding) C  where C in "BRCA Gene")))

define NegativeMarginsObv:
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Surgical Margins Involved by Tumor")
			and (P.value as boolean) = true)

define MarginDistanceObservation:
	First([Observation]P where P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Distance of tumor from closest margin") is not null)

define MarginDistance:
  if FHIRHelpers.ToQuantity("MarginDistanceObservation".value).unit = 'mm'
		then FHIRHelpers.ToQuantity("MarginDistanceObservation".value).value
        else 0

define NegativeMargins:
	if ("NegativeMarginsObv" = true)
		and ("MarginDistance" >= 2)
			then true
				else false

define "HER2Positive":
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "HER2 Presence in Tissue")
			and (P.value as CodeableConcept) in "Positive")

define "PRPositive":
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Progesterone receptor")
			and (P.value as CodeableConcept) in "Positive")

define "ERPositive":
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Estrogen receptor")
			and (P.value as CodeableConcept) in "Positive")

//define "ERPositive":
//	if Last("ERObservation") is not null
//	then true
//	else false
//
//define "PRPositive":
//	if Last("PRObservation") is not null
//	then true
//	else false
//
//define "HER2Positive":
//	if Last("HER2Observation") is not null
//	then true
//	else false

define LymphovascularInvasion:
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Lymphovascular invasion in Cancer")
			and (P.value as CodeableConcept) in "Positive")

define SecondaryCancerDiagnosis:
	Last([Condition] C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Breast Cancer"))

define SecondaryCancerCondition:
	if ("SecondaryCancerDiagnosis" is not null)
		then 'Breast Cancer'
			else ''

define BCUpperQuadrantSecondary:
	Last([Condition]C
		where exists(C.code.coding C where C in "Breast cancer, upper quadrant")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define TumorLocationSecondary:
	if ("BCUpperQuadrantSecondary" is not null)
		then 'Upper-Outer Quadrant'
			else ''

define ScreeningMammography:
	([Procedure]P where P.status.value = 'completed'
		and First(P.code.coding) in "Screening Mammography")

define TumorDetected:
	if exists("ScreeningMammography")
		then true
			else false

define TumorScreening:
	if exists("ScreeningMammography")
		then 'Screening Mammography'
				else ''

define HistologicGrade:
	[Observation]P
		where P.status.value in {'final', 'amended', 'corrected'}
    and exists(P.code.coding x where x in "Histologic Grade")
		and (P.value as boolean) = true

define SpecifyHistologicGrade:
	"HistologicGrade" P
		return P.code.coding[0].display.value+'\n'

define "TumorSizeObservation":
  Last([Observation]P where P.status.value in {'final', 'amended', 'corrected'}
			and First(P.code.coding C where C in "Tumor size") is not null
			and exists(P.bodySite.coding co where co in "Breasts BodySite"))

define "TumorSizeResult":
  if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'mm'
	then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value/10
  else (if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'cm'
        then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value
        else 0)

define TumorSize:
	if ("TumorSizeResult" <= 2.5)
		then true
			else false

define NegativeMarginsSecondaryObservation:
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Surgical Margins Involved by Tumor")
			and (P.value as boolean) = true)

define SecondaryMarginDistanceObservation:
	Last([Observation]P where P.status.value in {'final', 'amended', 'corrected'}
		and Last(P.code.coding C where C in "Distance of tumor from closest margin") is not null)

define SecondaryMarginDistance:
  if FHIRHelpers.ToQuantity("SecondaryMarginDistanceObservation".value).unit = 'mm'
		then FHIRHelpers.ToQuantity("SecondaryMarginDistanceObservation".value).value
        else 0

define NegativeMarginsSecondary:
	if ("NegativeMarginsSecondaryObservation" = true
				and "SecondaryMarginDistance" >= 3)
					then true
						else false

define IORTElectron:
  "Request".code.coding C where C in "IORT Electron"

define IORTXrays:
  "Request".code.coding C where C in "IORT Xrays"

define IORTService:
	if exists("IORTElectron")
		or exists("IORTXrays")
			then true
				else false

define TreatmentPlan:
	if ("IORTService" = true)
		then 'Intraoperative radiation therapy (IORT)'
			else ''

define RadiationTreatmentStartDate:
	ToDate(start of "Normalize Interval"("ServiceRequest".occurrence))

define IORTType:
  if exists("IORTElectron")
		then 'Electron Beams'
			else if exists("IORTXrays")
				then 'X-rays'
					else ''

define IGRTService:
	exists("Request".code.coding C where C in "Image guided radiaiton therapy")


define function "Normalize Interval"(choice Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
		else if choice is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	  else null