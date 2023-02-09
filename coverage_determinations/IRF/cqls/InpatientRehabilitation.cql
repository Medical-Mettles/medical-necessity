library InpatientRehabilitation version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "ICD10PCS": 'http://hl7.org/fhir/sid/icd-10-pcs'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'
codesystem "Version2Tables": 'http://terminology.hl7.org/CodeSystem/v2-0203'

valueset "Assessment to Determine Rehabilitation Needs": '2.16.840.1.113883.3.7587.3.1000'
valueset "Arthritis Disorders": '2.16.840.1.113762.1.4.1222.81'
valueset "Body Height": '2.16.840.1.113883.3.3616.200.110.102.5009'
valueset "Body weight": '2.16.840.1.113762.1.4.1045.159'
valueset "Detailed Ethnicity": '2.16.840.1.114222.4.11.877'
valueset "Race Value Set": '2.16.840.1.113883.1.11.14914'
valueset "Hearing Impairment": '2.16.840.1.113762.1.4.1222.592'
valueset "Vision and Visual Acuity Assessment": '2.16.840.1.113883.3.464.1003.107.12.1038'
valueset "Inpatient Rehabilitation Codes" : '2.16.840.1.113883.3.6037.1001.23.96.31'
valueset "Expression of ideas and wants(Verbal and Non Verbal)": '2.16.840.1.113883.3.6037.1001.23.96.32'
valueset "Understanding verbal and non-verbal content": '2.16.840.1.113883.3.6037.1001.23.96.33'
valueset "Mental Status Observation": '2.16.840.1.113762.1.4.1240.1'
valueset "Urinary Incontinence": '2.16.840.1.113762.1.4.1222.718'
valueset "Bladder Dysfunction": '2.16.840.1.113762.1.4.1034.488'
valueset "Atherosclerosis and Peripheral Arterial Disease": '2.16.840.1.113762.1.4.1047.21'
valueset "Diabetes Mellitus Disorder": '2.16.840.1.113762.1.4.1219.35'
valueset "Major Surgical Procedure": '2.16.840.1.113883.3.666.5.1250'
valueset "Food and Nutrient Delivery SNOMED CT": '2.16.840.1.113762.1.4.1095.2'
valueset "Serious or Life Threatening Illness": '2.16.840.1.113883.3.464.1003.199.12.1055'
valueset "Pressure Ulcer Stage": '2.16.840.1.113883.11.20.9.35'

valueset "Antipsychotic": '2.16.840.1.113883.3.464.1003.196.12.1523'
valueset "Anticoagulant": '2.16.840.1.113883.17.4077.3.1004'
valueset "Antibiotics Oral and Injectables": '2.16.840.1.113762.1.4.1106.75'
valueset "Opioid Pain Medications": '2.16.840.1.113762.1.4.1032.34'
valueset "Antiplatelet Medications": '2.16.840.1.113762.1.4.1213.50'
valueset "Hypoglycemics": '2.16.840.1.113762.1.4.1179.3'
valueset "Chemotherapy": '2.16.840.1.113762.1.4.1047.451'
valueset "Radiation Therapy": '2.16.840.1.113762.1.4.1116.214'
valueset "Radiotherapy": '1.3.6.1.4.1.6997.4.1.2.265.15.31305.1.11.1.999.188'

valueset "Oxygen Therapy": '2.16.840.1.113762.1.4.1034.550'
valueset "Tracheostomy care": '2.16.840.1.113762.1.4.1045.77'
valueset "COVID19 SNOMED Value Set for Invasive Mechanical Ventilation": '2.16.840.1.113883.3.3616.200.110.102.6158'

valueset "IV Antimicrobial medication": '2.16.840.1.113883.3.666.5.765'
valueset "Blood Transfusion": '2.16.840.1.113883.3.1434.1000.1105'
valueset "Dialysis Services": '2.16.840.1.113883.3.464.1003.109.12.1013'
valueset "Inferior Vena Cava (IVC) Filter Placement": '2.16.840.1.113762.1.4.1147.151'

