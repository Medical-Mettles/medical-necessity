library VentricularAssistDevices version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "CDCNHSN": '2.16.840.1.113883.6.277'


valueset "Beta Blocker Therapy": 'https://ValueSet/2.16.840.1.113883.3.526.3.1174'
valueset "Heart Failure": 'https://ValueSet/2.16.840.1.113762.1.4.1182.93'
valueset "ACE Inhibitor or ARB or ARNI": 'https://ValueSet/2.16.840.1.113883.3.526.3.1139'
valueset "IV Positive Inotropic and Vasopressor Agents": 'https://ValueSet/2.16.840.1.113883.3.666.5.2128'
valueset "LVEF Assessment": 'https://ValueSet/2.16.840.1.113762.1.4.1047.190'
valueset "Mechanical Circulatory Assist Device": 'https://ValueSet/2.16.840.1.113883.3.3157.4050'
valueset "Unsuccessful": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.50'
valueset "Medical care (regime/therapy)": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.51'
valueset "Oxygen consumption (VO2)/Heart rate --peak during exercise": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.52'
valueset "Cardioassist by aortic balloon pump (procedure)": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.53'
valueset "Postcardiotomy syndrome": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.54'
valueset "Open heart surgery (procedure)": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.55'
valueset "Transplantation of heart (procedure)": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.56'

parameter "DeviceRequest" DeviceRequest

context Patient

define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "DeviceRequest".encounter.reference.value)

define function "GetId"(uri String):
	Last(Split(uri, '/'))

define function "EncounterDiagnosis"(Encounter Encounter):
	Encounter.diagnosis D
	return First([Condition]C
				where C.id.value = "GetId"(D.condition.reference.value)
					and FHIRHelpers.ToInteger(D.rank) = 2)

define ServiceCondition:
	"EncounterDiagnosis"("ServiceEncounter")
		
define PostCardiotomy:
		First([Condition] C
			with [Procedure] P
			such that First(C.code.coding) in "Postcardiotomy syndrome"
				and First(P.code.coding) in "Open heart surgery (procedure)"
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define OpenHeartProcedure:
	First([Procedure]P
		where First(P.code.coding) in "Open heart surgery (procedure)"
			and P.status.value = 'completed'
			and P.subject.reference.value = 'Patient/'+ Patient.id.value
				)

define RelevantDiagnosis:
		First("ServiceCondition".code.coding).display.value

define BridgeTransplant:
		First([Procedure]T
			where First(T.code.coding) in "Transplantation of heart (procedure)"
				and T.status.value = 'not-done'
				and T.subject.reference.value = 'Patient/'+ Patient.id.value)
				
define ProcedureApproved:
	First("BridgeTransplant".code.coding).display.value

	
define DTDeviceRequest:
	First([DeviceRequest]D
		where (D.code as CodeableConcept) in "Mechanical Circulatory Assist Device"
				or exists([Device: "Mechanical Circulatory Assist Device"]device
					where (D.code as Reference).reference.value = 'Device/'+device.id.value)
					)

define MechanicalDevicePrescribed:
	First(("DTDeviceRequest".code as CodeableConcept).coding).display.value

define HeartFailurePatient:
	First([Condition:"Heart Failure"]C
		where First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.verificationStatus.coding).code.value = 'confirmed'
	     )

define BetaMedicationAdministration:
	First([MedicationAdministration]M
		where ((M.medication as CodeableConcept) in "Beta Blocker Therapy"
			and  ("Normalize Interval Procedure"(M.effective)) starts after Today()-60 days)
			or exists([Medication:"Beta Blocker Therapy" ]med where (M.medication as Reference).reference = 'Medication/'+med.id)
			)


define ACEMedicationAdministration:
	First([MedicationAdministration]M
		where ((M.medication as CodeableConcept) in "ACE Inhibitor or ARB or ARNI"
			or exists([Medication:"ACE Inhibitor or ARB or ARNI" ]med where (M.medication as Reference).reference = 'Medication/'+med.id))
		and ("Normalize Interval Procedure"(M.effective)) starts after (Today()-60 days)
	     )
	     

	
