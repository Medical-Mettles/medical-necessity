library ApheresisDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include Apheresis version '1.0.0' called ApheresisCommon

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "CDCNHSN": '2.16.840.1.113883.6.277'

valueset "Apheresis (procedure)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Myasthenia gravis (disorder)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Deterioration of status (qualifier value)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113762.1.4.1181.5'
valueset "Medical procedure AND/OR service (procedure)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Medical assessment (procedure)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Medical service (procedure)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Under care of public health physician (finding)":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Seen by physician (finding)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Acute care hospital Inpatient Encounter": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.666.5.2289'
valueset "Adult Outpatient Visit": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1065'
valueset "Ambulatory/ED Visit": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1061'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireReesponse" QuestionnaireResponse

context Patient

define SR:
	First([ServiceRequest])

define ServiceEncounter:
	ApheresisCommon."ServiceEncounter"

define QualifyingEncounter:
	ApheresisCommon."QualifyingEncounter"

define Condition1:
	ApheresisCommon."Condition1"

define Condition2:
	ApheresisCommon."Condition2"

define Condition3:
	ApheresisCommon."Condition3"
	
define Condition4A:
	ApheresisCommon."Condition4A"
	
define Condition4B:
	ApheresisCommon."Condition4B"
	
define Condition4:
	ApheresisCommon."Condition4"

define Condition5:
	ApheresisCommon."Condition5"

define Condition6:
	ApheresisCommon."Condition6"
	
define Condition7:
	ApheresisCommon."Condition7"

define Condition8:
	ApheresisCommon."Condition8"

define Condition9:
	ApheresisCommon."Condition9"
	
define Condition10:
	ApheresisCommon."Condition10"

define Condition11:
	ApheresisCommon."Condition11"

define Condition12:
	ApheresisCommon."Condition12"

define Condition13:
	ApheresisCommon."Condition13"


define PrimaryDecision:
	if(("QualifyingEncounter" is not null)
		and (("Condition1" is not null)
			or ("Condition2" is not null)
			or ("Condition3" is not null)
			or ("Condition4" is not null)
			or ("Condition5" is not null)
			or ("Condition6" is not null)
			or ("Condition7" is not null)
			or ("Condition8" is not null)
			or ("Condition9" is not null)
			or ("Condition10" is not null)
			or ("Condition11" is not null)
			or ("Condition12" is not null)
			or ("Condition13" is not null)))
	then true
	else false

define "FinalDecision":
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'NO'

