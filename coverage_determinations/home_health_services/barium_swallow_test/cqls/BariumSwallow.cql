library BariumSwallow version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD10CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "ICD10PCS": 'http://hl7.org/fhir/us/core/ValueSet/us-core-procedure-icd10pcs'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "LOINC": 'http://loinc.org'
codesystem "NUCCPT": 'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "ActEncounterCodev2": 'http://terminology.hl7.org/CodeSystem/v2-0004'
codesystem "ActEncounterCode": 'http://terminology.hl7.org/ValueSet/v3-ActEncounterCode'

valueset "Primary Diagnosis Codes for MBS": '2.16.840.1.113883.3.6037.1001.23.95.51'
valueset "Secondary Diagnosis Codes for MBS": '2.16.840.1.113883.3.6037.1001.23.95.52'
valueset "History of Radiation": '2.16.840.1.113762.1.4.1116.519'
valueset "Weight Loss (SNOMED)": '2.16.840.1.113762.1.4.1146.702'
valueset "Weight Loss (ICD10CM)": '2.16.840.1.113762.1.4.1146.703'
valueset "Feeding Device SNOMED CT": '2.16.840.1.113762.1.4.1095.61'
valueset "Amyotrophic Lateral Sclerosis (ALS) and Related Motor Neuron Disease (ICD10CM)": '2.16.840.1.113762.1.4.1034.390'
valueset "Intubation [Respiratory Tract] (Procedure) (SNOMED)": '2.16.840.1.113762.1.4.1146.1426'
valueset "Esophageal Tear": '2.16.840.1.113762.1.4.1200.186'
valueset "External Beam Radiotherapy": '2.16.840.1.113762.1.4.1116.356'
valueset "Gastroesophageal Reflux": '2.16.840.1.113762.1.4.1222.1437'

code "Bedside Swallowing and Oral Function Assessment using Other Equipment": 'F00ZHYZ' from "ICD10PCS" display 'Bedside Swallowing and Oral Function Assessment using Other Equipment'
code "Bedside testing (procedure)": '405264000' from "SNOMEDCT" display 'Bedside testing (procedure)'
code "Bedside Swallowing and Oral Function Assessment": 'F00ZHZZ' from "ICD10PCS" display 'Bedside Swallowing and Oral Function Assessment'
code "Bedside laboratory testing (procedure)" : '386521001' from "SNOMEDCT" display 'Bedside laboratory testing (procedure)'
code "Dietary liquid consistency diet (regime/therapy)": '435681000124103' from "SNOMEDCT" display 'Dietary liquid consistency diet (regime/therapy)'
code "Liquid diet (regime/therapy)": '435731000124108' from "SNOMEDCT" display 'Liquid diet (regime/therapy)'
code "Clear liquid diet (regime/therapy)": '435741000124103' from "SNOMEDCT" display 'Clear liquid diet (regime/therapy)'
code "Full liquid diet (regime/therapy)": '435751000124101' from "SNOMEDCT" display 'Full liquid diet (regime/therapy)'
code "Pureed diet (regime/therapy)": '439121000124106' from "SNOMEDCT" display 'Pureed diet (regime/therapy)'
code "Difficulty swallowing solids (finding)": '162024005' from "SNOMEDCT" display 'Difficulty swallowing solids (finding)'
code "Difficulty swallowing fluid (finding)": '162025006' from "SNOMEDCT" display 'Difficulty swallowing fluid (finding)'
code "Solid food (substance)": '228060008'  from "SNOMEDCT" display 'Solid food (substance)'
code "Swallowing problem (finding)": '399122003' from "SNOMEDCT" display 'Swallowing problem (finding)'
code "Swallowing painful (finding)": '30233002' from "SNOMEDCT" display 'Swallowing painful (finding)'
code "Difficulty chewing (finding)": '162020001'  from "SNOMEDCT" display 'Difficulty chewing (finding)'
code "Able to swallow solids (finding)": '306769002' from "SNOMEDCT" display 'Able to swallow solids (finding)'
code "Ability to swallow soft foods (observable entity)": '306773004' from "SNOMEDCT" display 'Ability to swallow soft foods (observable entity)'
code "Unable to swallow tablet (finding)": '702551003' from "SNOMEDCT" display 'Unable to swallow tablet (finding)'
code "Difficulty swallowing pills (finding)": '8801000175101' from "SNOMEDCT" display 'Difficulty swallowing pills (finding)'
code "Painful mouth (finding)": '102616008' from "SNOMEDCT" display 'Painful mouth (finding)'
code "Choking sensation (finding)": '373909009'from "SNOMEDCT" display 'Choking sensation (finding)'
code "Excessive salivation (disorder)": '53827007' from "SNOMEDCT" display 'Excessive salivation (disorder)'


parameter "Encounter" Encounter
parameter "ServiceRequest" ServiceRequest