define function "LengthInDays"(Value Interval<DateTime>):
	difference in days between start of Value and end of Value

define BallooonPumpAssist:
	First([Procedure]P
		where First(P.code.coding) in "Cardioassist by aortic balloon pump (procedure)"
			and First(P.outcome.coding) in "Unsuccessful"
			and "LengthInDays"(P.performed) > 7 days
	     )

define InotropeAdministration:
	First([MedicationAdministration]M
		where ((M.medication as CodeableConcept) in "IV Positive Inotropic and Vasopressor Agents"
			or exists([Medication:"IV Positive Inotropic and Vasopressor Agents" ]med where (M.medication as Reference).reference = 'Medication/'+med.id))
		and "LengthInDays"(M.effective) > 14 days
	     )

define MedicationPrescribed:
	if ("InotropeAdministration" is not null)
	then First(("InotropeAdministration".medication as CodeableConcept).coding).display.value
	else
	if ("ACEMedicationAdministration" is not null)
	then First(("ACEMedicationAdministration".medication as CodeableConcept).coding).display.value
	else
	if ("BetaMedicationAdministration" is not null)
	then First(("BetaMedicationAdministration".medication as CodeableConcept).coding).display.value
	else null

define MedicationPrescription:
	if ("InotropeAdministration" is not null)
	then "InotropeAdministration"
	else
	if ("ACEMedicationAdministration" is not null)
	then "ACEMedicationAdministration"
	else
	if ("BetaMedicationAdministration" is not null)
	then "BetaMedicationAdministration"
	else null

define MedicationDosage:
	FHIRHelpers.ToDecimal("MedicationPrescription".dosage.dose.value)

define CareTherapy:
	First([Procedure]T
			where First(T.code.coding) in "Medical care (regime/therapy)"
				and T.subject.reference.value = 'Patient/'+ Patient.id.value
				)
				
define OptimalMedicationManagement1:
	First([Procedure]P
		with "InotropeAdministration" I
		such that First(P.code.coding) in "Medical care (regime/therapy)"
			and First(P.partOf).reference.value = 'MedicationAdministration/' + I.id.value
			and First(P.outcome.coding) in "Unsuccessful"
	     )

define OptimalMedicationManagement2:
	First([Procedure]P
		with "ACEMedicationAdministration" I
		such that First(P.code.coding) in "Medical care (regime/therapy)"
			and First(P.partOf).reference.value = 'MedicationAdministration/' + I.id.value
			and First(P.outcome.coding) in "Unsuccessful"
	     )

define OptimalMedicationManagement3:
	First([Procedure]P
		with "BetaMedicationAdministration" I
		such that First(P.code.coding) in "Medical care (regime/therapy)"
			and First(P.partOf).reference.value = 'MedicationAdministration/' + I.id.value
			and First(P.outcome.coding) in "Unsuccessful"
	     )
	
define LVEF:
	First([Observation]O
		where First(O.code.coding) in "LVEF Assessment"
		and O.status.value = 'final'
		and FHIRHelpers.ToQuantity(O.value) < 25)

define LVEFResult:
	(First([Observation]O
		where First(O.code.coding) in "LVEF Assessment"
		and O.status.value = 'final'))L
		return FHIRHelpers.ToQuantity(L.value)

define PeakOxygenConsumptionResource:
	First([Observation]O
		where First(O.code.coding) in "Oxygen consumption (VO2)/Heart rate --peak during exercise"
		and O.status.value = 'final'
		and FHIRHelpers.ToQuantity(O.value) <= 14)

define PeakOxygenConsumption:
	(First([Observation]O
		where First(O.code.coding) in "Oxygen consumption (VO2)/Heart rate --peak during exercise"
		and O.status.value = 'final'))L
		return FHIRHelpers.ToQuantity(L.value)


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
