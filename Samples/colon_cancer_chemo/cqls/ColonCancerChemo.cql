library ColonCancerChemo version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Colon Cancer": '2.16.840.1.113883.3.526.3.391'
valueset "Colon Cancer Primary Tumor Size T3": '2.16.840.1.113883.3.526.3.1294'
valueset "Colon Cancer Regional Lymph Node Status N1b": '2.16.840.1.113883.3.526.3.1328'
valueset "Colon Distant Metastasis Status M0": '2.16.840.1.113883.3.526.3.1337'
valueset "Colon Tumor Stage TX": '2.16.840.1.113883.3.6037.1001.23.93.22'
valueset "Colon Tumor Stage T0": '2.16.840.1.113883.3.6037.1001.23.93.21'
valueset "Colon Tumor Stage Tis": '2.16.840.1.113883.3.6037.1001.23.93.01'
valueset "Colon Tumor Stage T1": '2.16.840.1.113883.3.6037.1001.23.93.02'
valueset "Colon Tumor Stage T2": '2.16.840.1.113883.3.6037.1001.23.93.03'
valueset "Colon Tumor Stage T3": '2.16.840.1.113883.3.6037.1001.23.93.04'
valueset "Colon Tumor Stage T4a": '2.16.840.1.113883.3.6037.1001.23.93.05'
valueset "Colon Tumor Stage T4b": '2.16.840.1.113883.3.6037.1001.23.93.06'
valueset "Colon Regional Lymph Nodes NX": '2.16.840.1.113883.3.6037.1001.23.93.07'
valueset "Colon Regional Lymph Nodes N0": '2.16.840.1.113883.3.6037.1001.23.93.08'
valueset "Colon Regional Lymph Nodes N1": '2.16.840.1.113883.3.6037.1001.23.93.09'
valueset "Colon Regional Lymph Nodes N1a": '2.16.840.1.113883.3.6037.1001.23.93.10'
valueset "Colon Regional Lymph Nodes N1b": '2.16.840.1.113883.3.6037.1001.23.93.11'
valueset "Colon Regional Lymph Nodes N1c": '2.16.840.1.113883.3.6037.1001.23.93.12'
valueset "Colon Regional Lymph Nodes N2": '2.16.840.1.113883.3.6037.1001.23.93.13'
valueset "Colon Regional Lymph Nodes N2a": '2.16.840.1.113883.3.6037.1001.23.93.14'
valueset "Colon Regional Lymph Nodes N2b": '2.16.840.1.113883.3.6037.1001.23.93.15'
valueset "Colon Metastasis Stage M0": '2.16.840.1.113883.3.6037.1001.23.93.16'
valueset "Colon Metastasis Stage M1": '2.16.840.1.113883.3.6037.1001.23.93.17'
valueset "Colon Metastasis Stage M1a": '2.16.840.1.113883.3.6037.1001.23.93.18'
valueset "Colon Metastasis Stage M1b": '2.16.840.1.113883.3.6037.1001.23.93.19'
valueset "Colon Metastasis Stage M1c": '2.16.840.1.113883.3.6037.1001.23.93.20'
valueset "Stage type Pathological": '2.16.840.1.113883.3.6037.1001.23.96.24'
valueset "Stage type Clinical": '2.16.840.1.113883.3.6037.1001.23.96.23'
valueset "MMR Deficiency Test": '2.16.840.1.113883.3.6037.1001.23.93.23'
valueset "MSI Test": '2.16.840.1.113883.3.6037.1001.23.93.24'
valueset "CEA Level In Blood": '2.16.840.1.113883.3.6037.1001.23.93.25'
valueset "KRAS Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.26'
valueset "NRAS Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.27'
valueset "BRAF Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.28'
valueset "Neutrophil": '2.16.840.1.113883.3.6037.1001.23.96.17'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Sigmoid Colectomy": '2.16.840.1.113883.3.6037.1001.23.93.29'
valueset "Folinic acid, 5-fluorouracil and Oxaliplatin Chemotherapy drugs": '2.16.840.1.113883.3.6037.1001.23.93.30'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "FOLFOX Chemotherapy drugs allergy": '2.16.840.1.113883.3.6037.1001.23.93.31'
valueset "DPD Condition": '2.16.840.1.113883.3.6037.1001.23.93.32'
valueset "Vit B12 Deficiency": '2.16.840.1.113883.3.6037.1001.23.93.33'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Negative Result": '2.16.840.1.113762.1.4.1116.292'
valueset "Type of Colon Cancer": '2.16.840.1.113883.3.6037.1001.23.93.37'
valueset "Colon Cancer Location": '2.16.840.1.113883.3.6037.1001.23.93.38'
valueset "Histologic Cancer Grade": '2.16.840.1.113883.3.6037.1001.23.93.39'
valueset "Lymph Node Excision": '2.16.840.1.113883.3.6037.1001.23.93.40'
valueset "Gene Mutation Test": '2.16.840.1.113883.3.6037.1001.23.93.41'
valueset "KRAS Gene": '2.16.840.1.113883.3.6037.1001.23.93.42'
valueset "KRAS ClinVar ID": '2.16.840.1.113883.3.6037.1001.23.93.43'
valueset "KRAS Allele State": '2.16.840.1.113883.3.6037.1001.23.93.44'