code "Airway suction technique (procedure)":'230040009' from "SNOMED-CT" display 'Airway suction technique (procedure)'
code "Non-invasive mechanical ventilation": '93.90' from "ICD-10-CM" display 'Non-invasive mechanical ventilation'

code "Difficulty hearing in noise (finding)": '277433005' from "SNOMED-CT" display 'Difficulty hearing in noise (finding)'
code "Unable to hear whisper (finding)": '306970008' from "SNOMED-CT" display 'Unable to hear whisper (finding)'
code "Hearing for conversational voice impaired (finding)": '300223008' from "SNOMED-CT" display 'Hearing for conversational voice impaired (finding)'
code "Speech hearing function (observable entity)": '128542002' from "SNOMED-CT" display 'Speech hearing function (observable entity)'
code "Difficulty understanding written information about medical condition": '95868-6' from "LOINC" display 'Difficulty understanding written information about medical condition'
code "Evaluation of speech sound production (eg, articulation, phonological process, apraxia, dysarthria); with evaluation of language comprehension and expression (eg, receptive and expressive language)": '92523' from "LOINC" display 'Evaluation of speech sound production (eg, articulation, phonological process, apraxia, dysarthria); with evaluation of language comprehension and expression (eg, receptive and expressive language)'
code "Augmentative/Alternative Communication System Assessment": 'F00ZLZZ' from "ICD10PCS" display 'Augmentative/Alternative Communication System Assessment'
code "Inattention (finding)": '22058002' from "SNOMED-CT" display 'Inattention (finding)'
code "Disorganized thinking (finding)": '736319003' from "SNOMED-CT" display 'Disorganized thinking (finding)'
code "Altered mental status (finding)": '419284004' from "SNOMED-CT" display 'Altered mental status (finding)'

code "Little interest or pleasure in doing things in last 2 weeks": '44250-9' from "LOINC" display 'Little interest or pleasure in doing things in last 2 weeks'
code "Feeling down, depressed, or hopeless in last 2 weeks": '44255-8' from "LOINC" display 'Feeling down, depressed, or hopeless in last 2 weeks'
code "Trouble falling or staying asleep, or sleeping too much in last 2 weeks": '44259-0' from "LOINC" display 'Trouble falling or staying asleep, or sleeping too much in last 2 weeks'
code "Feeling tired or having little energy in last 2 weeks": '44254-1' from "LOINC" display 'Feeling tired or having little energy in last 2 weeks'
code "Poor appetite or overeating in last 2 weeks": '44251-7' from "LOINC" display 'Poor appetite or overeating in last 2 weeks'
code "Feeling bad about yourself - or that you are a failure or have let yourself or your family down in last 2 weeks": '44258-2' from "LOINC" display 'Feeling bad about yourself - or that you are a failure or have let yourself or your family down in last 2 weeks'
code "Trouble concentrating on things, such as reading the newspaper or watching television in last 2 weeks": '44252-5' from "LOINC" display 'Trouble concentrating on things, such as reading the newspaper or watching television in last 2 weeks'
code "Moving or speaking so slowly that other people could have noticed. Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual in last 2 weeks": '44253-3' from "LOINC" display 'Moving or speaking so slowly that other people could have noticed. Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual in last 2 weeks'
code "Thoughts that you would be better off dead, or of hurting yourself in some way in last 2 weeks": '44260-8' from "LOINC"  display 'Thoughts that you would be better off dead, or of hurting yourself in some way in last 2 weeks'
code "How often do you feel isolated from others": '66867-3' from "LOINC" display 'How often do you feel isolated from others'
code "Self care [CARE]": '52545-1' from "LOINC" display 'Self care [CARE]'
code "How much difficulty do you currently have walking around one floor of your home": '67948-0' from "LOINC" display 'How much difficulty do you currently have walking around one floor of your home'
code "Are you able to walk up and down two steps [PROMIS]": '61691-2' from "LOINC" display 'Are you able to walk up and down two steps [PROMIS]'
code "Cognitive functioning [FACIT]": '71130-9' from "LOINC" display 'Cognitive functioning [FACIT]'
code "Mobility devices and aids used prior to current illness, exacerbation, or injury [CARE]" : '52550-1' from "LOINC" display 'Mobility devices and aids used prior to current illness, exacerbation, or injury [CARE]'
code "Bowel assessment observations (finding)":'281043001' from "SNOMED-CT" display 'Bowel assessment observations (finding)'
code "Does your health now limit you in doing housework or jobs around the house [PROMIS]": '89685-2' from "LOINC" display 'Does your health now limit you in doing housework or jobs around the house [PROMIS]'
code "Falls in the past year": '52552-7' from "LOINC" display 'Falls in the past year'
code "Nutrition / feeding management (regime/therapy)":'' from "SNOMED-CT" display 'Nutrition / feeding management (regime/therapy)'
code "Advance directive - request for IV fluid and support": '75790-6' from "LOINC" display 'Advance directive - request for IV fluid and support'
code "Advance directive - request for antibiotics": '75791-4' from "LOINC" display 'Advance directive - request for antibiotics'
code "Advance directive - request for tube feeding": '75788-0' from "LOINC" display 'Advance directive - request for tube feeding'

