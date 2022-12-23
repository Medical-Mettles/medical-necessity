library HomeHealthService version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'
codesystem "Version2Tables": 'http://terminology.hl7.org/CodeSystem/v2-0203'

valueset "Immobilization": '2.16.840.1.113883.17.4077.2.2006'
valueset "Serious or Life Threatening Illness": '2.16.840.1.113883.3.464.1003.199.12.1055'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'
valueset "Frailty Device": '2.16.840.1.113883.3.464.1003.118.11.1114'
valueset "Rehabilitation Services": '2.16.840.1.113883.3.117.1.7.1.221'
valueset "Home Health Procedure": '2.16.840.1.113762.1.4.1219.104'
valueset "Functional and Mobility Impairment SCT": '2.16.840.1.113762.1.4.1222.1401'
valueset "Cognitive Impairment": '2.16.840.1.113883.3.464.1003.1186'
valueset "Amputation Disorder ICD10CM": '2.16.840.1.113762.1.4.1219.162'
valueset "Bladder Dysfunction": '2.16.840.1.113762.1.4.1034.488'
valueset "Bowel Elimination Pattern": '2.16.840.1.113883.3.7643.3.1038'
valueset "Muscle, Tendon or Joint Contracture Disorder": '2.16.840.1.113762.1.4.1219.154'
valueset "Hearing Impairment": '2.16.840.1.113762.1.4.1222.592'
valueset "Limb Paralysis [Monoplegia and Diplegia] [Unspecified Cause] (Disorders) (ICD10CM)": '2.16.840.1.113762.1.4.1146.1328'
valueset "Walking or ambulation/locomotion (ADL/IADL)": '2.16.840.1.113762.1.4.1222.958'
valueset "Language and Speech Problems": '2.16.840.1.113762.1.4.1222.1485'
valueset "Blindness": '2.16.840.1.113883.3.464.1003.115.12.1089'
valueset "Dyspnea": '2.16.840.1.113762.1.4.1182.47'
valueset "Stable and Unstable Angina": '2.16.840.1.113762.1.4.1047.47'
valueset "Cerebrovascular Disease Diagnosis":'2.16.840.1.113762.1.4.1222.1549'
valueset "Physical Disability": '2.16.840.1.113762.1.4.1047.615'
valueset "Fall Risk": '2.16.840.1.113762.1.4.1222.712'
valueset "Severity": '2.16.840.1.113883.3.88.12.3221.6.8'


valueset "Physical Therapy Procedure": '2.16.840.1.113762.1.4.1219.99'
valueset "Occupational Therapy Procedure": '2.16.840.1.113762.1.4.1219.101'
valueset "Speech Language Therapy Procedure": '2.16.840.1.113762.1.4.1219.103'
valueset "Intermittent Skilled Nursing Home Health Procedure": '2.16.840.1.113762.1.4.1219.105'
valueset "Registered Nurse": '2.16.840.1.113762.1.4.1182.370'


parameter "ServiceRequest" ServiceRequest

context Patient

define SubmissionDate: 
		Today()

define EncounterResource:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value )

define EncPractitioner:
    First([Practitioner]P
        where 'Practitioner/' + P.id.value = "ServiceRequest".requester.reference.value)

define function "EncounterPractitioner"(Encounter Encounter):
	Encounter.participant PR
	return First([Practitioner]P where 'Practitioner/' + P.id.value = PR.individual.reference.value)

define FacetoFaceEncounter:
	"EncounterResource" F2FEncounter
	where First(First(F2FEncounter.type).coding) in "Face to Face Encounter"
	and First(F2FEncounter.participant).individual.reference.value = 'Practitioner/' + "EncPractitioner".id.value
	and (First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code.value = 'MD'
		or First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code.value = 'NP'
		or First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code.value = 'CNS'
		or First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code.value = 'PA')
			and (F2FEncounter.period starts after  "StartDateEpisode" - 90 days
				or F2FEncounter.period starts before "StartDateEpisode" - 30 days)

define FToFEncounter:
	if ("FacetoFaceEncounter" is not null)
	then true
	else false                                                                              

define QualifiedCarePlan:
	First([CarePlan] P
			where exists(P.category.coding C where C in "Home Health Procedure")
			and P.status.value = 'active'
			and P.intent.value = 'order')

define StartDateEpisode: 
	ToDate(start of "Normalize Interval"("QualifiedCarePlan".period))

define FToFEncounterDate:
	ToDate(start of "Normalize Interval"("FacetoFaceEncounter".period))

define EndDate: 
	ToDate(start of "Normalize Interval"("QualifiedCarePlan".period))

define TypeOfBenefitPeriod:
	First([CarePlan] P
			where exists(P.category.coding C where C in "Home Health Procedure")
			and (P.intent.value = 'on-hold'
				or P.intent.value ='revoked'
				or P.intent.value ='completed'))

