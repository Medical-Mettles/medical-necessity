library PancreasTransplant version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Beta Cell Autoantibody Test": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.54'
valueset "Fasting C peptide Test": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.55'
valueset "Fasting Glucose Test": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.56'
valueset "Insulinopenia": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.57'
valueset "Labile brittle diabetes mellitus": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.58'
valueset "Insulin dependent diabetes mellitus": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.59'
valueset "Hypoglycemia unawareness": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.60'
valueset "Ketoacidosis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.61'
valueset "Type 1 Diabetes ICD10": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.11.1026'
valueset "Type 1 Diabetes SNOMEDCT": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.11.1027'

parameter "ServiceRequest" ServiceRequest

context Patient

define "Type1DiabetesCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Type 1 Diabetes ICD10" or c in "Type 1 Diabetes SNOMEDCT") is not null

define "InsulinopeniaCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Insulinopenia") is not null

define "PrimaryDiagnoses":
	("Type1DiabetesCondition"
	union "InsulinopeniaCondition"
	union "BrittleLabileDiabetesCondition"
	union "InsulinDependentDiabetesCondition") L
	return (First(L.code.coding).display.value)+'\n'

define "BCATest":
  [Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Beta Cell Autoantibody Test") is not null
		and FHIRHelpers.ToConcept(P.value).codes[0].code in {'10828004','POSITIVE'}

define "BetaCellAutoantibody":
  if Last("BCATest") is not null
 then 'Positive'
  else ''

define "CPeptide":
  [Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Fasting C peptide Test") is not null

define "Glucose":
  [Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Fasting Glucose Test") is not null

define "CPeptideTest":
	Last("CPeptide" O
    with [DiagnosticReport]P
    such that P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Fasting C peptide Test") is not null
    and First(P.result R where R.reference.value = 'Observation/'+O.id.value) is not null
		sort by end of "Normalize Interval Observation"(effective))

define "GlucoseTest":
	Last("Glucose" O
    with [DiagnosticReport]P
    such that P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding C where C in "Fasting Glucose Test") is not null
    and First(P.result R where R.reference.value = 'Observation/'+O.id.value) is not null
		and ("Normalize Interval Observation"(P.effective) during Interval[start of "Normalize Interval Observation"("CPeptideTest".effective)-10 minutes,start of "Normalize Interval Observation"("CPeptideTest".effective)+10 minutes]
				or "Normalize Interval Observation"("CPeptideTest".effective) during Interval[start of "Normalize Interval Observation"(P.effective)-10 minutes,start of "Normalize Interval Observation"(P.effective)+10 minutes])
	)

define "CPeptideResult":
  FHIRHelpers.ToQuantity("CPeptideTest".value)

define "GlucoseTestResult":
  FHIRHelpers.ToQuantity("GlucoseTest".value)

define "BrittleLabileDiabetesCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(C.code.coding c where c in "Labile brittle diabetes mellitus") is not null

define "InsulinDependentDiabetesCondition":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding c where c in "Insulin dependent diabetes mellitus") is not null

define "OtherComplicationsResources":
  [Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value in {'active', 'recurrence'}
		and C.severity.coding[0].display.value='Severe'
		and First(C.code.coding c where c in "Hypoglycemia unawareness"
        or c in "Ketoacidosis"
        or c in "Labile brittle diabetes mellitus") is not null

define "OtherComplications":
	("OtherComplicationsResources") L
	return (First(L.code.coding).display.value)+'\n'

define function "Normalize Interval Observation"(choice Choice<FHIR.dateTime, FHIR.Period>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
	  else null