code "Cholesterol modified diet (regime/therapy)": '435671000124101' from "SNOMED-CT" display 'Cholesterol modified diet (regime/therapy)'
code "Chloride salt modified diet (regime/therapy)": '1156314000' from "SNOMED-CT" display 'Chloride salt modified diet (regime/therapy)'
code "Intravenous feeding of patient (regime/therapy)": '25156005' from "SNOMED-CT" display 'Intravenous feeding of patient (regime/therapy)'
code "Nasojejunal feeding (regime/therapy)": '310244003' from "SNOMED-CT" display 'Nasojejunal feeding (regime/therapy)'
code "Mechanically altered diet (regime/therapy)": '439111000124103' from "SNOMED-CT" display 'Mechanically altered diet (regime/therapy)'
code "Tube feeding of patient (regime/therapy)": '61420007' from "SNOMED-CT" display 'Tube feeding of patient (regime/therapy)'
code "Modified fluid diet (regime/therapy)": '762104002' from "SNOMED-CT" display 'Modified fluid diet (regime/therapy)'
code "Nasal tube feeding (regime/therapy)": '183028005' from "SNOMED-CT" display 'Nasal tube feeding (regime/therapy)'

code "Pressure injury (disorder)": '1163215007' from "SNOMED-CT" display 'Pressure injury (disorder)'
code "Pressure injury stage I (disorder)": '1163217004' from "SNOMED-CT" display 'Pressure injury stage I (disorder)'
code "Pressure injury stage II (disorder)": '1163220007' from "SNOMED-CT" display 'Pressure injury stage II (disorder)'
code "Pressure injury stage III (disorder)": '1163222004' from "SNOMED-CT" display 'Pressure injury stage III (disorder)'
code "Pressure injury stage IV (disorder)": '1163224003' from "SNOMED-CT" display 'Pressure injury stage IV (disorder)'
code "Unstageable pressure injury (disorder)": '1163226001' from "SNOMED-CT" display 'Unstageable pressure injury (disorder)'
code "Pressure injury of deep tissue (disorder)": '723071003' from "SNOMED-CT" display 'Pressure injury of deep tissue (disorder)'
code "Pressure injury caused by device (disorder)": '709076009' from "SNOMED-CT" display  'Pressure injury caused by device (disorder)'
code "Pressure injuries - unstageable due to coverage of wound bed by slough/eschar": '55089-7' from "LOINC" display 'Pressure injuries - unstageable due to coverage of wound bed by slough/eschar'

code "Oral chemotherapy (procedure)": '266719004' from "SNOMED-CT" display 'Oral chemotherapy (procedure)'
code "Intravenous chemotherapy (procedure)":'265760000' from "SNOMED-CT" display 'Intravenous chemotherapy (procedure)'

parameter "ServiceRequest" ServiceRequest

context Patient

