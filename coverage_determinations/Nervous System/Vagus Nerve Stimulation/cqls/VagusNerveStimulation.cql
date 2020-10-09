library VagusNerveStimulation version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include VNSDecision version '1.0.0' called VNSDecision

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Medically refractory partial onset seizures": '2.16.840.1.113883.3.6037.1001.23.97.15'
valueset "Epilepsy Surgery": '2.16.840.1.113883.3.6037.1001.23.97.16'
valueset "Resistant depression": '2.16.840.1.113883.3.6037.1001.23.97.17'
valueset "Vagus Nerve Stimulation": '2.16.840.1.113883.3.6037.1001.23.97.18'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'

parameter "ServiceRequest" ServiceRequest
parameter "QuevstionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "PrimaryDiagnoses":
	(VNSDecision."PrimaryDiagnosesResources"
	union VNSDecision."DepressionCondition") P
	return P.code.coding[0].display.value+'\n'

define "SurgeryResources":
	VNSDecision."SurgeryResources"

define "SurgeryPerformed":
	"SurgeryResources" P
	return P.code.coding[0].display.value+'\n'

define "SurgeryOutcome":
	if First("SurgeryResources".outcome.coding) is not null
	then First("SurgeryResources".outcome.coding).display.value
	else ''