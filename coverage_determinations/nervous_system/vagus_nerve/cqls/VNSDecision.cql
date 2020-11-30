library VNSDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include VagusNerveStimulation version '1.0.0' called VNS

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

define QT:
	"QuestionnaireResponse".item

define QA14:
	("QT".item I
		where I.linkId.value = '1.4')QR
		return First(QR.answer).value

define "PrimaryDiagnosesResources":
	VNS."PrimaryDiagnosesResources"

define "SurgeryResources":
	VNS."SurgeryResources"

define "DepressionCondition":
	VNS."DepressionCondition"

define "DepressionReasonCheck":
	"ServiceRequest" P
		where (First(P.reasonCode R where First(R.coding) in "Resistant depression") is not null)
		or (First(P.reasonReference RR
			with "DepressionCondition" D
			such that RR.reference.value = 'Condition/'+D.id.value) is not null)

define PrimaryDecision:
	if ((Last("PrimaryDiagnosesResources") is not null)
			and (exists("SurgeryResources"P where First(P.outcome.coding) in "Procedure Unsuccessful")
					or First("QA14") = false)
			and "DepressionReasonCheck" is null)
	then true
	else false

define FinalDecision:
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'NO'