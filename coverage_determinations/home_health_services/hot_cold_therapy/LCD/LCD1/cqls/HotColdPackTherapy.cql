library HotColdPackTherapy version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Application of Long Arm Splint Service": '2.16.840.1.113883.3.6037.1001.23.93.254'
valueset "Strapping of low back Service": '2.16.840.1.113883.3.6037.1001.23.93.270'
valueset "Hot or Cold Packs Therapy Service": '2.16.840.1.113883.3.6037.1001.23.93.273'
valueset "Muscle Spasms": '2.16.840.1.113883.3.6037.1001.23.93.274'
valueset "Inflammation Conditions": '2.16.840.1.113883.3.6037.1001.23.93.275'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define LongArmSplintApplication:
  "Request".code.coding C where C in "Application of Long Arm Splint Service"

define LowBackStrapping:
  "Request".code.coding C where C in "Strapping of low back Service"

define HotColdPackTherapy:
    "Request".code.coding C where C in "Hot or Cold Packs Therapy Service"

define RestorativeRequest:
	if (exists("LongArmSplintApplication")
        or exists("LowBackStrapping"))
				    then true
              else false

define MaintenanceProgramRequest:
  if (exists("HotColdPackTherapy"))
				    then true
              else false

define TypeOfRequest:
	if ("RestorativeRequest" = true)
				then 'Restorative or Rehabilitative Therapy'
          else if ("MaintenanceProgramRequest" = true)
            then 'Maintenance Program'
              else null

define MaintenanceProgramsPT:
  if exists("HotColdPackTherapy")
    then 'Hot or Cold Packs Therapy'
      else null

define MuscleSpasmConditon:
  [Condition]C
    where exists(C.code.coding C where C in "Muscle Spasms")
      and First(C.clinicalStatus.coding).code.value = 'active'

define InflammationConditon:
  [Condition]C
    where exists(C.code.coding C where C in "Inflammation Conditions")
      and First(C.clinicalStatus.coding).code.value = 'active'

define HotColdDevices:
    (ServiceRequest.quantity as Quantity).value.value

define HotColdTherapyReasons:
  if exists("MuscleSpasmConditon")
		then 'To relieve muscle spasms'
      else if exists("InflammationConditon")
        then 'To reduce inflammation or swelling'
          else null

define EncounterResource:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value )

define FacetoFaceEncounter:
	"EncounterResource" F2FEncounter
	where First(First(F2FEncounter.type).coding) in "Face to Face Encounter"

define FToFEncounter:
	if ("FacetoFaceEncounter" is not null)
	then true
	else false
