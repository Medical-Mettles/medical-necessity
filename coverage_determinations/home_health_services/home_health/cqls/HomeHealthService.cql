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
valueset "Procedures Performed": '2.16.840.1.113762.1.4.1195.30'
valueset "Medication Clinical Drug": '2.16.840.1.113762.1.4.1195.62'
valueset "ACE inhibitor allergy/intolerance codes": '2.16.840.1.113762.1.4.1078.45'

parameter "ServiceRequest" ServiceRequest

context Patient

define Service:
	First("ServiceRequest".performer).reference.value

define HomeHealthCare:
	"ServiceRequest".performer P where P.type.value = 'Organization'
	
// Agency info
define Agency: 
	First([Organization]agency 
		where 'Organization/' + agency.id.value = First("ServiceRequest".performer).reference.value)
    
define AgencyName: "Agency".name.value

define AgencyNPI: 
	(First("Agency".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value
    
define AgencyPTAN:
	(First("Agency".identifier identifier
    		where First(identifier.type.coding).code.value = 'TAX')).type.text.value

define CMSCertificationNumber: 
	(First(
  		"Agency".identifier Certification
    			where First(Certification.type.coding).code.value = 'CMS certification number (CCN) Agency [OASIS]')).value.value

define AgencyAddressObject: First("Agency".address) 

define AgencyLineAddress: 
	First(First("Agency".address).line)
	
define AgencyCityAddress: 
	First("Agency".address).city.value
	
define AgencyStateAddress: 
	First("Agency".address).state.value
	
define AgencyPostalAddress: 
	First("Agency".address).postalCode.value

define AgencyAddress: 
	First(First("Agency".address).line)+ ', ' + First("Agency".address).city.value +', ' + First("Agency".address).state.value+ ', ' + First("Agency".address).postalCode.value

define SubmissionDate: 
		Today()

define Episode: 
	First([EpisodeOfCare] e 
			where e.patient.reference.value = 'Patient/'+ Patient.id.value 
				and First(First(e.type).coding).code.value = 'hacc'
				and e.managingOrganization.reference.value = 'Organization' + "Agency".id.value)

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
	/*and (F2FEncounter.period starts 90 days before "StartDateEpisode"
		or F2FEncounter.period starts 30 days after "StartDateEpisode")*/

define FToFEncounter:
	if ("FacetoFaceEncounter" is not null)
	then true
	else false


/*define FToFEncounterDate:
	ToDate(start of "Normalize Interval"("FacetoFaceEncounter".period))

define EpisodeEncounter: 
	First([Encounter]e where e.subject.reference.value = 'Patient/'+ Patient.id.value 
		and First(e.classHistory).class.code.value = 'HH' 
		and First(e.classHistory).class.system.value = 'http://terminology.hl7.org/CodeSystem/v3-ActCode'
		and e.period during "Episode".period)

define UnderCare:
	if ("EpisodeEncounter" is not null)
	then true
	else false


define StartDateEpisode: 
	ToDate(start of "Normalize Interval"("Episode".period))
	

define EndDate: 
	ToDate(start of "Normalize Interval"("Episode".period))


define state: 
	Patient.address[0].state.value


define InabilityToLeaveHome: 
	First([Condition]C
        where exists(C.code.coding C where C in "Serious or Life Threatening Illness")
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed')

define Mobility:
	First([Condition]C
        where exists(C.code.coding C where C in "Immobilization")
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed')


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
	ToDate("Normalize Interval"("PertinentCondition".onset))

//PROCEDURES

define RelevantProcedure:
	First([Procedure]P where P.status.value = 'completed'
		and exists(P.code.coding C where C in "Procedures Performed"))

define ProcedureCode:
	First("RelevantProcedure".code.coding).code

define ProcedureDescription:
	"RelevantProcedure".code.text

define DateOfProcedurePerformed:
	ToDate(start of "Normalize Interval"("RelevantProcedure".occurrence))

//MEDICATIONS:

define RelevantMedication:
  First([MedicationAdministration]M
	where M.status.value = 'completed'
	and (First(M.medication.concept.coding) in "Medication Clinical Drug"
		or First([Medication]med
							where M.medication.reference.value = 'Medication/'+med.id.value
							and (First(med.code.coding) in "Medication Clinical Drug") is not null
				) is not null
			) is not null)

define MedicationCode:
	First("RelevantMedication".medication.concept.coding).code

define MedicationDescription:
	"RelevantMedication".medication.concept.text

define MedicationDose:
	"RelevantMedication".dosage.dose

define MedicationRoute:
	"RelevantMedication".dosage.route.text

define MedicationFrequency:
	("RelevantMedication".dosage.rate as SimpleQuantity)

//ALLERGIES

define "RelevantAllergy":
	First([AllergyIntolerance]A
		where First(A.clinicalStatus.coding).code.value = 'active'
    and exists(A.code.coding x where x in "ACE inhibitor allergy/intolerance codes")) 

define "AllergyCode":
	First("RelevantAllergy".code.coding).code

define "AllergyDescription":
	"RelevantAllergy".code.text

define DeviceSpecified:
	First([Device]D
		where First(D.type.coding) in "Frailty Device"
			and D.status.value = 'active')

define DeviceUsage:
	exists([DeviceUseStatement]D
		where D.device.reference.value = 'Device' + "DeviceSpecified".id.value
		and D.status.value = 'active')

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null*/
	


