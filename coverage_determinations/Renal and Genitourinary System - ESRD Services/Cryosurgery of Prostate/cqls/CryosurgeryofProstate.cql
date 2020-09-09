library CryosurgeryofProstate version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Malignant neoplasm of prostate": '2.16.840.1.113883.3.6037.1001.23.97.0'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Tumor Stage T2b or below": '2.16.840.1.113883.3.6037.1001.23.97.2'
valueset "Radiation Treatment Management": '2.16.840.1.113883.3.6037.1001.23.97.3'
valueset "Gleason score": '2.16.840.1.113883.3.6037.1001.23.97.4'
valueset "Prostate specific Ag": '2.16.840.1.113883.3.6037.1001.23.97.5'

parameter "ServiceRequest" ServiceRequest

context Patient

define RadiationTherapyProcedure:
	First(
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and (First(P.code.coding) in "Radiation Treatment Management"))

define RadiationTherapy:
	if "RadiationTherapyProcedure" is not null
	then First("RadiationTherapyProcedure".code.coding).display.value
	else ''

define ProcedureDate:
	start of "Normalize Interval Procedure"("RadiationTherapyProcedure".performed)

define ProcedureOutcome:
	if First("RadiationTherapyProcedure".outcome.coding) is not null
	then First("RadiationTherapyProcedure".outcome.coding).display.value
	else ''

define TumorCondition:
	First(
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and First(P.code.coding) in "Malignant neoplasm of prostate"
	)

define TumorStage:
	if First(TumorCondition.stage).summary is not null
	then First(First(TumorCondition.stage).summary.coding).display.value
	else ''

define GleasonScoreObservation:
	First(
	[Observation]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Gleason score")

define GleasonScore:
	FHIRHelpers.ToQuantity("GleasonScoreObservation".value).value

define ProstateSpecificAntigenObservation:
	First(
	[Observation]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Prostate specific Ag")

define ProstateSpecificAntigen:
	if "ProstateSpecificAntigenObservation" is not null
	then FHIRHelpers.ToQuantity("ProstateSpecificAntigenObservation".value).value
	else null

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