library InpatientRehabilitationDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include InpatientRehabilitation version '1.0.0' called IR

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
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient
	
define "prior-auth":
  true

define "documentation":
  false

define "dtr-clin":
  true

define Comorbities:
    IR."ComorbidConditions"

define HearingAbility:
    IR."HearingAbility"

define QT:
	"QuestionnaireResponse".item

define HearingAbilityResponse:
    ("QT".item I
		where I.linkId.value = 'HearingAbility')QR
		return First(QR.answer).value

define ComplexityInHearingAbility:
    if (Coalesce("HearingAbility", First("HearingAbilityResponse"))= 'Highly impaired - absence of useful hearing')
    then false
    else true

define VisualAbility:
    IR."VisualAbility"

define VisualAbilityResponse:
    ("QT".item I
		where I.linkId.value = 'VisualAbility')QR
		return First(QR.answer).value

define ComplexityInVisualAbility:
    if(Coalesce("VisualAbility", First("VisualAbilityResponse")) = (('Highly impaired - object identification in question, but eyes appear to follow objects'))
        or ((Coalesce("VisualAbility", First("VisualAbilityResponse"))= 'Severely impaired - no vision or sees only light, colors or shapes; eyes do not appear to follow objects')))
    then true
    else false

define ReadingAbility:
    IR."ReadingAbility"

define ReadingAbilityResponse:
    ("QT".item I
		where I.linkId.value = 'ReadingAbility')QR
		return First(QR.answer).value

define ComplexityInReadingAbility:
    if(Coalesce("ReadingAbility", First("ReadingAbilityResponse")) = (('Often'))
        or ((Coalesce("ReadingAbility", First("ReadingAbilityResponse"))= 'Always'))
        or ((Coalesce("ReadingAbility", First("ReadingAbilityResponse"))= 'Patient unable to respond')))
    then true
    else false

define AbilityToExpress:
    IR."AbilityToExpress"

define AbilityToExpressResponse:
    ("QT".item I
		where I.linkId.value = 'AbilityToExpress')QR
		return First(QR.answer).value

define ComplexityInAbilityToExpress:
    if(Coalesce("AbilityToExpress", First("AbilityToExpressResponse")) = (('Exhibits some difficulty with expressing needs and ideas (e.g., some words or finishing thoughts) or speech is not clear'))
        or ((Coalesce("AbilityToExpress", First("AbilityToExpressResponse"))= 'Frequently exhibits difficulty with expressing needs and ideas'))
        or ((Coalesce("AbilityToExpress", First("AbilityToExpressResponse"))= 'Rarely/Never expresses self or speech is very difficult to understand')))
    then true
    else false

define CommunicationAbility:
    IR."CommunicationAbility"

define CommunicationAbilityResponse:
    ("QT".item I
		where I.linkId.value = 'CommunicationAbility')QR
		return First(QR.answer).value

define ComplexityInCommunicationAbility:
    if(Coalesce("CommunicationAbility", First("CommunicationAbilityResponse")) = (('Sometimes understands: Understands only basic conversations or simple, direct phrases. Frequently requires cues to understand'))
        or ((Coalesce("CommunicationAbility", First("CommunicationAbilityResponse"))= 'Rarely/never understands')))
    then true
    else false


define HearingSpeechVisualAbilities:
    if (("ComplexityInHearingAbility") = true
        or ("ComplexityInVisualAbility")= true
        or ("ComplexityInReadingAbility") = true
        or ("ComplexityInAbilityToExpress") = true
        or ("ComplexityInCommunicationAbility") = true)
    then true
    else false

define MentalStatus:
    IR."MentalStatus"

define MentalStatusResponse:
    ("QT".item I
		where I.linkId.value = 'MentalStatus')QR
		return First(QR.answer).value

define ComplexityInMentalStatus:
    if(First("MentalStatusResponse") = true)
    then true
    else false

define RepititionResponse:
    ("QT".item I
		where I.linkId.value = 'Repetition of Words')QR
		return First(QR.answer).value

define ComplexityInRepititionResponse:
    if((First("RepititionResponse") = 'One')
        or (First("RepititionResponse") = 'None'))
    then true
    else false

define ReportYearResponse:
    ("QT".item I
		where I.linkId.value = 'Report Year')QR
		return First(QR.answer).value

define ComplexityInReportYearResponse:
    if((First("ReportYearResponse") = 'Missed by 2 - 5 years')
        or (First("ReportYearResponse") = 'Missed by > 5 years or no answer'))
    then true
    else false

define ReportMonthResponse:
    ("QT".item I
		where I.linkId.value = 'Report Month')QR
		return First(QR.answer).value

define ComplexityInReportMonthResponse:
    if((First("ReportMonthResponse") = 'Missed by 6 days to 1 month')
        or (First("ReportMonthResponse") = 'Missed by > 1 month or no answer'))
    then true
    else false

define ReportDayResponse:
    ("QT".item I
		where I.linkId.value = 'Report Day')QR
		return First(QR.answer).value

define ComplexityInReportDayResponse:
    if(First("ReportDayResponse") = 'Incorrect or no answer')   
    then true
    else false

define RecallAbility:
    ("QT".item I
		where I.linkId.value = 'RecallAbility')QR
		return First(QR.answer).value

define ComplexityInRecallAbility:
    if(First("ReportDayResponse") = 'No - could not recall')   
    then true
    else false

define MentalStatuses:
    ("QT".item I
		where I.linkId.value = 'MentalStatuses')QR
		return First(QR.answer).value

define ComplexityInMentalStatuses:
    if((First("ReportDayResponse") = 'Altered level of consciousness')
        or (First("ReportDayResponse") = 'Disorganized thinking'))   
    then true
    else false

define ComplexityInCognitiveAbility:
    if (("ComplexityInMentalStatus") = true
        or ("ComplexityInRepititionResponse")= true
        or ("ComplexityInReportYearResponse") = true
        or ("ComplexityInReportMonthResponse" = true)
        or ("ComplexityInReportDayResponse") = true
        or ("ComplexityInRecallAbility") = true
        or ("ComplexityInMentalStatuses") = true)
    then true
    else false


define PrimaryDecision:
	if(("HearingSpeechVisualAbilities" = true)
        or ("ComplexityInCognitiveAbility" = true))
    then true
    else false

define FinalDecision:
      if  (("PrimaryDecision" = true))
              then 'YES'
                else 'HUMAN REVIEW NEEDED'
	

    

