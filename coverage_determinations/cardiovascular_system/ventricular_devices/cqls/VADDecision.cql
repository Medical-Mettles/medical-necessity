library VADDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include VentricularAssistDevices version '1.0.0' called VADCommon

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "CDCNHSN": '2.16.840.1.113883.6.277'

valueset "LVEF Assessment": 'https://ValueSet/2.16.840.1.113762.1.4.1047.190'
valueset "Oxygen consumption (VO2)/Heart rate --peak during exercise": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.99.52'

parameter "DeviceRequest" DeviceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define QT:
	"QuestionnaireResponse".item

//they have received approval from the Food and Drug Administration (FDA)
define QA31:
	("QT".item I
		where I.linkId.value = '3.1')QR
		return First(QR.answer).value

//The patient is approved for heart transplantation by a Medicare-approved heart transplant center
define QA32:
	("QT".item I
		where I.linkId.value = '3.2')QR
		return First(QR.answer).value

//active on the Organ Procurement and Transplantation Network (OPTN) heart transplant waitlist
define QA33:
	("QT".item I
		where I.linkId.value = '3.3')QR
		return First(QR.answer).value

// implanting site, if different than the Medicare-approved transplant center
define QA34:
	("QT".item I
		where I.linkId.value = '3.4')QR
		return First(QR.answer).value

define QA35:
	("QT".item I
		where I.linkId.value = '3.5')QR
		return First(QR.answer).value

define PostCardiotomy:
		VADCommon."PostCardiotomy"
		
define Case1:
	if ("PostCardiotomy" is not null) and (First("QA31").value = true)
	then true
	else false

define BridgeTransplant:
	VADCommon."BridgeTransplant"	

define Case2:
	if (("BridgeTransplant" is not null)
		and (First("QA32").value = true)
		and (First("QA31").value = true)
		and (First("QA33").value = true)
		and (First("QA34").value = true)
		and ("ClaimResponse".outcome.value = 'complete'))
	then true
	else false

define DTDeviceRequest:
	VADCommon."DTDeviceRequest"


define Case3:
	if(("DTDeviceRequest" is not null) and (First("QA31").value = true))
	then true
	else false

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
	
define OptimalMedicationManagement1:
	VADCommon."OptimalMedicationManagement1"

define OptimalMedicationManagement2:
	VADCommon."OptimalMedicationManagement2"

define OptimalMedicationManagement3:
	VADCommon."OptimalMedicationManagement3"
	
define OptimalMedicationManagement:
	if (("OptimalMedicationManagement1" is not null)
		or ("OptimalMedicationManagement2" is not null)
		or ("OptimalMedicationManagement3" is not null)
	)
	then true
	else false

define LVEF:
	VADCommon."LVEF"

define PeakOxygenConsumption:
	VADCommon."PeakOxygenConsumption"

define RelevantProcedure:
	if(("OptimalMedicationManagement" = true) or ("BallooonPumpAssist" is not null))
	then true
	else false

define PatientCriteria1:
	if (("HeartFailurePatient" is not null)
		and ("RelevantProcedure" = true)
		and ("LVEF" is not null)
		and ("PeakOxygenConsumption" is not null)
		and (First("QA32").value = false)
		and (First("QA33").value = false))
	then true
	else false

define PatientCriteria2:
	if (("HeartFailurePatient" is not null)
		and ("RelevantProcedure" = true)
		and ("LVEF" is not null)
		and ("PeakOxygenConsumption" is not null)
		and (First("QA35").value = true)
		and (First("QA32").value = false)
		and (First("QA33").value = false))
	then true
	else false

define PatientCriteria:
	if (("PatientCriteria1" = true) or ("PatientCriteria2" = true))
	then true
	else false

//At least one physician with cardiothoracic surgery privileges and individual experience implanting at least 10 durable, intracorporeal, left VADs as BTT or DT over the course of the previous 36 months with activity in the lastyear
define QA41:
	("QT".item I
		where I.linkId.value = '4.1')QR
		return First(QR.answer).value

//At least one cardiologist trained in advanced heart failure with clinical competence in medical and device-based management including VADs, and clinical competence in the management of patients before and after heart transplant
define QA42:
	("QT".item I
		where I.linkId.value = '4.2')QR
		return First(QR.answer).value

//A VAD program coordinator
define QA43:
	("QT".item I
		where I.linkId.value = '4.3')QR
		return First(QR.answer).value

// A social worker
define QA44:
	("QT".item I
		where I.linkId.value = '4.4')QR
		return First(QR.answer).value

//A palliative care specialist.
define QA45:
	("QT".item I
		where I.linkId.value = '4.5')QR
		return First(QR.answer).value

//Facilities must be credentialed by an organization approved by the C enters for Medicare & Medicaid Services


define FacilityCriteria:
	if ((First("QA41").value = true)
		and (First("QA42").value = true)
		and (First("QA43").value = true)
		and (First("QA44").value = true)
		and (First("QA45").value = true)
		and (First("QA35").value = true))
	then true
	else false

define PrimaryDecision:
	if (("Case1" = true) and ("PatientCriteria" = true) and ("FacilityCriteria" = true))
	then true
	else
	if (("Case2" = true) and ("PatientCriteria" = true) and ("FacilityCriteria" = true))
	then true
	else
	if (("Case3" = true) and ("PatientCriteria" = true) and ("FacilityCriteria" = true))
	then true
	else false

define FinalDecision:
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'NO'


