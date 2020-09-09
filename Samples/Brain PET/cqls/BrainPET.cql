library BrainPET
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

//"valueSetString":"F03.90,G30.9,G31.09,G40.919,C80.1,G40"
//Medicare or comparable number 
code "45397-7" : '45397-7' from "LOINC"
//National provider ID
code "45952-9" : '45952-9' from "LOINC"
//CMS certification number
code "46456-0" : '46456-0' from "LOINC"
//Facility Address
code "65833-6" : '65833-6' from "LOINC"

//Dementia
code "F03.90" : 'F03.90' from "ICD-10-CM"

//Alzheimer's Disease
code "G30.9" : 'G30.9' from "ICD-10-CM"

//Frontotemporal Dementia
code "G31.09" : 'G31.09' from "ICD-10-CM"
code "345088011" : '345088011' from "SNOMED-CT"

//Epilepsy, unspecified
code "G40.919" : 'G40.919' from "ICD-10-CM"

//Malignant(Primary) Neoplasm
code "C80.1" : 'C80.1' from "ICD-10-CM"
code "1208875016" : '1208875016' from "SNOMED-CT"

parameter "Measurement Period" Interval<DateTime>
//parameter coverage Coverage
//parameter encounter Encounter

context Patient
	
define Today: Today()

// Beneficiary info
define BeneficiaryNameObject: 
	singleton from (Patient.name name where name.use.value='official')

define BeneficiaryName: 
	if (PatientFirstName is not null and PatientMiddleInitial is not null and PatientLastName is not null) then
	PatientFirstName +' '+PatientMiddleInitial + ' '+ PatientLastName
	else PatientFirstName + ' '+ PatientLastName

define PatientLastName: "BeneficiaryNameObject".family.value

define PatientMiddleInitial: 
	if (Length("BeneficiaryNameObject".given)>1) then GetMiddleInitials("BeneficiaryNameObject")
	else ''
	
define PatientFirstName: "BeneficiaryNameObject".given[0].value

define BeneficiaryGender: Patient.gender.value

define BeneficiaryDateOfBirth: Patient.birthDate.value

define "Coverage Subscriber":
	if exists([Coverage]) then
	([Patient]P where 'Patient/'+Patient.id.value= singleton from([Coverage]).subscriber.reference.value)
	else null

define BeneficiaryIdentificationNumber: 
	if exists("Coverage Subscriber") then
	(Last(
  	"Coverage Subscriber".identifier identifier
   	where identifier.system.value ='urn:oid:1.1.1.1.1.1' or identifier.system.value ='urn:oid:2.16.840.1.113883.3.787.0.0' or identifier.system.value ='http://hl7.org/fhir/sid/us-medicare' or identifier.system.value ='urn:oid:2.2.2.2.2.2')).value.value
	else ''


// Practitioner info

//define "Encounter resource": 
//	(singleton from([Encounter]E where (Last(E.participant p where p.individual is not null) is not null)))enc
//	return enc.participant

//define "Encounter participant":
//	Last(("Encounter resource" p where p.type is not null)P
//		sort by start of period)

define "Encounter resource": 
	(Last([Encounter]E sort by start of period)).participant

define "Encounter participant":
	"Encounter resource"

define Practitioner: //Last([Practitioner])
	if "Encounter participant" is not null then
	Last(
  		[Practitioner]practitioner 
			with "Encounter participant" E
    		such that ('Practitioner/' + practitioner.id.value) = E.individual.reference.value)
	else Last([Practitioner])
    
define PractitionerNameObject: 
	if "Practitioner" is not null then
	singleton from ("Practitioner".name[0]) else null
	
define PractitionerName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	PractitionerFirstName + ' '+ PractitionerLastName

define PractitionerLastName: "PractitionerNameObject".family.value

define PractitionerMiddleInitial: GetMiddleInitials("PractitionerNameObject")

define PractitionerFirstName: "PractitionerNameObject".given[0].value

