library FunctionalEndoscopicSinusSurgery
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

valueset "Intranasal Corticosteroids":'1.3.6.1.4.1.6997.4.1.2.268.15.35221.1.11.1.999.315'

//Medicare or comparable number 
code "45397-7" : '45397-7' from "LOINC"
//National provider ID
code "45952-9" : '45952-9' from "LOINC"
//CMS certification number
code "46456-0" : '46456-0' from "LOINC"
//Facility Address
code "65833-6" : '65833-6' from "LOINC"


//Chronic sinusitis, unspecified(used for Complications of sinusitis such as abscess as well)
code "J32.9" : 'J32.9' from "ICD-10-CM"

//Acute recurrent sinusitis, unspecified
code "J01.91" : 'J01.91' from "ICD-10-CM"
code "26785019": '26785019' from "SNOMED-CT"

//Mucocele of salivary gland
code "K11.6" : 'K11.6' from "ICD-10-CM"

//Unspecified disorder of nose and nasal sinuses(Concha bullosa)
code "J34.9" : 'J34.9' from "ICD-10-CM"
code "348121018": '348121018' from "SNOMED-CT"

//Malignant (primary) neoplasm, unspecified
code "C80.1" : 'C80.1' from "ICD-10-CM"
code "1208875016": '1208875016' from "SNOMED-CT"
//Nasal polyp
code "J33" : 'J33' from "ICD-10-CM"
code "87779011": '87779011' from "SNOMED-CT"

//Bacterial infection, unspecified
code "A49.9" : 'A49.9' from "ICD-10-CM"

//Antibiotic therapy (procedure)
code "281789004" : '281789004' from "SNOMED-CT"

//Lavage of nasal sinus through natural ostium (procedure)
code "72202003" : '72202003' from "SNOMED-CT"

//Other specified disorders of nose and nasal sinuses(using this for Obstruction of the ostiomeatal complex and Opacified sinus)
code "J34.89" : 'J34.89' from "ICD-10-CM"

//Disorder of bone, unspecified
code "M89.9" : 'M89.9' from "ICD-10-CM"

//Hypertrophy of bone, unspecified site
code "M89.30" : 'M89.30' from "ICD-10-CM"

//Nasal congestion
code "R09.81" : 'R09.81' from "ICD-10-CM"

//Chronic total occlusion of coronary artery
code "I25.82" : 'I25.82' from "ICD-10-CM"

parameter "Measurement Period" Interval<DateTime>

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
	([Patient]P where 'Patient/'+Patient.id.value= Last([Coverage]).subscriber.reference.value)
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


//Diagnoses/Procedures
define "Chronic Rhinosinusitis":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'J32.9'
			//and (P.onset as Period) starts during "Measurement Period" 
			//and (duration in weeks between start of (P.onset as Period) and Today() > 12)
		) then 'J32.9'
	else ''

define "Recurrent Acute Rhinosinusitis":
	if exists([Condition]P
		where (P.code.coding[0].code.value= 'J01.91' or P.code.coding[0].code.value= '26785019' )
			) then 'J01.91'
	else ''

define "Mucocele confirmed":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'K11.6') then
	Last([Condition]P
		where P.code.coding[0].code.value= 'K11.6'
			)
	else null

define "Concha bullosa confirmed":
	if exists([Condition]P
		where (P.code.coding[0].code.value= 'J34.9' or P.code.coding[0].code.value= '348121018' )) then
	Last([Condition]P
		where (P.code.coding[0].code.value= 'J34.9' or P.code.coding[0].code.value= '348121018' )
			)
	else null

define "Malignancy":
	if exists([Condition]P
		where (P.code.coding[0].code.value= 'C80.1' or P.code.coding[0].code.value= '1208875016' or P.code.coding[0].code.value= '363346000' or P.code.coding[0].code.value= '85068')) then
	Last([Condition]P
		where (P.code.coding[0].code.value= 'C80.1' or P.code.coding[0].code.value= '1208875016' or P.code.coding[0].code.value= '363346000' or P.code.coding[0].code.value= '85068')
			)
	else null

define "Polyposis":
	if exists([Condition]P
		where( P.code.coding[0].code.value= 'J33' or P.code.coding[0].code.value= '87779011' )) then
	Last([Condition]P
		where( P.code.coding[0].code.value= 'J33' or P.code.coding[0].code.value= '87779011' )
			)
	else null

define "Mucocele confirmed Scan":
	if "Mucocele confirmed" is not null then
	if exists([ImagingStudy]P
		where exists((P.reasonReference) R where R.reference.value = 'Condition/'+"Mucocele confirmed".id.value)) then 'K11.6'
	else ''
	else ''


define "Concha bullosa confirmed Scan":
	if "Concha bullosa confirmed" is not null then
	if exists([ImagingStudy]P
		where exists((P.reasonReference) R where R.reference.value = 'Condition/'+"Concha bullosa confirmed".id.value)) then 'J34.9'
	else ''
	else ''

