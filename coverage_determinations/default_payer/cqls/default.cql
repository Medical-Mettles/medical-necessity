library DefaultQuestionnaire version '0.0.1'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "USPS": 'https://www.usps.com/'


//include otherLibrary version 'x.x' called otherLibrary
//codesystem codeSystemName : 'OID' version 'x.x'
//valueset valuesetName : 'OID' version 'x.x' codesystems{codeSystem1 , codeSystem2, etc}
//code codeName : 'OID' from codeSystemName display 'displayName'
//concept conceptName : {codeName1, codeName2, etc} display 'displayName'
//parameter parameterName (dataType or default value)
valueset "US States": 'us-core-usps-state'

parameter "ServiceRequest" ServiceRequest
parameter "Encounter" Encounter
parameter "DeviceRequest" DeviceRequest
parameter "MedicationRequest" MedicationRequest

context Patient

define BeneficiaryNameObject:
	First(Patient.name name where name.use.value='official')
	
define MiddleInitials:
  	Substring(Combine(("BeneficiaryNameObject".given given return Substring(given.value,0,1)),', '),3)

define BeneficiaryName:
	if (exists(Patient.name)) then
		PatientFirstName +' '+PatientMiddleInitial + ' '+ PatientLastName
			else PatientFirstName + ' '+ PatientLastName

define PatientLastName: 
	"BeneficiaryNameObject".family.value

define PatientMiddleInitial:
	if (Length("BeneficiaryNameObject".given)>1) then "MiddleInitials"
	else ''

define PatientFirstName: 
	First("BeneficiaryNameObject".given).value

define BeneficiaryDateOfBirth:
	Patient.birthDate.value

define DeviceCoverage:
	First([Coverage]C
		with "DeviceRequest".insurance D
		such that 'Coverage/'+ C.id.value = D.reference.value)

define ServiceCoverage:
	First([Coverage]C
	with "ServiceRequest".insurance S
	such that 'Coverage/'+ C.id.value = S.reference.value)

define MedicationCoverage:
    First([Coverage]C
	with "MedicationRequest".insurance S
	such that 'Coverage/'+ C.id.value = S.reference.value)

//define PayerReference:
//	[Organization]Org where 'Organization/'+ Org.id.value = Coalesce(First("DeviceCoverage".payor).reference.value,First("ServiceCoverage".payor).reference.value )

define Payer:
	First([Organization]O where 'Organization/'+ O.id.value = Coalesce(First("DeviceCoverage".payor).reference.value,First("ServiceCoverage".payor).reference.value,First("MedicationCoverage".payor).reference.value ))

define InsurerName:
	Payer.name.value

define InsurerNPI:
	(First (Payer.identifier)).value.value

define CoverageSubscriber:
	First([Patient]P where 'Patient/' + P.id.value = Coalesce("DeviceCoverage".subscriber.reference.value,"ServiceCoverage".subscriber.reference.value,"MedicationCoverage".subscriber.reference.value ))

define BeneficiaryIdentificationNumber:
	Coalesce("DeviceCoverage".subscriberId.value,"ServiceCoverage".subscriberId.value,"MedicationCoverage".subscriberId.value )

// Practitioner Details

define Practitioner:
	First ([Practitioner] practitioner
    		where ('Practitioner/' + practitioner.id) = First("Encounter".participant).individual.reference.value )

define PractitionerName:
First(
  	"Practitioner".name)

define PractitionerLastName:
	"PractitionerName".family.value

define PractitionerMiddleInitial:
  	Substring(Combine(("PractitionerName".given given return Substring(given.value,0,1)),', '),3)

define "PractitionerFirstName":
	First("PractitionerName".given).value

define "PractitionerFullName":
  	Coalesce("PractitionerFirstName" + ' ' + "PractitionerMiddleInitial" + ' ' + "PractitionerLastName", "PractitionerFirstName" + ' ' + "PractitionerLastName")

