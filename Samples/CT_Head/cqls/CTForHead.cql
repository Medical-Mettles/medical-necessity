library CTForHead version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'


valueset "NauseaVS": '2.16.840.1.113762.1.4.1146.863'
valueset "VomitingVS": '2.16.840.1.113762.1.4.1146.648'		
valueset "Weakness": '2.16.840.1.113762.1.4.1146.837'
valueset "Leg Weakness Symptoms": '2.16.840.1.113762.1.4.1206.37'
valueset "Fatigue/Weakness/Malaise (ICD10CM)": '2.16.840.1.113762.1.4.1146.862'
valueset "Bulbar Weakness (ICD10CM)": '2.16.840.1.113762.1.4.1146.971'
valueset "Limb Weakness (SNOMED)": '2.16.840.1.113762.1.4.1146.827'
valueset "Cerebral palsy and other paralytic syndromes": '2.16.840.1.113762.1.4.1200.85'
valueset "Neurologic Symptoms of Stroke": '2.16.840.1.113883.3.117.1.7.1.399'
valueset "Stroke Symptoms": '2.16.840.1.113762.1.4.1206.39'
valueset "Stroke transient ischemic attack": '2.16.840.1.113883.3.3157.1331'
valueset "TraumaVS": '2.16.840.1.113883.3.3157.1411'
valueset "Non Penetrating Head Trauma": '2.16.840.1.113883.17.4077.2.1017'
valueset "Trauma Excluding Head": '2.16.840.1.113883.17.4077.3.1030'
valueset "Traumatic Injury": '2.16.840.1.113762.1.4.1029.10'
valueset "Obesity": '2.16.840.1.113762.1.4.1222.35'
valueset "Morbid Obesity": '2.16.840.1.113762.1.4.1164.65'
valueset "BMI Obesity": '2.16.840.1.113762.1.4.1106.41'
valueset "Seizure Disorder": '2.16.840.1.113883.3.464.1003.105.11.1212'
valueset "Peripheral Vascular Disease": '2.16.840.1.113762.1.4.1222.27'
valueset "Diabetes": '2.16.840.1.113762.1.4.1138.739'
valueset "Hypertension": '2.16.840.1.113762.1.4.1029.330'
valueset "Lung Cancer": '2.16.840.1.113762.1.4.1116.88'
valueset "Breast Cancer": '2.16.840.1.113762.1.4.1047.362'
valueset "Lymphoma Diagnosis Prior to Urology Care" : '2.16.840.1.113762.1.4.1151.7'
valueset "Immobilization": '2.16.840.1.113883.17.4077.3.2006'
valueset "Headache" : '2.16.840.1.113762.1.4.1146.808'
valueset "Headache Following Trauma to Head" : 	'2.16.840.1.113762.1.4.1034.311'
valueset "New Daily Persistent Headache" : '2.16.840.1.113762.1.4.1034.290'
valueset "Hemorrhage": '2.16.840.1.113762.1.4.1029.258'

code "Unspecified visual disturbance": 'H53.9' from "ICD-10-CM"
code "Pacemaker, other than single or dual chamber (implantable)": 'C2621' from "HCPCS"
code "Cochlear device, includes all internal and external components": 'L8614' from "HCPCS"
code "Intracranial space-occupying lesion found on diagnostic imaging of central nervous system": 'R90.0' from "ICD-10-CM"
code "Other visual disturbances": 'H53.8' from "ICD-10-CM"

parameter "ServiceRequest" ServiceRequest

context Patient

define BlurredVision:
    exists([Condition:"Other visual disturbances"])

define Nausea:
    exists([Observation]O 
        where O.status.value in {'final', 'amended', 'corrected'}
			and exists(O.code.coding x where x in "NauseaVS"))

define Vomiting:
    exists([Observation]O 
        where O.status.value in {'final', 'amended', 'corrected'}
			and exists(O.code.coding x where x in "VomitingVS"))

define SignsOfWeakness:
    exists([Observation]O 
        where O.status.value in {'final', 'amended', 'corrected'}
			and exists(O.code.coding x where (x in "Weakness")
                                            or (x in "Leg Weakness Symptoms")
                                            or (x in "Fatigue/Weakness/Malaise (ICD10CM)")
                                            or (x in "Limb Weakness (SNOMED)")))

define SymptomsOfParalysis:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
			and exists(C.code.coding x where x in "Cerebral palsy and other paralytic syndromes"))

define ExtremeObesity:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where (x in "Obesity")
                                    or (x in "Morbid Obesity")
                                    or (x in "BMI Obesity")))

define InabilityToLieStill:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Immobilization"))

define PresenceOfHeadachesOrDizziness:
    First([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
            and exists(C.code.coding x where (x in "Headache")
                                    or (x in "Headache Following Trauma to Head")
                                    or (x in "New Daily Persistent Headache")))
define HeadachesOrDizziness:
    if ("PresenceOfHeadachesOrDizziness" is not null)
    then true
    else false

define HeadachesOnset:
    start of "Normalize Interval"("PresenceOfHeadachesOrDizziness".onset)

define HeadachesSeverity:
    ("PresenceOfHeadachesOrDizziness".severity.coding).display.value

define Trauma:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
            and exists(C.code.coding x where (x in "TraumaVS")
                                            or (x in "Non Penetrating Head Trauma")
                                            or (x in "Traumatic Injury")))


define AcuteHemorrhage:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
            and exists(C.code.coding x where x in "Hemorrhage"))

define StrokesEncephalomalacia:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
            and exists(C.code.coding x where (x in "Neurologic Symptoms of Stroke")
                                    or (x in "Stroke Symptoms")
                                    or (x in "Stroke transient ischemic attack")))

define Seizures:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
    and exists(C.code.coding x where x in "Seizure Disorder"))

define IntracranialLesions:
    exists([Condition: "Intracranial space-occupying lesion found on diagnostic imaging of central nervous system"])

define PacemakerDevice:
    First([DeviceRequest: "Pacemaker, other than single or dual chamber (implantable)"])

define CochlerDevice:
    First([DeviceRequest: "Cochlear device, includes all internal and external components"])

define UsageOfMetallicEquipments:
    if (("PacemakerDevice" is not null)
        or ("CochlerDevice" is not null))
    then true
    else false

define RequirementOfContrastCT:
    if ("DiagnosisForContrastCT" = true)
    then true
    else false
    
define DiagnosisForContrastCT:
    exists([Condition]C
		where First(C.clinicalStatus.coding).code.value = 'active'
            and exists(C.code.coding x where (x in "Lymphoma Diagnosis Prior to Urology Care")
                                            or ( x in "Breast Cancer")
                                            or ( x in "Lung Cancer")
                                            or (x in "Peripheral Vascular Disease")))


define function "Normalize Interval"(choice Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
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