define "Malignancy Scan":
	if "Malignancy" is not null then
	if exists([ImagingStudy]P
		where exists((P.reasonReference) R where R.reference.value = 'Condition/'+"Malignancy".id.value)) then 'C80.1'
	else ''
	else ''

define "Polyposis Scan":
	if "Polyposis" is not null then
	if exists([ImagingStudy]P
		where exists((P.reasonReference) R where R.reference.value = 'Condition/'+"Polyposis".id.value)) then 'J33'
	else ''
	else ''

define "Relevant Diagnoses":
	{"Chronic Rhinosinusitis","Recurrent Acute Rhinosinusitis","Mucocele confirmed Scan","Concha bullosa confirmed Scan","Malignancy Scan"}except{''}


define "DateOfOnset": 
	Last([Condition]).recordedDate.value

define "Antibiotic therapy":
	if ((exists([Procedure]P where P.code.coding[0].code.value= '281789004' )
			or exists([Procedure]P where P.code.coding[0].code.value= '90772' )) 
		and exists([Condition]P where P.code.coding[0].code.value= 'A49.9' 
			)) then '90772'
			
	else ''


define "Nasal lavage":
	if exists([Procedure]P
		where P.code.coding[0].code.value= '31000') 
		 then '31000'
			
	else ''

define "Intranasal corticosteroids medication":
	if exists([MedicationAdministration]P
		where FHIRHelpers.ToConcept(P.medication as CodeableConcept).codes[0] in "Intranasal Corticosteroids") 
		 then '1869710'
			
	else ''

define "Treatments performed":
	{"Antibiotic therapy","Nasal lavage","Intranasal corticosteroids medication"}except{''}


define "Mucosal thickening":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'J34.89' ) then
	Last([Condition]P
		where P.code.coding[0].code.value= 'J34.89' 
			)
	else null

define "Bony remodeling":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'M89.9' 
			) then
	Last([Condition]P
		where P.code.coding[0].code.value= 'M89.9' 
			)
	else null

define "Bony thickening":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'M89.30' 
			) then
	Last([Condition]P
		where P.code.coding[0].code.value= 'M89.30' 
			)
	else null

define "Obstruction of the ostiomeatal complex":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'J34.89' 
			) then
	Last([Condition]P
		where P.code.coding[0].code.value= 'J34.89' 
			)
	else null

define "Opacified sinus":
	if exists([Condition]P
		where P.code.coding[0].code.value= 'J34.89'
			) then
	Last([Condition]P
		where P.code.coding[0].code.value= 'J34.89' 
			)
	else null

define "Mucosal thickening Scan":
	if "Mucosal thickening" is not null then
	if exists([ImagingStudy]P
		where exists((P.reasonReference) R where R.reference.value = 'Condition/'+"Mucosal thickening".id.value)) then 'Mucosal thickening'
	else ''
	else ''

define "Bony remodeling Scan":
	if "Bony remodeling" is not null then
	if exists([ImagingStudy]P
		where exists(P.reasonReference R where R.reference.value = 'Condition/'+"Bony remodeling".id.value)) then ',Bony remodeling'
	else ''
	else ''


define "Bony thickening Scan":
	if "Bony thickening" is not null then
	if exists([ImagingStudy]P
		where exists(P.reasonReference R where R.reference.value = 'Condition/'+"Bony thickening".id.value)) then ',Bony thickening'
	else ''
	else ''

define "Obstruction of the ostiomeatal complex Scan":
	if "Obstruction of the ostiomeatal complex" is not null then
	if exists([ImagingStudy]P
		where exists(P.reasonReference R where R.reference.value = 'Condition/'+"Obstruction of the ostiomeatal complex".id.value)) then ',Obstruction of the ostiomeatal complex'
	else ''
	else ''

define "Opacified sinus Scan":
	if "Opacified sinus" is not null then
	if exists([ImagingStudy]P
		where exists(P.reasonReference R where R.reference.value = 'Condition/'+"Opacified sinus".id.value)) then ',Opacified sinus'
	else ''
	else ''

define "Findings on the CT scan":
	"Mucosal thickening Scan"+ "Bony remodeling Scan"+"Bony thickening Scan"+"Obstruction of the ostiomeatal complex Scan"+"Opacified sinus Scan"

define "Sinonasal symptoms":
	if exists(Last([Condition]P
		where P.code.coding[0].code.value= 'R09.81' 
			)) then 'Sinonasal symptoms' else ''

define "Ostial occlusion":
	Last([Condition]P
		where P.code.coding[0].code.value= 'I25.82' 
			)

define "Condition 2":
	if "Mucosal thickening" is not null and "Ostial occlusion" is not null then
	if  exists([ImagingStudy]P
		where exists(P.reasonReference R where R.reference.value = 'Condition/'+"Mucosal thickening".id.value or R.reference.value = 'Condition/'+"Ostial occlusion".id.value)) then ',CT evidence of ostial occlusion and/or mucosal thickening in the sinus to be treated'
	else ''
	else ''

define "Additional Info":
	"Sinonasal symptoms"+ "Condition 2"
	


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