define ImpairmentGroup:
    'Admission'

define AssessmentForRehabilitation:
    exists([Procedure]P
        where exists(P.code.coding P
                        where P in "Assessment to Determine Rehabilitation Needs")
            and start of "Normalize Interval"(P.performed) before Today()-2days)

define RehabilitationDiagnoses:
    [Condition]C
        where First(C.verificationStatus.coding).code.value = 'confirmed'
            and First(C.clinicalStatus.coding).code.value = 'active'
            and "AssessmentForRehabilitation" = true

define RehabilitationDiagnosis1:
    First("RehabilitationDiagnoses").code.text

define RehabilitationDiagnosis2:
    "RehabilitationDiagnoses"[1].code.text

define RehabilitationDiagnosis3:
    "RehabilitationDiagnoses"[2].code.text

define DateOfOnset:
    start of "Normalize Interval"(First("RehabilitationDiagnoses").onset)

define ComorbidConditions:
    First([Condition]C
        where exists(C.code.coding C 
						where C in "Serious or Life Threatening Illness")
            and First(C.verificationStatus.coding).code.value = 'confirmed')

define ArthritisCondition:
    exists([Condition]C
        where exists(C.code.coding C 
						where C in "Arthritis Disorders")
            and First(C.verificationStatus.coding).code.value = 'confirmed')   

define Height:
    First([Observation]O
        where exists(O.code.coding O
						where O in "Body Height")
        and O.status.value in {'final', 'amended', 'corrected'}).value as Quantity

define Weight:
    First([Observation]O
        where exists(O.code.coding O
						where O in "Body weight")
        and O.status.value in {'final', 'amended', 'corrected'}).value as Quantity

define Ethnicity:
  (flatten (
    Patient.extension Extension
      where Extension.url = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity'
        return Extension.extension
  )) E
    where E.url = 'ombCategory'
      or E.url = 'detailed'
    return E.value as Coding

define Race:
    (flatten (
    Patient.extension Extension
      where Extension.url = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-race'
        return Extension.extension
  )) E
    where E.url = 'ombCategory'
      or E.url = 'detailed'
    return E.value as Coding

define PreferredLanguage:
    Patient.communication.language.text

define InterpreterRequirement:
    Patient.extension Extension
      where Extension.url = 'http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired'
        return Extension.extension

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

define HearingAbility:
    if exists([Condition]C
                where "ToCode"(First(C.code.coding)) = "Difficulty hearing in noise (finding)") 
            then 'Minimal difficulty - difficulty in some environments(e.g., when person speaks softly or setting is noisy)'
    else if exists([Condition]C
                where "ToCode"(First(C.code.coding)) = "Hearing for conversational voice impaired (finding)") 
            then 'Moderate difficulty - speaker has to increase volume and speak distinctly'
    else if exists([Condition]C
                where exists(C.code.coding C
						where C in "Hearing Impairment"))
            then 'Highly impaired - absence of useful hearing'
    else 'Adequate - no difficulty in normal conversation,social interaction, listening to TV'

define VisionAssessment:
    First([Observation]O
        where exists(O.code.coding O
						where (O in "Vision and Visual Acuity Assessment"))
            and O.status.value = 'final'
            and start of "Normalize Interval"(O.effective) before Today()-2days)

define VisualAbility:
    ("VisionAssessment".value as CodeableConcept).text

define ReadingAbility:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Difficulty understanding written information about medical condition"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define AbilityToExpress:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Evaluation of speech sound production (eg, articulation, phonological process, apraxia, dysarthria); with evaluation of language comprehension and expression (eg, receptive and expressive language)"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define CommunicationAbility:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Augmentative/Alternative Communication System Assessment"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define MentalStatus:
    exists([Condition]C
        where exists(C.code.coding C 
						where (C in "Mental Status Observation"))
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed')

define MentalStatuses:
    if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Inattention (finding)"
        and O.status.value = 'final')
			then 'Inattention'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Disorganized thinking (finding)"
        and O.status.value = 'final')
			then 'Disorganized thinking'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Altered mental status (finding)"
        and O.status.value = 'final')
			then 'Altered level of consciousness'
    else ''

