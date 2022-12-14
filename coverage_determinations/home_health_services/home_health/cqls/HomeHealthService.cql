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
			and (F2FEncounter.period starts 90 days before "StartDateEpisode"
				or F2FEncounter.period starts 30 days after "StartDateEpisode")

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
		then true
		else false


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
	"Normalize Interval"("PertinentCondition".onset)

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
	where M.status.value = 'completed')

define MedicationCode:
	First(("RelevantMedication".medication as CodeableConcept).coding).code

define MedicationDescription:
	("RelevantMedication".medication as CodeableConcept).text

/*define MedicationDose:
	"RelevantMedication".dosage.dose

define MedicationRoute:
	"RelevantMedication".dosage.route.text

define MedicationFrequency:
	("RelevantMedication".dosage.rate as SimpleQuantity)*/

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
	


