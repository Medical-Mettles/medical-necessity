library FingerSplint version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Physical Therapy": '2.16.840.1.113883.3.6037.1001.23.93.256'
valueset "Occupational Therapy": '2.16.840.1.113883.3.6037.1001.23.93.257'
valueset "Application of Long Arm Splint Service": '2.16.840.1.113883.3.6037.1001.23.93.254'
valueset "Strapping of low back Service": '2.16.840.1.113883.3.6037.1001.23.93.270'
valueset "Hot or Cold Packs Therapy Service": '2.16.840.1.113883.3.6037.1001.23.93.273'
valueset "Manual Therapy Service": '2.16.840.1.113883.3.6037.1001.23.93.276'
valueset "Physical Performance Test or Measurement Service": '2.16.840.1.113883.3.6037.1001.23.93.282'
valueset "Application of Finger Splint Service": '2.16.840.1.113883.3.6037.1001.23.93.285'
valueset "Thumb Fracture Conditions": '2.16.840.1.113883.3.6037.1001.23.93.286'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define PhysicalTherapy:
  "Request".code.coding C where C in "Physical Therapy"

define OccupationTherapy:
  "Request".code.coding C where C in "Occupational Therapy"

define PTOrOT:
  if exists("PhysicalTherapy")
    then 'Physical Therapy'
      else if exists("OccupationTherapy")
        then 'Occupational Therapy'
          else null

define LongArmSplintApplication:
  "Request".code.coding C where C in "Application of Long Arm Splint Service"

define LowBackStrapping:
  "Request".code.coding C where C in "Strapping of low back Service"

define HotColdPackTherapy:
    "Request".code.coding C where C in "Hot or Cold Packs Therapy Service"

define ManualTherapyService:
    "Request".code.coding C where C in "Manual Therapy Service"

define PhysicalPerformanceService:
    "Request".code.coding C where C in "Physical Performance Test or Measurement Service"

define FingerSplintService:
    "Request".code.coding C where C in "Application of Finger Splint Service"

define RestorativeRequest:
	if (exists("LongArmSplintApplication")
        or exists("LowBackStrapping")
          or exists("FingerSplintService"))
				    then true
              else false

define MaintenanceProgramRequest:
  if (exists("HotColdPackTherapy"))
				    then true
              else false

define TherapeuticProceduresRequest:
  if (exists("ManualTherapyService"))
    then true
      else false

define EvaluationRequest:
  if exists("PhysicalPerformanceService")
    then true
      else false

define TypeOfRequest:
	if ("RestorativeRequest" = true)
				then 'Restorative or Rehabilitative Therapy'
          else if ("MaintenanceProgramRequest" = true)
            then 'Maintenance Program'
              else if ("TherapeuticProceduresRequest" = true)
                then 'Therapeutic Procedure'
                  else if ("EvaluationRequest" = true)
                    then 'Evaluation or Re-evaluation'
                      else null

define RestorativeServicePT:
  if (exists("LongArmSplintApplication")
        or exists("FingerSplintService"))
          then 'Application of a Splint'
            else null

define RestorativeServiceOT:
  if (exists("LongArmSplintApplication")
        or exists("FingerSplintService"))
          then 'Application of a Splint'
            else null

define TypeOfSplinting:
   if exists("LongArmSplintApplication")
    then 'Application of Long Arm Splint'
      else if exists("FingerSplintService")
        then 'Application of Finger Splint'
          else null

define ThumbFractureCondtion:
  [Condition]C
    where exists(C.code.coding C where C in "Thumb Fracture Conditions")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define FingerSplintConditions:
  if exists("ThumbFractureCondtion")
    then 'Fracture'
      else null

define FingerAffected:
  if exists("ThumbFractureCondtion")
    then 'Thumb'
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