define MoodSymptoms:
    if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Little interest or pleasure in doing things in last 2 weeks"
        and O.status.value = 'final')
			then 'Little interest or pleasure in doing things'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Feeling down, depressed, or hopeless in last 2 weeks"
        and O.status.value = 'final')
			then 'Feeling down, depressed, or hopeless'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Trouble falling or staying asleep, or sleeping too much in last 2 weeks"
        and O.status.value = 'final')
			then 'Trouble falling or staying asleep, or sleeping too much'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Feeling tired or having little energy in last 2 weeks"
        and O.status.value = 'final')
			then 'Feeling tired or having little energy'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Poor appetite or overeating in last 2 weeks"
        and O.status.value = 'final')
			then 'Poor appetite or overeating'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Feeling bad about yourself - or that you are a failure or have let yourself or your family down in last 2 weeks"
        and O.status.value = 'final')
			then 'Feeling bad about yourself – or that you are a failure or have let yourself or your family down'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Trouble concentrating on things, such as reading the newspaper or watching television in last 2 weeks"
        and O.status.value = 'final')
			then 'Trouble concentrating on things, such as reading the newspaper or watching television'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Moving or speaking so slowly that other people could have noticed. Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual in last 2 weeks"
        and O.status.value = 'final')
			then 'Moving or speaking so slowly that other people could have noticed. Or the opposite – being so fidgety or restless that you have been moving around a lot more than usual'
    else if exists([Observation]O
        where "ToCode"(First(O.code.coding)) = "Thoughts that you would be better off dead, or of hurting yourself in some way in last 2 weeks"
        and O.status.value = 'final')
			then 'Thoughts that you would be better off dead, or of hurting yourself in some way'
    else ''

define SocialIsolation:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "How often do you feel isolated from others"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define SelfCare:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Self care [CARE]"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define IndoorMobility:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "How much difficulty do you currently have walking around one floor of your home"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define AbilityForStairs:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Are you able to walk up and down two steps [PROMIS]"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define CognitiveFunction:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Cognitive functioning [FACIT]"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define PriorDeviceUse:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Mobility devices and aids used prior to current illness, exacerbation, or injury [CARE]"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define BladderIncontinence:
    First([Observation]O
        where exists(O.code.coding O
						where O in "Urinary Incontinence")
            and O.status.value = 'final').value as Quantity

define BowelContinence:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Bowel assessment observations (finding)"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define ActiveDiagnoses:
    if exists([Condition] P
					where exists(P.code.coding P
						where P in "Atherosclerosis and Peripheral Arterial Disease"))
			then 'Peripheral Vascular Disease (PVD) or Peripheral Arterial Disease (PAD)'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Diabetes Mellitus Disorder"))
			then 'Diabetes Mellitus (DM) (e.g., diabetic retinopathy, nephropathy, and neuropathy)'
        else 'None of the above'

define LimitationToActivities:
    ((First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Does your health now limit you in doing housework or jobs around the house [PROMIS]"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value as CodeableConcept).text

define Falls:
    (First([Observation]O
        where "ToCode"(First(O.code.coding)) = "Falls in the past year"
        and O.status.value = 'final'
        and start of "Normalize Interval"(O.effective) before Today()-2days)).value

define FallsInPastYear:
    if ("Falls">=2)
        then 'Yes'
    else if ("Falls"<2)
        then 'No'
    else 'unknown'

define MajorSurgeries:
    if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Major Surgical Procedure")
                    and start of "Normalize Interval"(P.performed) before Today()-100days)
    then 'Yes'
    else 'No'

define NutritionalOrder:
    (First([NutritionOrder]N
                where N.enteralFormula.routeofAdministration in "Food and Nutrient Delivery SNOMED CT").enteralFormula.routeofAdministration)

define NutritionStatus:
    First("NutritionalOrder".coding).display

define PressureUlcer:
    exists([Condition]C
        where exists(C.code.coding C 
						where C in "Pressure Ulcer Stage")
        and First(C.verificationStatus.coding).code.value = 'confirmed')

define NoOfStageIUlcers:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) =  "Pressure injury stage I (disorder)"
        and O.status.value = 'final').value