parameter "MedicationRequest" MedicationRequest

context Patient

define "ColonCancerCondition":
  [Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Colon Cancer")

define "ColonCancerStaging":
  "ColonCancerCondition"C
    where exists(C.stage s where exists(s.summary.coding x where x in "Colon Cancer Primary Tumor Size T3"))
    and exists(C.stage s where exists(s.summary.coding x where x in "Colon Cancer Regional Lymph Node Status N1b"))
    and exists(C.stage s where exists(s.summary.coding x where x in "Colon Distant Metastasis Status M0"))

define "TStage":
	if exists("ColonCancerCondition".stage S
        where exists(S.summary.coding C where C in "Colon Tumor Stage TX"))
				  then 'TX'
        else if exists("ColonCancerCondition".stage S
          where exists(S.summary.coding C where C in "Colon Tumor Stage T0"))
            then 'T0'
          else if exists("ColonCancerCondition".stage S
	    where exists(S.summary.coding C where C in "Colon Tumor Stage Tis"))
	     then 'Tis'
            else if exists("ColonCancerCondition".stage S
	      where exists(S.summary.coding C where C in "Colon Tumor Stage T1"))
		then 'T1'
              else if exists("ColonCancerCondition".stage S
		where exists(S.summary.coding C where C in "Colon Tumor Stage T2"))
		  then 'T2'
                else if exists("ColonCancerCondition".stage S
		  where exists(S.summary.coding C where C in "Colon Tumor Stage T3"))
		    then 'T3'
                  else if exists("ColonCancerCondition".stage S
		    where exists(S.summary.coding C where C in "Colon Tumor Stage T4a"))
		      then 'T4a'
                    else if exists("ColonCancerCondition".stage S
		      where exists(S.summary.coding C where C in "Colon Tumor Stage T4b"))
			then 'T4b'
                          else ''

define "NStage":
	if exists("ColonCancerCondition".stage S
		where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes NX"))
				then 'NX'
				else if exists("ColonCancerCondition".stage S
							where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N0"))
									then 'N0'
						else if exists("ColonCancerCondition".stage S
								where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N1"))
										then 'N1'
                else if exists("ColonCancerCondition".stage S
										where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N1a"))
												then 'N1a'
										else if exists("ColonCancerCondition".stage S
												where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N1b"))
														then 'N1b'
                        else if exists("ColonCancerCondition".stage S
												    where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N1c"))
														    then 'N1c'
                            else if exists("ColonCancerCondition".stage S
										            where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N2"))
												            then 'N2'
										            else if exists("ColonCancerCondition".stage S
												            where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N2a"))
														            then 'N2a'
                                    else if exists("ColonCancerCondition".stage S
												                where exists(S.summary.coding C where C in "Colon Regional Lymph Nodes N2b"))
														                then 'N2b'
														            else ''

define "MStage":
    if exists("ColonCancerCondition".stage S
			where exists(S.summary.coding C where C in "Colon Metastasis Stage M0"))
			then 'M0'
			else if exists("ColonCancerCondition".stage S
					where exists(S.summary.coding C where C in "Colon Metastasis Stage M1"))
							then 'M1'
          else if exists("ColonCancerCondition".stage S
					    where exists(S.summary.coding C where C in "Colon Metastasis Stage M1a"))
							    then 'M1a'
              else if exists("ColonCancerCondition".stage S
					        where exists(S.summary.coding C where C in "Colon Metastasis Stage M1b"))
							        then 'M1b'
                  else if exists("ColonCancerCondition".stage S
					            where exists(S.summary.coding C where C in "Colon Metastasis Stage M1c"))
							            then 'M1c'
							        else ''


define "StagingType":
	if exists("ColonCancerCondition"C
    where exists(C.stage s where exists(s.type.coding x where x in "Stage type Pathological")))
	then 'Pathological'
	else (if exists("ColonCancerCondition"C
					where exists(C.stage s where exists(s.type.coding x where x in "Stage type Clinical")))
				then 'Clinical'
				else ''
			)

define "AnatomicStage":
	if ({'Tis', 'N0', 'M0'} included in {"TStage", "NStage", "MStage"})
		then 'Stage0'
			else if (({'T1', 'N0', 'M0'} included in {"TStage", "NStage", "MStage"})
						or ({'T2','N0','M0'} included in {"TStage", "NStage", "MStage"}))
					then 'StageI'
						else if ({'T3', 'N0', 'M0'} properly includes {"TStage", "NStage", "MStage"})
							then 'StageIIA'
								else if ({'T4a', 'N0', 'M0' } included in {"TStage", "NStage", "MStage"})
									then 'StageIIB'
										else if ({'T4b', 'N0', 'M0'} included in {"TStage", "NStage", "MStage"})
											then 'StageIIC'
												else if (({'T1', 'N1', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T1', 'N1a','M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T1', 'N1b', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T1', 'N1c', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T2', 'N1', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T2', 'N1a', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T2', 'N1b', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T2', 'N1c', 'M0'} included in {"TStage", "NStage", "MStage"})
															or ({'T1', 'N2a', 'M0'} included in {"TStage", "NStage", "MStage"}))
																then 'StageIIIA'
																	else if (({'T3', 'N1', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T3', 'N1a', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T3', 'N1b', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T3', 'N1c', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T4a', 'N1', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T4a', 'N1a', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T4a', 'N1b', 'M0'} included in {"TStage", "NStage", "MStage"})
																				or ({'T4a', 'N1c', 'M0'} included in {"TStage", "NStage", "MStage"})
                                    		or ({'T2', 'N2a', 'M0'} included in {"TStage", "NStage", "MStage"})
                                    		or ({'T3', 'N2a', 'M0'} included in {"TStage", "NStage", "MStage"})
                                    		or ({'T1', 'N2b', 'M0'} included in {"TStage", "NStage", "MStage"})
                                    		or ({'T2', 'N2b', 'M0'} included in {"TStage", "NStage", "MStage"}))
																		    then 'StageIIIB'
                                        else if (({'T4a', 'N2a', 'M0'} included in {"TStage", "NStage", "MStage"})
																							or ({'T3', 'N2b', 'M0'} included in {"TStage", "NStage", "MStage"})
																							or ({'T4a', 'N2b', 'M0'} included in {"TStage", "NStage", "MStage"})
                                              or ({'T4b','N1', 'M0'} included in {"TStage", "NStage", "MStage"})
                                              or ({'T4b', 'N2','M0'} included in {"TStage", "NStage", "MStage"}))
																								then 'StageIIIC'
																									else (if ({'Tis','T0', 'T1','TX', 'T2', 'T3', 'T4', 'T4a', 'T4b', 'NX', 'N0','N1', 'N1a','N1b','N1c','N2', 'N2a', 'N2b', 'M1a'} properly includes {"TStage", "NStage", "MStage"})
																										then 'StageIVA'
																											else (if ({'Tis','T0', 'T1','TX', 'T2', 'T3', 'T4', 'T4a', 'T4b', 'NX', 'N0','N1', 'N1a','N1b','N1c','N2', 'N2a', 'N2b', 'M1b'} properly includes {"TStage", "NStage", "MStage"})
																												then 'StageIVB'
																													else (if ({'Tis','T0', 'T1','TX', 'T2', 'T3', 'T4', 'T4a', 'T4b', 'NX', 'N0','N1', 'N1a','N1b','N1c','N2', 'N2a', 'N2b', 'M1c'} properly includes {"TStage", "NStage", "MStage"})
																														then 'StageIVC'
																															else ''
																																)
																														)
																												)

define "MMRDeficiencyObservation":
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "MMR Deficiency Test")
			and (P.value as boolean) = true)

define "MMRDeficiencyResult":
	if ("MMRDeficiencyObservation"  is true)
	then true
	else false

define "MicrosatelliteInstabilityObservation":
	exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "MSI Test")
			and (P.value as CodeableConcept) in "Negative Result")

define "MSIResult":
	if ("MicrosatelliteInstabilityObservation" is true)
	then true
	else false

define "CEALevelInBloodObservation":
	Last ([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "CEA Level In Blood"))


define "CEALevelInBloodResult":
	if FHIRHelpers.ToQuantity("CEALevelInBloodObservation".value).unit = 'ng/ml'
	then FHIRHelpers.ToQuantity("CEALevelInBloodObservation".value).value
  else 0

define "CEALevelInBlood":
	if ("CEALevelInBloodObservation" is not null)
	then FHIRHelpers.ToQuantity("CEALevelInBloodObservation".value).value < 2.5
	else false

define "GenomicsReport":
	([Observation] O
    where O.meta.profile[0].value = 'http://hl7.org/fhir/StructureDefinition/observation-genetics'
    and exists(O.code.coding C where C in "Gene Mutation Test")
    and exists(O.extension E
                where E.url = 'http://hl7.org/fhir/StructureDefinition/observation-geneticsGene'
                and exists(((E.value as CodeableConcept).coding) C  where C in "KRAS Gene")))


define "TumorGenomicsObservations":
	if "GenomicsReport" is not null
	     then true
	      else false

define "KRASMutationExtension":
"GenomicsReport".extension G
		where (G.url = 'http://hl7.org/fhir/StructureDefinition/observation-geneticsGene')
			and exists(((G.value as CodeableConcept).coding) C  where C in "KRAS Gene")
			return G.value

define "KRASMutation":
	"KRASMutationExtension".coding ext
		return (ext.display.value)

define "SpecifyDNARegionName":
	"GenomicsReport".extension G
			where G.url = 'http://hl7.org/fhir/StructureDefinition/observation-geneticsDNARegionName'
				and ((G.value as string) = 'Exon 2')
				return G.value

define "KRASClinVarIDExtension":
	"GenomicsReport".extension E
					where (E.url = 'http://hl7.org/fhir/StructureDefinition/observation-geneticsVariant')
							and exists(E.extension ext
                			return (((ext.value as CodeableConcept).coding) C where C in "KRAS ClinVar ID"))

define "KRASClinVarCode":
	"KRASClinVarIDExtension".extension E
				return E.value

define "KRASClinVarID":
	"KRASClinVarCode".coding ext
		return (ext.code.value)

define "KRASAlleleStateExtension":
	"GenomicsReport".extension E
				where (E.url = 'http://hl7.org/fhir/StructureDefinition/observation-geneticsAllele')
						and exists(E.extension ext
								return (((ext.value as CodeableConcept).coding) C  where C in "KRAS Allele State"))

define "KRASAlleleCode":
	"KRASAlleleStateExtension".extension E
				return E.value

define "KRASAlleleState":
	"KRASAlleleCode".coding ext
		return (ext.display.value)

define "NeutrophilObservation":
  Last([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Neutrophil"))

define "NeutrophilResult":
	if FHIRHelpers.ToQuantity("NeutrophilObservation".value).unit = '/mm3'
	then FHIRHelpers.ToQuantity("NeutrophilObservation".value).value
  else 0

define "NeutrophilCount":
	if ("NeutrophilObservation" is not null)
	then FHIRHelpers.ToQuantity("NeutrophilObservation".value).value < 1500
	else false

define "TumorSizeObservation":
  Last(([Observation]P where P.status.value in {'final', 'amended', 'corrected'}
			and First(P.code.coding C where C in "Tumor size") is not null) O
		with "ColectomyProcedure" P
		such that start of "Normalize Interval"(O.effective) after end of "Normalize Interval"(P.performed)
	sort by end of "Normalize Interval"(effective)
	)

define "TumorSize":
  if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'mm'
	then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value/10
  else (if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'cm'
        then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value
        else 0)

define "ColectomyProcedure":
	([Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "Sigmoid Colectomy")
		)

define "LymphNodeExcision":
	([Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "Lymph Node Excision")
		)

define "SpecifyPrevProcedures":
	("ColectomyProcedure" union "LymphNodeExcision")P
	return (First(P.code.coding).display.value)+'\n'

define "ChemoDrugsAdministration":
  [MedicationAdministration]M
	where M.status.value = 'completed'
	and (First((M.medication as CodeableConcept).coding) in "Folinic acid, 5-fluorouracil and Oxaliplatin Chemotherapy drugs"
		or First([Medication]med
							where (M.medication as Reference).reference.value = 'Medication/'+med.id.value
							and (First(med.code.coding) in "Folinic acid, 5-fluorouracil and Oxaliplatin Chemotherapy drugs") is not null
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
    and exists(A.code.coding x where x in "FOLFOX Chemotherapy drugs allergy")

define "KnownAllergies":
	if Last("ChemoDrugsAllergy") is not null
	then true
	else false

define "SpecificAllergies":
	"ChemoDrugsAllergy" A
	return A.code.coding[0].display.value+'\n'

define "DPDCondition":
	[Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "DPD Condition")

define "DPD":
	if Last("DPDCondition") is not null
	then true
	else false

define "VitB12DeficiencyCondition":
	[Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Vit B12 Deficiency")

define "VitB12Deficiency":
	if Last("VitB12DeficiencyCondition") is not null
	then true
	else false

define "ColonCancerLocation":
	"ColonCancerCondition".bodySite.coding[0].display.value+'\n'

define "TypeColonCancer":
	([Observation]P
		where P.status.value in {'final', 'amended', 'corrected'}
    and exists(P.code.coding x where x in "Type of Colon Cancer")
		and (P.value as boolean) = true)

define "SpecifyTypeCancer":
	"TypeColonCancer" P
		return P.code.coding[0].display.value+'\n'

define "SpecifyColonCancer":
	"ColonCancerCondition" C
		return C.code.coding[0].display.value+'\n'

define "HistologicCancerGrade":
	([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Histologic Cancer Grade")
			and (P.value as boolean) = true)

define "SpecifyCancerGrade":
	"HistologicCancerGrade" P
		return P.code.coding[0].display.value+'\n'


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








