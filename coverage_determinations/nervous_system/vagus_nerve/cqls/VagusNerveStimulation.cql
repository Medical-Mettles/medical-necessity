library VagusNerveStimulation version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Medically refractory partial onset seizures": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.15'
valueset "Epilepsy Surgery": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.16'
valueset "Resistant depression": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.17'
valueset "Vagus Nerve Stimulation": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.18'
valueset "Procedure Unsuccessful": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "PrimaryDiagnosesResources":
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Medically refractory partial onset seizures"

define "DepressionCondition":
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Resistant depression"

define "SurgeryResources":
	[Procedure]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value = 'completed'
		and First(P.code.coding) in "Epilepsy Surgery"

define "PrimaryDiagnoses":
	("PrimaryDiagnosesResources"
	union "DepressionCondition") P
	return P.code.coding[0].display.value+'\n'

define "SurgeryPerformed":
	"SurgeryResources" P
	return P.code.coding[0].display.value+'\n'

define "SurgeryOutcome":
	if First("SurgeryResources".outcome.coding) is not null
	then First("SurgeryResources".outcome.coding).display.value
	else ''