define BenefitPeriodType:
	if("TypeOfBenefitPeriod" is not null)
		then 'Subsequent'
		else 'Initial'


//PERTINENT CONDITIONS

define PertinentCondition:
	First([Condition]C
        where exists(C.code.coding C 
						where (C in "Serious or Life Threatening Illness"
							  or C in "Immobilization"))
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed')

define PertinentConditionCode:
	First("PertinentCondition".code.coding).code

define PertinentConditionDescription:
	"PertinentCondition".code.text

define DateOfDiagnosis:
	start of "Normalize Interval"("PertinentCondition".onset)

define PertinentConditions:
	[Condition]C
        where exists(C.code.coding C 
						where (C in "Serious or Life Threatening Illness"
							  or C in "Immobilization"))
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed'

define NoOfConditions:
	Length("PertinentConditions")

define ConditionCodes:
	{First(First("PertinentConditions").code.coding).code , First("PertinentConditions"["NoOfConditions" -1].code.coding).code, First("PertinentConditions"["NoOfConditions" -2].code.coding).code}

define FunctionalLimitation:
		if exists([Condition] P
					where exists(P.code.coding P
						where P in "Amputation Disorder ICD10CM"))
			then 'Amputation'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Bladder Dysfunction"
							or P in "Bowel Elimination Pattern"))
			then 'Bowel/bladder (Incontinence)'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Muscle, Tendon or Joint Contracture Disorder"))
			then 'Contracture'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Hearing Impairment"))
			then 'Hearing'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Limb Paralysis [Monoplegia and Diplegia] [Unspecified Cause] (Disorders) (ICD10CM)"))
			then 'Paralysis'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Walking or ambulation/locomotion (ADL/IADL)"))
			then 'Endurance'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Language and Speech Problems"))
			then 'Speech'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Blindness"))
			then 'Legally blind'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Dyspnea"))
			then 'Dyspnea with minimal exertion'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Stable and Unstable Angina"))
			then 'Angina with minimal exertion or at rest'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Cerebrovascular Disease Diagnosis"))
			then 'CVA/hemiparalysis/paralysis/dysphonia'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Physical Disability"))
			then 'Confined to wheelchair'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Fall Risk"))
			then 'Fall risk'
		else ''


define SkilledService:
	if exists (([ServiceRequest] S
		where exists(S.code.coding S
		 				where S in "Intermittent Skilled Nursing Home Health Procedure"
								or S in "Registered Nurse"))
		union
			([Procedure]P
				where exists(P.code.coding P
		 				where P in "Intermittent Skilled Nursing Home Health Procedure"
								or P in "Registered Nurse")))
		then 'Nursing Services'
	else if exists (([ServiceRequest] S
		where exists(S.code.coding S
		 				where S in "Physical Therapy Procedure"))
		union
			([Procedure]P
				where exists(P.code.coding P
		 				where P in "Physical Therapy Procedure")))
		then 'Physical Therapy'
	else if exists (([ServiceRequest] S
		where exists(S.code.coding S
		 				where S in  "Occupational Therapy Procedure"))
		union
			([Procedure]P
				where exists(P.code.coding P
		 				where P in "Occupational Therapy Procedure")))
		then 'Occupational Therapy'
	else if exists (([ServiceRequest] S
		where exists(S.code.coding S
		 				where S in "Speech Language Therapy Procedure"))
		union
			([Procedure]P
				where exists(P.code.coding P
		 				where P in "Occupational Therapy Procedure")))
		then 'Speech Therapy'
	else ''


//PROCEDURES

define RelevantProcedure:
	Last([Procedure]P where P.status.value = 'completed')

define ProcedureCode:
	First("RelevantProcedure".code.coding).code

define ProcedureDescription:
	"RelevantProcedure".code.text

define DateOfProcedurePerformed:
	start of "Normalize Interval"("RelevantProcedure".performed)

//MEDICATIONS:

define RelevantMedication:
  Last([MedicationAdministration]M
	where M.status.value = 'in-progress')

define MedicationCode:
	First(("RelevantMedication".medication as CodeableConcept).coding).code

define MedicationDescription:
	("RelevantMedication".medication as CodeableConcept).text

define MedicationDose:
	"RelevantMedication".dosage.dose.value

define MedicationRoute:
	"RelevantMedication".dosage.route.text

/*define MedicationFrequency:
	("RelevantMedication".dosage.rate as Quantity)*/

define MedicationStatus:
	"RelevantMedication".status.value

//ALLERGIES

define "RelevantAllergy":
	First([AllergyIntolerance]A
		where First(A.clinicalStatus.coding).code.value = 'active') 

define "AllergyCode":
	First("RelevantAllergy".code.coding).code

define "AllergyDescription":
	"RelevantAllergy".code.text

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null
	


