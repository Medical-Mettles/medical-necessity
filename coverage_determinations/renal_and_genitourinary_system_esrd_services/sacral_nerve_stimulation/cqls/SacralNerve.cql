library SacralNerve version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Urinary Incontinence Diagnoses": '2.16.840.1.113883.3.6037.1001.23.98.62'
valueset "Excluded Diagnoses for Sacral Nerve Stimulation": '2.16.840.1.113883.3.6037.1001.23.98.63'
valueset "Test Stimulation": '2.16.840.1.113883.3.6037.1001.23.98.64'
valueset "Voiding Diaries": '2.16.840.1.113883.3.6037.1001.23.98.65'
valueset "Behavioral Therapy": '2.16.840.1.113883.3.6037.1001.23.98.66'
valueset "Pharmacological Therapy": '2.16.840.1.113883.3.6037.1001.23.98.67'
valueset "Other Surgeries": '2.16.840.1.113883.3.6037.1001.23.98.68'
valueset "Procedure Successful": '2.16.840.1.113883.3.6037.1001.23.98.69'
valueset "Procedure Partially Successful": '2.16.840.1.113883.3.6037.1001.23.98.70'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'

parameter "ServiceRequest" ServiceRequest

context Patient

define "IncontinenceConditions":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Urinary Incontinence Diagnoses") is not null

define "ExcludedConditions":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Excluded Diagnoses for Sacral Nerve Stimulation") is not null

define "PrimaryDiagnoses":
	("IncontinenceConditions"
  union "ExcludedConditions")L
  return (First(L.code.coding).display.value)+'\n'

define "TestStimulationProcedure":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and exists(P.code.coding C where C in "Test Stimulation")

define "TestStimulation":
	"TestStimulationProcedure" P
	return (First(P.code.coding).display.value)+'\n'

define "TestStimulationOutcome":
	Last("TestStimulationProcedure").outcome.coding[0].display.value

define "VoidingDiariesObservation":
	[Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Voiding Diaries") is not null

define "TestStimulationObservation":
	"VoidingDiariesObservation" O
	with "TestStimulationProcedure" P
	such that exists(O.partOf l where l.reference.value = 'Procedure/'+P.id.value)

define "BehavioralTherapyProcedure":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and exists(P.code.coding C where C in "Behavioral Therapy")

define "BehavioralTherapy":
	"BehavioralTherapyProcedure" P
	return (First(P.code.coding).display.value)+'\n'

define "MedicationAdministrationResources":
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and (First(((M.medication as CodeableConcept).coding) P where P in "Pharmacological Therapy") is not null
		or First([Medication]med
							where (M.medication as Reference).reference.value = 'Medication/'+med.id.value
							and ((med.code.coding)C where C in "Pharmacological Therapy") is not null
				) is not null
			) is not null

define "ProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and exists(P.code.coding C where C in "Procedure for Medication Administration")

define "PharmacologicalAdministration":
	"MedicationAdministrationResources" M
	with "ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "PharmacologicalProcedure":
  "ProcedureResources" P
	with"MedicationAdministrationResources" M
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "PharmacologicalTherapy":
	"PharmacologicalAdministration" P
	return (if (P.medication as CodeableConcept) is not null
					then ((P.medication as CodeableConcept).coding[0].display.value+'\n')
					else (First([Medication]med
							where (P.medication as Reference).reference.value = 'Medication/'+med.id.value).code.coding[0].display.value+'\n')
				)

define "OtherSurgeryResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and exists(P.code.coding C where C in "Other Surgeries")

define "OtherSurgeries":
	"OtherSurgeryResources" P
	return (First(P.code.coding).display.value)+'\n'