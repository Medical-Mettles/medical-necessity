library AdultLiverTransplant version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Primary Diagnoses- Adult Liver Transplant": '2.16.840.1.113883.3.6037.1001.23.98.79'
valueset "End Stage Liver Disease": '2.16.840.1.113883.3.6037.1001.23.98.80'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Liver bodysite": '2.16.840.1.113883.3.6037.1001.23.98.82'
valueset "Hepatocellular carcinoma": '2.16.840.1.113883.3.6037.1001.23.98.83'

parameter "ServiceRequest" ServiceRequest

context Patient

define "EndStageCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "End Stage Liver Disease") is not null

define "Malignancies":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Primary Diagnoses- Adult Liver Transplant") is not null

define "CarcinomaCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Hepatocellular carcinoma") is not null

define "PrimaryDiagnoses":
	("EndStageCondition"
	union "Malignancies"
	union "CarcinomaCondition") L
	return (First(L.code.coding).display.value)+'\n'

define "LiverCellCarcinoma":
	if First("CarcinomaCondition") is not null
	then true
	else false

define "TumorSizeObservation":
  Last([Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Tumor size") is not null
		and exists(P.bodySite.coding co where co in "Liver bodysite"))

define "SizeofTumor":
	FHIRHelpers.ToQuantity("TumorSizeObservation".value)

