library VentricularAssistDevices version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include VADDecision version '1.0.0' called VADCommon

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "CDCNHSN": '2.16.840.1.113883.6.277'


valueset "Beta Blocker Therapy": '2.16.840.1.113883.3.526.3.1174'
valueset "ECMO": '2.16.840.1.113762.1.4.1029.22'
valueset "Heart Failure": '2.16.840.1.113762.1.4.1182.93'
valueset "ACE Inhibitor or ARB or ARNI": '2.16.840.1.113883.3.526.3.1139'
valueset "IV Positive Inotropic and Vasopressor Agents": '2.16.840.1.113883.3.666.5.2128'
valueset "LVEF Assessment": '2.16.840.1.113762.1.4.1047.190'
valueset "Mechanical Circulatory Assist Device": '2.16.840.1.113883.3.3157.4050'
valueset "Intra-aortic balloon pump (IABP) device": '2.16.840.1.113883.3.6037.1001.23.99.49'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'
valueset "Medical care (regime/therapy)": '2.16.840.1.113883.3.6037.1001.23.99.51'
valueset "Oxygen consumption (VO2)/Heart rate --peak during exercise": '2.16.840.1.113883.3.6037.1001.23.99.52'
valueset "Cardioassist by aortic balloon pump (procedure)": '2.16.840.1.113883.3.6037.1001.23.99.53'
valueset "Postcardiotomy syndrome": '2.16.840.1.113883.3.6037.1001.23.99.54'
valueset "Open heart surgery (procedure)": '2.16.840.1.113883.3.6037.1001.23.99.55'
valueset "Transplantation of heart (procedure)": '2.16.840.1.113883.3.6037.1001.23.99.56'

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
		VADCommon."PostCardiotomy"

define OpenHeartProcedure:
	First([Procedure]P
		where First(P.code.coding) in "Open heart surgery (procedure)"
			and P.status.value in 'completed'
			and P.subject.reference.value = 'Patient/'+ Patient.id.value
				)

define RelevantDiagnosis:
		First("ServiceCondition".code.coding).display.value

define BridgeTransplant:
	VADCommon."BridgeTransplant"	

define ProcedureApproved:
	First("BridgeTransplant".code.coding).display.value

define DTDeviceRequest:
	VADCommon."DTDeviceRequest"

define MechanicalDevicePrescribed:
	First(("DTDeviceRequest".code as CodeableConcept).coding).display.value

define HeartFailurePatient:
	VADCommon."HeartFailurePatient"

define BetaMedicationAdministration:
	VADCommon."BetaMedicationAdministration"


define ACEMedicationAdministration:
	VADCommon."ACEMedicationAdministration"
	
define function "LengthInDays"(Value Interval<DateTime>):
	difference in days between start of Value and end of Value

define BallooonPumpAssist:
	VADCommon."BallooonPumpAssist"
	
define InotropeAdministration:
	VADCommon."InotropeAdministration"

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
	VADCommon."OptimalMedicationManagement1"

define OptimalMedicationManagement2:
	VADCommon."OptimalMedicationManagement2"
	
define OptimalMedicationManagement3:
	VADCommon."OptimalMedicationManagement3"
	
define LVEFResource:
	First([Observation]O
		where First(O.code.coding) in "LVEF Assessment"
		and O.status.value = 'final')

define LVEFResult:
	(First([Observation]O
		where First(O.code.coding) in "LVEF Assessment"
		and O.status.value = 'final'))L
		return FHIRHelpers.ToQuantity(L.value)

define PeakOxygenConsumptionResource:
	First([Observation]O
		where First(O.code.coding) in "Oxygen consumption (VO2)/Heart rate --peak during exercise"
		and O.status.value = 'final')

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
