library VADDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

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
// Organ Procurement and Transplantation Network
//Medicare-approved heart transplant center

code "Intra-aortic balloon pump (IABP) device": '3063-5' from "CDCNHSN" display 'Intra-aortic balloon pump (IABP) device'
code "Unsuccessful": '385671000' from "SNOMED-CT" display 'Unsuccessful'
code "Medical care (regime/therapy)": '781087000'from "SNOMED-CT" display 'Medical care (regime/therapy)'
code "Oxygen consumption (VO2)/Heart rate --peak during exercise": '94120-3' from "LOINC" display 'Oxygen consumption (VO2)/Heart rate --peak during exercise'
code "Cardioassist by aortic balloon pump (procedure)": '399217008' from "SNOMED-CT" display 'Cardioassist by aortic balloon pump (procedure)'
code "Postcardiotomy syndrome":'I97.0' from "ICD-10-CM" display 'Postcardiotomy syndrome'
code "Open heart surgery (procedure)": '2598006' from "SNOMED-CT" display 'Open heart surgery (procedure)'
code "Transplantation of heart (procedure)": '32413006' from "SNOMED-CT" display 'Transplantation of heart (procedure)'

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
		First([Condition] C
			with [Procedure] P
			such that First(C.code.coding) = "Postcardiotomy syndrome"
				and First(P.code.coding) = "Open heart surgery (procedure)"
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
		
		
define Case1:
	if ("PostCardiotomy" is not null) and (First("QA31").value = true)
	then true
	else false
	
define BridgeTransplant:
		exists ([Procedure]T
			where First(T.code.coding) = "Transplantation of heart (procedure)"
				and T.status.value = 'not-done'
				and T.subject.reference.value = 'Patient/'+ Patient.id.value)
				
define Case2:
	if (("BridgeTransplant" = true) 
		and (First("QA32").value = true) 
		and (First("QA31").value = true) 
		and (First("QA33").value = true) 
		and (First("QA34").value = true)
		and ("ClaimResponse".outcome.value = 'complete'))
	then true
	else false
	
define DTDeviceRequest:
	First([DeviceRequest]D
		where (D.code as CodeableConcept) in "Mechanical Circulatory Assist Device"
				or exists([Device: "Mechanical Circulatory Assist Device"]device 
					where (D.code as Reference).reference.value = 'Device/'+device.id.value))
	     
				
define Case3:
	if(("DTDeviceRequest" is not null) and (First("QA31").value = true))
	then true 
	else false

define HeartFailurePatient:
	First([Condition:"Heart Failure"]C
		where First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.verificationStatus.coding).code.value = 'confirmed'
	     )
		
define BetaMedicationAdministration:
	First([MedicationAdministration]M
		where ((M.medication as CodeableConcept) in "Beta Blocker Therapy"
			and  ("Normalize Interval Procedure"(M.effective)) starts after Today()-60 days)
			or exists([Medication:"Beta Blocker Therapy" ]med where (M.medication as Reference).reference = 'Medication/'+med.id))
	     
		
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
		where First(P.code.coding) = "Cardioassist by aortic balloon pump (procedure)"
			and First(P.outcome.coding) = "Unsuccessful"
			and "LengthInDays"(P.performed) > 7 days
	     )
			
define InotropeAdministration:
	First([MedicationAdministration]M 
		where ((M.medication as CodeableConcept) in "IV Positive Inotropic and Vasopressor Agents"
			or exists([Medication:"IV Positive Inotropic and Vasopressor Agents" ]med where (M.medication as Reference).reference = 'Medication/'+med.id))	
		and "LengthInDays"(M.effective) > 14 days
	     )
			
define OptimalMedicationManagement1:
	First([Procedure]P
		with "InotropeAdministration" I
		such that First(P.code.coding) = "Medical care (regime/therapy)"	
			and First(P.partOf).reference.value = 'MedicationAdministration/' + I.id.value
			and First(P.outcome.coding) = "Unsuccessful"
	     )

define OptimalMedicationManagement2:
	First([Procedure]P
		with "ACEMedicationAdministration" I
		such that First(P.code.coding) = "Medical care (regime/therapy)"	
			and First(P.partOf).reference.value = 'MedicationAdministration/' + I.id.value
			and First(P.outcome.coding) = "Unsuccessful"
	     )	
	     
define OptimalMedicationManagement3:
	First([Procedure]P
		with "BetaMedicationAdministration" I
		such that First(P.code.coding) = "Medical care (regime/therapy)"	
			and First(P.partOf).reference.value = 'MedicationAdministration/' + I.id.value
			and First(P.outcome.coding) = "Unsuccessful"
	     )     

define OptimalMedicationManagement:
	if (("OptimalMedicationManagement1" is not null)
		or ("OptimalMedicationManagement2" is not null)
		or ("OptimalMedicationManagement3" is not null)
	)
	then true
	else false
	
define LVEF:
	exists([Observation]O
		where First(O.code.coding) in "LVEF Assessment"	
		and O.status.value = 'final'
		and FHIRHelpers.ToQuantity(O.value) < 25)
	
define PeakOxygenConsumption:
	exists([Observation]O
		where First(O.code.coding) = "Oxygen consumption (VO2)/Heart rate --peak during exercise"
		and O.status.value = 'final'
		and FHIRHelpers.ToQuantity(O.value) <= 14)

define RelevantProcedure:
	if(("OptimalMedicationManagement" = true) or ("BallooonPumpAssist" is not null))
	then true
	else false
	
define PatientCriteria1:
	if (("HeartFailurePatient" is not null)
		and ("RelevantProcedure" = true)
		and ("LVEF" = true)
		and ("PeakOxygenConsumption" = true)
		and (First("QA32").value = false)
		and (First("QA33").value = false))
	then true
	else false
	
define PatientCriteria2:
	if (("HeartFailurePatient" is not null)
		and ("RelevantProcedure" = true)
		and ("LVEF" = true)
		and ("PeakOxygenConsumption" = false)
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