define "PractitionerNPI": (First (
  	"Practitioner".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value

define  "PractitionerRoleCode":
    	First("EncounterResource".participant).type.coding

define "PractitionerRoleFromServiceRequest":
		First("ServiceRequest".performerType.coding)

define "PractitionerRole":
	Coalesce((First (
	 "PractitionerRoleCode" T
		where T.system.value = 'http://terminology.hl7.org/CodeSystem/v3-ParticipationType')),"PractitionerRoleFromServiceRequest")

define "PractitionerAddressLine":
	First(First("Practitioner".address).line).value

define "PractitionerAddressCity":
	First("Practitioner".address).city.value

define "PractitionerAddressState":
	First("Practitioner".address).state.value

define "PractitionerAddressPostalCode":
	First("Practitioner".address).postalCode.value

//**********OPERATING PHYSICIAN/PRACTITIONER****************/

define OperatingPracFirstName:
	First("PractitionerName".given).value

define OperatingPracLastName:
	"PractitionerName".family.value

define OperatingPracNPI:
	(First (
  	"Practitioner".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value

define OperatingPracRole:
	Coalesce((First (
	 "PractitionerRoleCode" T
		where T.system.value = 'http://terminology.hl7.org/CodeSystem/v3-ParticipationType')),"PractitionerRoleFromServiceRequest")

define OperatingPracAddressLine:
	First(First("Practitioner".address).line).value

define OperatingPracCity:
	First("Practitioner".address).city.value

define OperatingPracState:
	First("Practitioner".address).state.value

define OperatingPracPostalCode:
	First("Practitioner".address).postalCode.value


//************REQUESTER******* */

define EncounterResource:
	First([Encounter]E where 'Encounter/' + E.id.value = Coalesce("DeviceRequest".encounter, "ServiceRequest".encounter, "MedicationRequest".encounter).reference.value )

define RequestCondition:
    	First([Condition]C where 'Condition/' + C.id.value = Coalesce(First("DeviceRequest".reasonReference), First("ServiceRequest".reasonReference),First("MedicationRequest".reasonReference)).reference.value )

define Requester:
	First([Organization] O where 'Organization/' + O.id.value = Coalesce("Encounter".serviceProvider.reference.value, Patient.managingOrganization.reference.value))

define RequesterName:
	"Requester".name.value

define "FromRequesterNPI":
		(First(
  	"Requester".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value

define "RequesterNPI":
	Coalesce("FromRequesterNPI","PractitionerNPI")

define "RequesterAddress":
	 "Requester".address

define "RequesterLine":
	First("RequesterAddress").line

define "RequesterAddressLine":
	First("RequesterLine").value

define "RequesterAddressCity":
	First("Requester".address).city.value

define "RequesterAddressState":
	First("Requester".address).state.value

// define "RequesterAddressStateDataCase"
// 	Combine(Upper(SubString("RequesterAddressStateData",0,1)), Lower(SubString("RequesterAddressStateData", 1)))

// define "StateCode":
// 	"US States".code
// 	where display = "RequesterAddressStateData"
		
// define function ToCode(value String, codeSystem String):
//     Code { code: value, system: codeSystem }

// define function ToDisplay(value String, codeSystem String, key String):
// 	Code { display: value, system: codeSystem, code :key }

// define "RequesterAddressState":
// 	if "ToCode"("RequesterAddressStateData", 'https://www.usps.com/') in "US States"
// 	then "RequesterAddressStateData"
// 	else if "ToDisplay"("RequesterAddressStateData", 'https://www.usps.com/', 'CA') in "US States"
// 	then "RequesterAddressStateData"
// 	else ''

define "RequesterAddressPostalCode":
	First("Requester".address).postalCode.value

define RequesterTelecom:
	(First (
  	"Requester".telecom telecom
    		where telecom.system.value = 'phone')).value.value

define RequesterContact:
	First("Requester".contact)

define RequesterContactName:
	"RequesterContact".name

define RequesterContactLastName:
	Coalesce("RequesterContactName".family.value, "PractitionerLastName")

define RequesterContactMiddleInitial:
  	Substring(Combine(("RequesterContactName".given given return Substring(given.value,0,1)),', '),3)

define "RequesterContactFirstName":
	Coalesce(First("RequesterContactName".given).value, "PractitionerFirstName")

define "EncounterParticipant":
	"EncounterResource"

define EncounterCondition:
		if First("EncounterResource".diagnosis) is not null
    then "EncounterDiagnosis"("EncounterResource")
		else (if (First([Condition]C where C.encounter is not null) is not null)
					then ([Condition] C where C.encounter.reference.value = 'Encounter/'+"EncounterResource".id.value)
					else (if First("EncounterResource".reasonReference) is not null
								then "EncounterReason"("EncounterResource")
								else null
								)
					)
define ConditionWithEncounter:
	First([Condition] C where  C.encounter.reference.value = 'Encounter/' + "EncounterResource".id.value)

define ConditionCategory:
	First([Condition]C
				where exists(C.category.coding E where E.code.value = 'encounter-diagnosis'))

define EncounterDiagnosisCode:
	if exists("EncounterCondition" E
				where exists(E.code.coding C where C.system.value = 'http://hl7.org/fhir/sid/icd-10-cm'))
		then First("EncounterCondition".code.coding E
				where E.system.value = 'http://hl7.org/fhir/sid/icd-10-cm').code.value
	else if ("ConditionWithEncounter" is not null)
		then First("ConditionWithEncounter".code.coding C
					where C.system.value = 'http://hl7.org/fhir/sid/icd-10-cm').code.value
	else if ("ConditionCategory" is not null)
			then First("ConditionCategory".code.coding C
					where C.system.value = 'http://hl7.org/fhir/sid/icd-10-cm').code.value
	else ''

define EncounterDiagnosisSystem:
	if exists("EncounterCondition")
	then First("EncounterCondition".code.coding).system.value
	else ''

define function "GetId"(uri String):
	Last(Split(uri, '/'))

define function "EncounterDiagnosis"(Encounter Encounter):
  	Encounter.diagnosis D
  	return First ([Condition] C where C.id.value = "GetId"(D.condition.reference.value))

define function "EncounterReason"(Encounter Encounter):
  	Encounter.reasonReference D
  	return First ([Condition] C where 'Condition/'+C.id.value = D.reference.value)