context Patient

define PrimaryDiagnosisCondition:
    First([Condition]S
        where exists(S.code.coding C where C in "Primary Diagnosis Codes for MBS")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed')

define PrimaryDiagnosis:
    PrimaryDiagnosisCondition.code.coding C
        return C.display.value

define SecondaryDiagnosisCondition:
    First([Condition]S
        where exists(S.code.coding C where C in "Secondary Diagnosis Codes for MBS")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed')

define SecondaryDiagnosis:
    SecondaryDiagnosisCondition.code.coding C
        return C.display.value

define OnsetDate:
    start of "Normalize Onset"("PrimaryDiagnosisCondition".onset)

define function ToCode(coding FHIR.Coding):
    if coding is null then
        null
    else
        System.Code {
          code: coding.code.value,
          system: coding.system.value,
          version: coding.version.value,
          display: coding.display.value
        }

define BedsideTesting:
    First([Procedure]P
        where ("ToCode"(First(P.code.coding)) = "Bedside Swallowing and Oral Function Assessment using Other Equipment"
            or "ToCode"(First(P.code.coding)) = "Bedside testing (procedure)"
            or "ToCode"(First(P.code.coding)) = "Bedside Swallowing and Oral Function Assessment"
            or "ToCode"(First(P.code.coding)) = "Bedside laboratory testing (procedure)")
        and P.status.value = 'completed')

define BedsideCompleted:
    if ("BedsideTesting" is not null)
    then true
    else false

define ProblemsWithDiet:
    if exists([Condition]O
		where "ToCode"(First(O.code.coding)) = "Difficulty swallowing solids (finding)")
	then 'Solids'
    else if exists([Condition]O
		where "ToCode"(First(O.code.coding)) = "Difficulty swallowing fluid (finding)")
	then 'Thin Liquid'
    else if exists([Condition]O
		where "ToCode"(First(O.code.coding)) = "Pureed diet (regime/therapy)")
	then 'Pureed'
    else ''

define PresentDiet:
    if exists([Observation]O
		where "ToCode"(First(O.code.coding)) = "Solid food (substance)")
	then 'Solids'
    else if exists([Observation]O
		where "ToCode"(First(O.code.coding)) = "Liquid diet (regime/therapy)")
	then 'Thin Liquid'
    else if exists([Observation]O
		where "ToCode"(First(O.code.coding)) = "Pureed diet (regime/therapy)")
	then 'Pureed'
    else ''

define ApplicableDiagnosis:
    if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Feeding Device SNOMED CT"))
			then 'Feeding Tube'
    else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Amyotrophic Lateral Sclerosis (ALS) and Related Motor Neuron Disease (ICD10CM)"))
			then 'ALS'
    else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Esophageal Tear"))
			then 'Esophageal Stretching'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Intubation [Respiratory Tract] (Procedure) (SNOMED)"))
			then 'Intubation'
    else ''

define RadiationTreatment:
    if exists(([Procedure]P
        where exists(P.code.coding C
						where C in "External Beam Radiotherapy")      
        and P.status.value = 'completed')
        union
        ([Condition] P
					where exists(P.code.coding P
						where P in "History of Radiation")))
    then true
    else false

define TroubleWithPills:
    if exists([Condition] P
					where "ToCode"(First(P.code.coding)) = "Difficulty swallowing pills (finding)")
			then true
            else false

define ApplicableSymptoms:
    {
        (if exists([Observation] O
				where "ToCode"(First(O.code.coding)) = "Swallowing painful (finding)")
			then 'Painful Swallowing' 
            else null),
        (if exists([Observation] O
				where "ToCode"(First(O.code.coding)) = "Painful mouth (finding)")
			then 'Pain inside mouth' 
            else null),
        (if exists([Observation] O
				where exists(O.code.coding O
					where O in "Gastroesophageal Reflux"))
			then 'Gastroesophageal Reflux (GERD)' else null),
        (if exists([Observation] O
				where "ToCode"(First(O.code.coding)) = "Choking sensation (finding)")
			then 'Choking Sensation' else null),
        (if exists([Observation] O
				where "ToCode"(First(O.code.coding)) = "Excessive salivation (disorder)")
			then 'Increased Salivation' else null)
    }

define WeightLossCondition:
    First([Condition]S
        where exists(S.code.coding P
						where ( P in "Weight Loss (SNOMED)"
                                or P in "Weight Loss (ICD10CM)")
        and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'))

define WeightLoss:
    if ("WeightLossCondition" is not null)
    then true
    else false

define ChewingTroubleCondition:
    First([Condition]S
        where ("ToCode"(First(S.code.coding)) = "Difficulty chewing (finding)")
        and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed')

define ChewingTrouble:
    if ("ChewingTroubleCondition" is not null)
    then true
    else false
    
define function "Normalize Onset"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	else null