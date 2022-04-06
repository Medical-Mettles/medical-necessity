library LongArmSplint version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Application of Long Arm Splint Service": '2.16.840.1.113883.3.6037.1001.23.93.254'
valueset "Humerus Fracture": '2.16.840.1.113883.3.6037.1001.23.93.255'
valueset "Physical Therapy": '2.16.840.1.113883.3.6037.1001.23.93.256'
valueset "Occupational Therapy": '2.16.840.1.113883.3.6037.1001.23.93.257'
valueset "Dislocated Humerus": '2.16.840.1.113883.3.6037.1001.23.93.258'
valueset "Contracture Elbow": '2.16.840.1.113883.3.6037.1001.23.93.259'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define LongArmSplintApplication:
  "Request".code.coding C where C in "Application of Long Arm Splint Service"

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

define RestorativeRequest:
	if exists("LongArmSplintApplication")
				    then true
              else false

define TypeOfRequest:
	if ("RestorativeRequest" = true)
				then 'Restorative or Rehabilitative Therapy'
            else null

define RestorativeServicePT:
  if exists("LongArmSplintApplication")
    then 'Application of a Splint'
      else null

define RestorativeServiceOT:
  if exists("LongArmSplintApplication")
    then 'Application of a Splint'
      else null

define TypeOfSplinting:
   if exists("LongArmSplintApplication")
    then 'Application of Long Arm Splint'
      else null

define FractureLongArmHumerus:
  [Condition]C
    where exists(C.code.coding C where C in "Humerus Fracture")
      and First(C.clinicalStatus.coding).code.value = 'active'

define DislocatedLongArmHumerus:
  [Condition]C
    where exists(C.code.coding C where C in "Dislocated Humerus")
      and First(C.clinicalStatus.coding).code.value = 'active'

define ContractureElbow:
  [Condition]C
    where exists(C.code.coding C where C in "Contracture Elbow")
      and First(C.clinicalStatus.coding).code.value = 'active'

define LongArmSplintConditions:
	if exists("FractureLongArmHumerus")
		then 'Fracture'
      else if exists("DislocatedLongArmHumerus")
		    then 'Dislocation'
          else if exists("ContractureElbow")
            then 'Soft Tissue Deformities'
			        else null

define LongArmFracturePart:
  if exists("FractureLongArmHumerus")
    then 'Distal Humerus'
      else null

define LongArmDislocationPart:
  if exists("DislocatedLongArmHumerus")
    then 'Distal Humerus'
      else null

define LongArmTissueDeformityType:
  if exists("ContractureElbow")
    then 'Contracture'
      else null

define LongArmTissueDeformityPart:
  if exists("ContractureElbow")
    then 'Elbow'
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
