library SacralNerveDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include SacralNerve version '1.0.0' called SacralNerve

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Urinary Incontinence Diagnoses": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.62'
valueset "Excluded Diagnoses for Sacral Nerve Stimulation": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.63'
valueset "Test Stimulation": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.64'
valueset "Voiding Diaries": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.65'
valueset "Behavioral Therapy": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.66'
valueset "Pharmacological Therapy": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.67'
valueset "Other Surgeries": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.68'
valueset "Procedure Successful": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.69'
valueset "Procedure Partially Successful": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.70'
valueset "Procedure for Medication Administration": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "Procedure Unsuccessful": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define QA14:
	("QT".item I
		where I.linkId.value = '1.4')QR
		return First(QR.answer).value

define QA21:
	("QT".item I
		where I.linkId.value = '2.1')QR
		return First(QR.answer).value

define "TestStimulationProcedure":
  Last(SacralNerve."TestStimulationProcedure")

define "BehavioralTherapyProcedure":
  SacralNerve."BehavioralTherapyProcedure" B where exists(B.outcome.coding C where C in "Procedure Unsuccessful")

define "PharmacologicalProcedure":
  SacralNerve."PharmacologicalProcedure" B where exists(B.outcome.coding C where C in "Procedure Unsuccessful")

define "OtherSurgeryResources":
  SacralNerve."OtherSurgeryResources" B where exists(B.outcome.coding C where C in "Procedure Unsuccessful")

define "DiagnosesAssessment":
  if (First(SacralNerve."IncontinenceConditions") is not null
      and First(SacralNerve."ExcludedConditions") is null)
  then true
  else false

define "TestStimulationAssessment":
  if exists("TestStimulationProcedure".outcome.coding C where C in "Procedure Successful")
  then true
  else (if (exists("TestStimulationProcedure".outcome.coding C where C in "Procedure Partially Successful")
          and First("QA14")>=50)
        then true
        else false
      )

define "OtherSurgeriesAssessment":
  if (Count(SacralNerve."BehavioralTherapyProcedure")= Count("BehavioralTherapyProcedure")
    and Count(SacralNerve."PharmacologicalProcedure")= Count("PharmacologicalProcedure")
    and Count(SacralNerve."OtherSurgeryResources")= Count("OtherSurgeryResources"))
  then true
  else false

define "FinalDecision":
	if ("DiagnosesAssessment"=true
      and "TestStimulationAssessment"=true
      and "OtherSurgeriesAssessment"=true
      and First("QA21")=true)
	then 'YES'
	else 'NO'