define NoOfStageIIUlcers:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) = "Pressure injury stage II (disorder)"
        and O.status.value = 'final').value

define NoOfStageIIIUlcers:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) = "Pressure injury stage III (disorder)"
        and O.status.value = 'final').value

define NoOfStageIVUlcers:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) = "Pressure injury stage IV (disorder)"
        and O.status.value = 'final').value

define UnstageableUlcersByDevice:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) =  "Pressure injury caused by device (disorder)"
        and O.status.value = 'final').value

define UnstageableUlcersOfDeepTissue:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) = "Pressure injury of deep tissue (disorder)"
        and O.status.value = 'final').value

define UnstageableUlcersOfSlough:
    ([Observation]O
        where "ToCode"(First(O.code.coding)) =  "Pressure injuries - unstageable due to coverage of wound bed by slough/eschar"
        and O.status.value = 'final').value

define HighRiskDrugs:
    if exists([MedicationAdministration]M
	    where M.status.value = 'completed'
	         and First((M.medication as CodeableConcept).coding) in "Antipsychotic")
        then 'Antipsychotic'
    else if exists([MedicationAdministration]M
	    where M.status.value = 'completed'
	         and First((M.medication as CodeableConcept).coding) in "Anticoagulant")
        then 'Anticoagulant'
    else if exists([MedicationAdministration]M
	    where M.status.value = 'completed'
	         and First((M.medication as CodeableConcept).coding) in "Antibiotics Oral and Injectables")
        then 'Antibiotic'
    else if exists([MedicationAdministration]M
	    where M.status.value = 'completed'
	         and First((M.medication as CodeableConcept).coding) in "Opioid Pain Medications")
        then 'Opioid'
    else if exists([MedicationAdministration]M
	    where M.status.value = 'completed'
	         and First((M.medication as CodeableConcept).coding) in "Antiplatelet Medications")
        then 'Antiplatelet'
    else if exists([MedicationAdministration]M
	    where M.status.value = 'completed'
	         and First((M.medication as CodeableConcept).coding) in "Hypoglycemics")
        then 'Hypoglycemic (including insulin)'
    else 'None of the above'

define CancerTreatment:
    if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Chemotherapy"))
        then 'Chemotherapy'
    else if exists([Procedure] P
					where "ToCode"(First(P.code.coding)) = "Intravenous chemotherapy (procedure)")
        then 'IV'
    else if exists([Procedure] P
					where "ToCode"(First(P.code.coding)) = "Oral chemotherapy (procedure)")
        then 'Oral'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where (P in "Radiation Therapy"
                             or P in "Radiotherapy")))
        then 'Radiation'
    else ''

define RespirationTherapies:
    if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Oxygen Therapy"))
        then 'Oxygen Therapy'
    else if exists([Procedure] P
					where "ToCode"(First(P.code.coding)) = "Airway suction technique (procedure)")
        then 'Suctioning'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Tracheostomy care"))
        then 'Tracheostomy care'
    else if exists([Procedure] P
					where "ToCode"(First(P.code.coding)) = "Non-invasive mechanical ventilation")
        then 'Invasive Mechanical Ventilator'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where P in "COVID19 SNOMED Value Set for Invasive Mechanical Ventilation"))
        then 'Non-Invasive Mechanical Ventilator'
    else ''

define OtherTherapies:
    if exists([Procedure] P
					where exists(P.code.coding P
						where P in "IV Antimicrobial medication"))
        then 'IV Medications'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Blood Transfusion"))
        then 'Transfusions'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Dialysis Services"))
        then 'Dialysis'
    else if exists([Procedure] P
					where exists(P.code.coding P
						where P in "Inferior Vena Cava (IVC) Filter Placement"))
        then 'IV Access'
    else 'None of the above'




        


define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null