library Catheterization
using FHIR version '3.0.0'
include FHIRHelpers version '3.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "ICD-9-CM": 'http://hl7.org/fhir/sid/icd-9-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

code "Weight": '3141-9' from "LOINC" display 'Weight'
code "Height": '3137-7' from "LOINC" display 'Height'
code "BMI": '39156-5' from "LOINC" display 'BMI'

//Electrocardiogram (ECG)
code "Electrocardiogram (ECG)": '794.31' from "ICD-9-CM" display 'Electrocardiogram (ECG)'

//Chest X-ray
code "71010": '71010' from "CPT"
code "71020": '71020' from "CPT"

//echocardiogram
code "93306": '93306' from "CPT"

//76506- 76999 for Diagnostic Ultrasound Procedures 

//Patient's condition worsened (finding)
code "271299001" : '271299001' from "SNOMED-CT"
//Prolonged Services With Direct Face-to-Face Patient Contact
code "99354": '99354' from "CPT"
code "99355" : '99355' from "CPT"
code "99356" : '99356' from "CPT"
code "99357" : '99357' from "CPT"
//StressEchocardiography
code "93350" : '93350' from "CPT"
code "93351" : '93351' from "CPT"
//Medicare or comparable number 
code "45397-7" : '45397-7' from "LOINC"
//National provider ID
code "45952-9" : '45952-9' from "LOINC"
//CMS certification number
code "46456-0" : '46456-0' from "LOINC"
//Facility Address
code "65833-6" : '65833-6' from "LOINC"
//Heartrate 
code "8867-4" : '8867-4' from "LOINC"
//Respiratoryrate
code "9279-1" : '9279-1' from "LOINC"
//SystolicBloodPressure
code "8480-6" : '8480-6' from "LOINC"
//DiastolicBloodPressure
code "8462-4" : '8462-4' from "LOINC"
//BodyTemperature
code "8310-5" : '8310-5' from "LOINC"
//Coronary Artery Disease
code "I25.10" : 'I25.10' from "ICD-10-CM"
//Bilateral primary osteoarthritis of knee
code "M17.0" : 'M17.0' from "ICD-10-CM"
//Standard electrocardiogram (procedure)
code "164847006" : '164847006' from "SNOMED-CT"
//Cardiac catheterization codes
code "93452": '93452' from "HCPCS"
code "93453": '93453' from "HCPCS"
code "93454": '93454' from "HCPCS"
code "93455": '93455' from "HCPCS"
code "93456": '93456' from "HCPCS"
code "93457": '93457' from "HCPCS"
code "93458": '93458' from "HCPCS"
code "93459": '93459' from "HCPCS"
code "93460": '93460' from "HCPCS"
code "93461" : '93461' from "HCPCS"
//Pain in arm, unspecified
code "M79.603" : 'M79.603' from "ICD-10-CM"
//Jaw pain
code "R68.84" : 'R68.84' from "ICD-10-CM"
//Shortness of breath
code "R06.02" : 'R06.02' from "ICD-10-CM"
//Chest pain, unspecified
code "R07.9" : 'R07.9' from "ICD-10-CM"

parameter "Measurement Period" Interval<DateTime>

context Patient

define "F2FEncounterCodes": { '99354', '99355', '99356', '99357' }

define "StressEchocardiographyCodes": { '93350', '93351'}

define "CatheterizationCodes": { '93452', '93453', '93454', '93455', '93456', '93457', '93458', '93459', '93460', '93461'}

define "Catheterization":
	singleton from (
  		[Procedure] procedure
    		where procedure.code.coding[0].code.value in "CatheterizationCodes"
    		 )
    		
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

define BeneficiaryMedicareNumber: 
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
    		where identifier.system.value = 'http://hl7.org.fhir/sid/us-npi')).value.value

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

//define ServiceDate: "Catheterization".performed.start.value

//Diagnosis/Procedure
define "Coronary Artery Disease":
	if exists([Condition]P
		where P.code.coding[0].code.value ='I25.10')
			then 'Coronary Artery Disease'
	else ''

define "Arthritis":
	if exists([Condition]P
		where P.code.coding[0].code.value ='M17.0') 
			then 'Arthritis'
	else ''

define "Electrocardiogram":
	if exists([Procedure]P
		where P.code.coding[0].code.value ='164847006' ) then 'Electrocardiogram'
	else ''

define StressEchocardiogram: //'Stress Echocardiogram'
	if exists([Procedure]P
    		where P.code.coding[0].code.value in "StressEchocardiographyCodes")
		then 'StressEchocardiography'
	else ''
    		
define "Abnormal": 'abnormal'
//Other info
define "Chest Pain":
	if exists([Condition]P
		where P.code.coding[0].code.value ='R07.9')
			 then true
	else false
define "Arm Pain":
	if exists([Condition]P
		where P.code.coding[0].code.value ='M79.603')
			then true
	else false
define "Jaw Pain":
	if exists([Condition]P
		where P.code.coding[0].code.value = 'R68.84')
		then true
	else false
define "Shortness of Breath":
	if exists([Condition]P
		where P.code.coding[0].code.value = 'R06.02')
		then true
	else false

define "Patient waken due to pain": false

define "Pain with exertion": false

define "Pain at Rest": false


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
