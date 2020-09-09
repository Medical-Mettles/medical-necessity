library StressEchoCommon version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers


codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "CABG, PCI Procedure": '2.16.840.1.113762.1.4.1138.566'
valueset "Vital Sign Result Type": '2.16.840.1.113883.3.88.12.80.62'
valueset "Systolic blood pressure": '2.16.840.1.113762.1.4.1045.178'
valueset "StressEchoCardiography Diagnosis List": '99.1'
valueset "Electrocardiogram": '99.2'
valueset "Stress Test with EKG monitoring": '99.3'
valueset "Diabetes Mellitus": '99.4'
valueset "Left bundle-branch block": '99.5'
valueset "Ventricular premature depolarization": '99.6'
valueset "Cardiomegaly": '99.7'
valueset "StressEchoCardiography Imaging Diagnosis": '99.8'
valueset "StressEchoCardiography related Imaging Study": '99.9'
valueset "Symptoms for Undergoing StressEchoCardiography": '99.10'
valueset "Computed tomography, heart": '99.11'
valueset "Pre-excitation syndrome": '99.12'
valueset "Ventricular tachycardia": '99.13'
valueset "Arm Pain": '99.14'
valueset "Jaw Pain": '99.15'
valueset "Shortness of breath": '99.16'
valueset "Chest pain": '99.17'

parameter "ServiceRequest" ServiceRequest

context Patient

define PCICABGCodes:
		([Procedure]P
		where P.status.value = 'completed'
		and First(P.code.coding) in "CABG, PCI Procedure")

define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define Evaluation:
	First([Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
	  and C.encounter.reference.value = 'Encounter/'+ "ServiceEncounter".id.value
	  and First(C.verificationStatus.coding).code.value = 'unconfirmed'
	  and  First(C.code.coding) in "StressEchoCardiography Diagnosis List")

define PatientHistory:
	exists([Condition]C
	with [Observation]O
	such that C.subject.reference.value = 'Patient/'+ Patient.id.value
		and O.subject.reference.value = 'Patient/'+ Patient.id.value)

define ImagingHistory:
	[DiagnosticReport]D
	where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and ("Normalize Interval Procedure"(D.effective)) starts after Today()-60 days

define VitalSigns:
	First([Observation]O
	where O.subject.reference.value = 'Patient/'+ Patient.id.value
		and O.encounter.reference.value = 'Encounter/'+ "ServiceEncounter".id.value
		and First(O.code.coding) in "Vital Sign Result Type")


define ECG:
	[Procedure]P
	where First(P.code.coding) in "Electrocardiogram"

define Diabetic:
	[Condition]C
	where First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding) in "Diabetes Mellitus"

define HighSystolicPressure:
	exists("VitalSigns".component C
		where First(C.code.coding) in "Systolic blood pressure"
			and FHIRHelpers.ToQuantity(C.value).value > 180)

define UninterpretableECG:
	exists([Condition]C
	where First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding) in "Left bundle-branch block"
			or First(C.code.coding) in "Ventricular premature depolarization"
			or First(C.code.coding) in "Cardiomegaly"
			or First(C.code.coding) in "Pre-excitation syndrome")

define ETTPerformed:
	exists([Procedure]P
	where P.status.value = 'completed'
		and First(P.code.coding) in "Stress Test with EKG monitoring" )

define ImagingConditions:
	[Condition]C
	where First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding) in "StressEchoCardiography Imaging Diagnosis"

define VentricularTachycardia:
	[Condition]C
		where First(C.code.coding) in "Ventricular tachycardia"
			and First(C.clinicalStatus.coding).code.value = 'active'

define ComputerTomography:
	[Procedure]P
		where First(P.code.coding) in "Computed tomography, heart"
			and P.status.value = 'completed'

define function "Normalize Interval Procedure"(choice Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
		else if choice is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	  else if choice is FHIR.Age then
	 	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age),
 		FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age) + 1 year)
		else if choice is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).high) + 1 year)
	  else null


define function "Normalize Onset"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else if onset is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).high) + 1 year)
	else null
