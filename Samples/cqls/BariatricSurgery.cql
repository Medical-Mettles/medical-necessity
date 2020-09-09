library BariatricSurgery version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "NUCCPT":'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'

valueset "Body mass index [BMI]":'2.16.840.1.113883.6.103'
valueset "Co-morbid conditions (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Body mass index 30+ - obesity (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Obesity (disorder)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Absence of therapeutic response (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Laparoscopic adjustable gastric banding (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Laparoscopic sleeve gastrectomy (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Gastric stapling for obesity (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Stapling of stomach (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Intestinal bypass for morbid obesity (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Insertion of gastric balloon (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Bariatric operative procedure (procedure)":'2.16.840.1.113883.3.88.12.80.28'

code "Weight": '3141-9' from "LOINC" display 'Weight'
code "Height": '3137-7' from "LOINC" display 'Height'
code "BMI": '39156-5' from "LOINC" display 'BMI'
code "E66.01" : 'E66.01' from "ICD-10-CM"
code "E66.2" : 'E66.2' from "ICD-10-CM"
code "E11.9" : 'E11.9' from "ICD-10-CM"
code "I51.9" : 'I51.9' from "ICD-10-CM"
code "I25.10" : 'I25.10' from "ICD-10-CM"
code "G47.33": 'G47.33' from "ICD-10-CM"
code "Social, psychological and behavioral observations": '80216-5' from "LOINC" display 'Social, psychological and behavioral observations'
code "Surgery Preoperative evaluation": '34876-3' from "LOINC" display 'Surgery Preoperative evaluation'

parameter "ServiceRequest" ServiceRequest

context Patient

define "F2FEncounterCodes": { '99354', '99355', '99356', '99357' }

define "BariatricSurgeryCodes": { '0312T', '0313T', '0314T', '0315T', '0316T', '0317T', '43644', '43645', '43647', '43648', '43659', '43770', '43771', '43772', '43773', '43774', '43775', '43842','43843', '43845', '43846', '43847', '43848', '43881', '43882', '43886', '43887', '43888,', '64590', '64595', '43860', '43865'}
   
//define PerformedType: {'Initial'}
define Resource:
	"ServiceRequest".encounter.reference.value

define function "GetId"(uri String):
	Last(Split(uri, '/'))
		
define ServiceEncounter:
	singleton from ([Encounter]Encounter
		where 'Encounter/' + Encounter.id.value = ("ServiceRequest".encounter.reference.value))

define function "EncounterDiagnosis"(Encounter Encounter):
	Encounter.diagnosis D
	return singleton from ([Condition]C where C.id.value = "GetId"(D.condition.reference.value))
	
define ServiceCondition:
	"EncounterDiagnosis"("ServiceEncounter")
	
define "SecondaryDiagnosis":
	if exists("ServiceCondition"P where P.code.coding[1].code.value ='E11.9' ) then 'Type 2 Diabetes' 
	else if exists("ServiceCondition"P where P.code.coding[1].code.value = 'I51.9') then 'Cardiovascular Disease' 
	else if exists("ServiceCondition"P where P.code.coding[1].code.value ='I25.10' ) then 'Coronary Artery Disease' 
	else if exists("ServiceCondition"P where P.code.coding[1].code.value ='G47.33' ) then 'Obstructive Sleep Apnea' 
	else ''
	

define "ServiceObservation":
	singleton from ([Observation]O  where'Observation/' + O.id.value = "ServiceRequest".reasonReference[0].reference.value)
	
define "BMIRatio":
	"ServiceObservation".value.value.value
	
define "ServiceInfo":
	singleton from([DocumentReference]D where 'DocumentReference/' + D.id.value = "ServiceRequest".supportingInfo[0].reference.value)
		
define "ReferenceNote":
	"ServiceInfo"S where (S.category[0].coding[0] =  "Social, psychological and behavioral observations" and S.category[0].coding[1] =  "Surgery Preoperative evaluation")
				or (S.category[0].coding[1] =  "Social, psychological and behavioral observations" and S.category[0].coding[0] =  "Surgery Preoperative evaluation")

define "PreOperativeNote":
	"ServiceRequest".supportingInfo[0].reference.value			
	
//define "Co-morbidities": {'Cardiac disease'}



