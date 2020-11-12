library OPTPrepopulation version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Optical coherence tomography (OCT)":  '2.16.840.1.113762.1.4.1047.541'
valueset "Photodynamic therapy": '2.16.840.1.113883.3.6037.1001.23.95.19'
valueset "verteporfin": '2.16.840.1.113883.3.6037.1001.23.95.20'
valueset "Fluorescein angiography of eye": '2.16.840.1.113883.3.6037.1001.23.95.18'
valueset "Neovascular age-related macular degeneration": '2.16.840.1.113883.3.6037.1001.23.95.16'
valueset "Ocular age-related macular degeneration": '2.16.840.1.113883.3.6037.1001.23.95.17' 

parameter "ServiceRequest" ServiceRequest

context Patient

define PrimaryDiagnosis:
    First([Condition]C
		where exists(C.code.coding C where C in "Neovascular age-related macular degeneration")
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed')

define RelevantDiagnoses:
    First("PrimaryDiagnosis".code.coding).display.value

define DateOfOnset:
    start of "Normalize Onset"("PrimaryDiagnosis".onset)

define DiagnosisEncounter:
   First([Encounter]E 
        where 'Encounter/' + E.id.value = "PrimaryDiagnosis".encounter.reference.value)

define NotCoveredCondition:
    First([Condition]C
		where exists(C.code.coding C where C in "Ocular age-related macular degeneration")
            and First(C.clinicalStatus.coding).code.value = 'active'
            and First(C.verificationStatus.coding).code.value = 'confirmed')


define FAProcedure:
    First([Procedure]I
        where exists(I.code.coding F where F in "Fluorescein angiography of eye")
            and I.status.value = 'completed'
            and start of "Normalize Interval Procedure"(I.performed) after start of "Normalize Interval Procedure"("DiagnosisEncounter".period)
            and I.encounter.reference.value = "PrimaryDiagnosis".encounter.reference.value)


define OCTProcedure:
    First([Procedure]I
        where exists(I.code.coding F where F in "Optical coherence tomography (OCT)")
            and I.status.value = 'completed'
            and start of "Normalize Interval Procedure"(I.performed) after start of "Normalize Interval Procedure"("FAProcedure".performed))

define FAResult:
    First([Observation]O
        where  First(O.partOf.reference).value = 'Procedure/' + "FAProcedure".id.value
            and First(O.interpretation.coding).code.value in {'A','AA','HH','LL','H','HU'})

define OCTResult:
    First([Observation]O
        where  First(O.partOf.reference).value = 'Procedure/' + "OCTProcedure".id.value
            and First(O.interpretation.coding).code.value in {'A','AA','HH','LL','H','HU'})

define VerteporfinAdministration:
    First([MedicationAdministration]M
        where ((M.medication as CodeableConcept) in "verteporfin"
			or exists([Medication:"verteporfin" ]med where (M.medication as Reference).reference = 'Medication/'+med.id)))

define OPTProcedure:
    ([Procedure]P
        with "VerteporfinAdministration" V
            such that exists(P.code.coding P where P in "Photodynamic therapy")
                and "Normalize Interval Procedure"(P.performed) overlaps "Normalize Interval Procedure"(V.effective))
        
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