define PractitionerNPI:  //'1986352488'
	(singleton from (
  		"Practitioner".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value

define PractitionerPTAN:
	(singleton from (
  		"Practitioner".identifier identifier
    		where identifier.type.coding[0].system.value = 'http://terminology.hl7.org/CodeSystem/v2-0203' and identifier.type.coding[0].code.value = 'TAX')).value.value

define PractitionerAddressObject: 
	if exists("Practitioner".address) then
	singleton from ("Practitioner".address[0]) else null  

define PractitionerAddress: 
	if exists("PractitionerAddressObject") then
	"PractitionerAddressObject".line[0].value +', ' +"PractitionerAddressObject".city.value +', ' +"PractitionerAddressObject".state.value+', ' +"PractitionerAddressObject".postalCode.value
	else ''


//Facility info
define Facility: 
	if exists([Organization]) and Last([Encounter]) is not null then
	 singleton from (
  		[Organization]org
    		where ('Organization/' + org.id.value) = Last([Encounter]).serviceProvider.reference.value)
	else null

define FacilityName: 
	if exists("Facility") then "Facility".name.value else ''

define FacilityNPI: 
	if exists("Facility") then (singleton from (
  		"Facility".identifier identifier
    		where identifier.system.value = 'http://hl7.org/fhir/sid/us-npi')).value.value
	else ''

define FacilityTaxID:
	if exists("Facility") then	
	(singleton from (
  		"Facility".identifier identifier
    		where identifier.type.coding[0].system.value = 'http://terminology.hl7.org/CodeSystem/v2-0203' and identifier.type.coding[0].code.value = 'TAX' or identifier.type.coding[0].code.value = 'TAXID')).value.value
	else ''

define FacilityAddressObject: 
	if exists("Facility") then	
	singleton from ("Facility".address[0])  
	else null

define FacilityAddress: 
	if exists("Facility") and exists("FacilityAddressObject") then
	"FacilityAddressObject".line[0].value +', ' +"FacilityAddressObject".city.value +', ' +"FacilityAddressObject".state.value+', ' +"FacilityAddressObject".postalCode.value
	else ''

define FacilityPhone:
	(singleton from (
  		"Facility".telecom[0])).value.value

//Diagnoses/Procedures
define "Dementia Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'F03.90' 
			) then 'F03.90'
	else ''

define "Alzheimers Disease":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'G30.9'
			) then 'G30.9'
	else ''

define "Frontotemporal Dementia":
	if exists([Condition]P
		where (P.code.coding[0].code.value= 'G31.09' or P.code.coding[0].code.value= '345088011') 
			) then 'G31.09'
	else ''

define "Epilepsy Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'G40.919'
			) then 'G40.919'
	else ''

define "Dementia or AD":
	{"Dementia Code","Alzheimers Disease","Frontotemporal Dementia","Epilepsy Code"}


define "Mild Cognitive Impairment Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'G31'
			) then 'G31'
	else ''

define "Severe Dementia with Behavioral Disturbance Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'F03.90'
			) then 'F03.90'
	else ''

define "Severe Dementia without Behavioral Disturbance Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'F03.91'
			) then 'F03.91'
	else ''

define "Normal Aging Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'R41.81'
			) then 'R41.81'
	else ''


define "RelevantDiagnosis":
	{"Mild Cognitive Impairment Code","Severe Dementia with Behavioral Disturbance Code","Severe Dementia without Behavioral Disturbance Code","Normal Aging Code"}except{''}

define "DateOfOnset": 
	Last([Condition]).recordedDate.value
	
define "Date of Service": 
	//if exists([Encounter]) then
	Last([Encounter]).period.start.value

define "Malignant Primary Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'C80.1'
			) then 'C80.1'
	else ''

define "Malignant Secondary Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'C79.9'
			) then 'C79.9'
	else ''

define "Ca in situ Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'D09.9'
			) then 'D09.9'
	else ''

define "Benign Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'D36.9'
			) then 'D36.9'
	else ''

define "Uncertain Behavior Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'D48.9'
			) then 'D48.9'
	else ''

define "Unspecified Behavior Code":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'D49.9'
			) then 'D49.9'
	else ''


define "Malignant Neoplasm":
	{"Malignant Primary Code","Malignant Secondary Code","Ca in situ Code","Benign Code","Uncertain Behavior Code","Unspecified Behavior Code"}


//Requestor info
define Requestor: 
	Practitioner	 
	
define RequestorNameObject: 
	singleton from ("Requestor".name[0])
	
define SubmitterName: 
	//PractitionerFirstName + ' '+ PractitionerMiddleInitial + ' '+ PractitionerLastName
	RequestorFirstName + ' '+ RequestorLastName

define RequestorLastName: "RequestorNameObject".family.value

define RequestorMiddleInitial: GetMiddleInitials("RequestorNameObject")

define RequestorFirstName: "RequestorNameObject".given[0].value

define SubmitterTelephone: 
	if "Requestor".telecom[0] is not null then
	(singleton from (
  		"Requestor".telecom[0])).value.value
	else ''

define function GetMiddleInitials(name FHIR.HumanName):
  Substring(Combine((name.given given return Substring(given.value,0,1)),', '),3)

define function GetProcedure(ProcedureList List<Procedure>, ProcedureCode String):
  ProcedureList P where P.code.coding[0].code.value= ProcedureCode
