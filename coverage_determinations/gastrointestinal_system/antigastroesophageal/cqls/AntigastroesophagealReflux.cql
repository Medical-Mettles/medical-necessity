library AntigastroesophagealReflux version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Procedure Contraindicated": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.71'
valueset "Valvuloplasty Procedure": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.72'
valueset "Gastroesophageal reflux disease": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.73'
valueset "Systemic sclerosis": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.74'
valueset "Esophagus bodysite": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.75'
valueset "Foreshortening of esophagus": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.76'
valueset "Insufficient esophageal tissue": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.77'
valueset "Esophageal valve reconstruction": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.98.78'
valueset "Procedure Unsuccessful": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'

parameter "ServiceRequest" ServiceRequest

context Patient

define "ValvuloplastyContraindicated":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'not-done'
		and exists(P.code.coding C where C in "Valvuloplasty Procedure")
		and (P.statusReason.coding in "Procedure Contraindicated"
				or exists(P.outcome.coding C where C in "Procedure Unsuccessful"))

define "ContraindicatedProcedures":
	("ValvuloplastyContraindicated"
	union "ValveReconstruction")L
  return (First(L.code.coding).display.value)+'\n'

define "PrimaryDiagnosesResources":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Gastroesophageal reflux disease") is not null
		and First(C.severity.coding).display.value = 'Severe'

define "PrimaryDiagnoses":
	"PrimaryDiagnosesResources" L
  return (First(L.code.coding).display.value)+'\n'

define "SystemicSclerosisCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Systemic sclerosis") is not null
		and First(C.bodySite.coding c where c in "Esophagus bodysite") is not null

define "EsophagealForeshortening":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Foreshortening of esophagus") is not null

define "InsufficientTissue":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Insufficient esophageal tissue") is not null

define "RelevantDiagnoses":
	("SystemicSclerosisCondition"
	union "EsophagealForeshortening"
	union "InsufficientTissue") L
  return (First(L.code.coding).display.value)+'\n'

define "ValveReconstruction":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'not-done'
		and exists(P.code.coding C where C in "Esophageal valve reconstruction")
		and P.statusReason.coding in "Insufficient esophageal tissue"
