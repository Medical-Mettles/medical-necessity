library HomeOxygenTherapy version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD10CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "SNOMEDCT": '2.16.840.1.113883.6.96'
codesystem "LOINC": 'http://loinc.org'
codesystem "NUCCPT" : '2.16.840.1.113883.6.101'
codesystem "ActRelationshipType" : '2.16.840.1.113883.5.1002'
codesystem "HCPCS": '2.16.840.1.113883.6.285'

valueset "Chronic Obstructive Lung Disease (COPD) ICD10CM": '2.16.840.1.113762.1.4.1219.4'
valueset "Cystic Fibrosis": '2.16.840.1.113883.3.464.1003.102.12.1002'
valueset "Interstitial lung disease": '2.16.840.1.113883.3.666.5.777'
valueset "Bronchiectasis": '2.16.840.1.113883.3.666.5.773'
valueset "Home Oxygen Therapy Qualifying Conditions": '2.16.840.1.113762.1.4.1219.25'
valueset "Malignant Neoplasm of Respiratory and Intrathoracic Organs": '2.16.840.1.113883.3.464.1003.108.11.1012'
valueset "Mild cognitive impairment": '2.16.840.1.113762.1.4.1108.9'
valueset "Hypoxemia": '2.16.840.1.113762.1.4.1111.55'
valueset "Hematocrit": '2.16.840.1.113762.1.4.1222.143'
valueset "Face to Face Encounter": '2.16.840.1.113762.1.4.1047.428'
valueset "Inpatient Stay": '2.16.840.1.113762.1.4.1182.285'


code "Inhaled oxygen flow rate": '3151-8' from "LOINC" display 'Inhaled oxygen flow rate'
code "Oxygen [Partial pressure] adjusted to patients actual temperature in Arterial blood": '19255-9' from "LOINC" display 'Oxygen [Partial pressure] adjusted to patients actual temperature in Arterial blood'

code "Oxygen saturation in Arterial blood by Pulse oximetry --W exercise": '89276-0' from "LOINC" display 'Oxygen saturation in Arterial blood by Pulse oximetry --W exercise'
code "Oxygen saturation in Arterial blood by Pulse oximetry --on room air": '59410-1' from "LOINC" display 'Oxygen saturation in Arterial blood by Pulse oximetry --on room air'
code "Oxygen saturation in Arterial blood by Pulse oximetry --resting": '59417-6' from "LOINC" display 'Oxygen saturation in Arterial blood by Pulse oximetry --resting'
code "Oxygen saturation in Arterial blood by Pulse oximetry": '59408-5' from"LOINC" display 'Oxygen saturation in Arterial blood by Pulse oximetry'

code "Oxygen saturation in Arterial blood": '2708-6' from "LOINC" display 'Oxygen saturation in Arterial blood'
code "Oxygen [Partial pressure] in Arterial blood": '2703-7' from "LOINC" display 'Oxygen [Partial pressure] in Arterial blood'
code "Bicarbonate [Moles/volume] in Arterial blood": '1960-4' from "LOINC" display 'Bicarbonate [Moles/volume] in Arterial blood'
code "Carbon dioxide [Partial pressure] in Arterial blood": '2019-8' from "LOINC" display 'Carbon dioxide [Partial pressure] in Arterial blood'
code "pH of Arterial blood": '2744-1' from "LOINC" display 'pH of Arterial blood'
code "Hematocrit [Volume Fraction] of Arterial blood": '32354-3' from "LOINC" display 'Hematocrit [Volume Fraction] of Arterial blood'
	
code "Overnight pulse oximetry (procedure)": '252568001' from "SNOMEDCT" display 'Overnight pulse oximetry (procedure)'

code "Blood gas analysis (procedure)": '278297009' from "SNOMEDCT" display 'Blood gas analysis (procedure)'
code "Blood gas measurement (procedure)": '167018008' from "SNOMEDCT" display 'Blood gas measurement (procedure)'
code "6-minute walk test (procedure)": '252478000' from "SNOMEDCT" display '6-minute walk test (procedure)'

code "Walks indoors - usual functional ability during assessment period [CMS Assessment]": '94996-6' from "SNOMEDCT" display 'Walks indoors - usual functional ability during assessment period [CMS Assessment]'
code "Angina pectoris, unspecified": 'I20.9' from "ICD10CM" display 'Angina pectoris, unspecified'
code "Cystic fibrosis with pulmonary manifestations": 'J84' from "ICD10CM" display 'Cystic fibrosis with pulmonary manifestations'
code "Pulmonary hypertension, unspecified" : 'I27.20' from "ICD10CM" display 'Pulmonary hypertension, unspecified'
code "Congestive heart failure (disorder)": '42343007' from "SNOMEDCT" display 'Congestive heart failure (disorder)'
code "Cor pulmonale (chronic)" : 'I27.81' from "ICD10CM" display 'Cor pulmonale (chronic)'
code "Familial erythrocytosis" : 'D75.0' from "ICD10CM" display 'Familial erythrocytosis'
code "Restlessness and agitation":'R45.1' from "ICD10CM" display 'Restlessness and agitation'
code "Morning headache (finding)" : '162310002' from  "SNOMEDCT" display 'Morning headache (finding)'
code "Dependent edema (finding)": '248499004' from "SNOMEDCT" display 'Dependent edema (finding)'
code "Pulmonary artery pressure monitoring (regime/therapy)": '24599003' from "SNOMEDCT" display 'Pulmonary artery pressure monitoring (regime/therapy)'
code "NM Heart Gated and Blood pool and Ejection fraction and Wall motion W single state of exercise": '81567-0' from "LOINC" display 'NM Heart Gated and Blood pool and Ejection fraction and Wall motion W single state of exercise'
code "Echocardiography (procedure)": '40701008' from "SNOMEDCT" display 'Echocardiography (procedure)'
code "P pulmonale (finding)": '164914003' from "SNOMEDCT" display 'P pulmonale (finding)'
code "Treatment stopped - alternative therapy undertaken (situation) code": '182868002' from "SNOMEDCT" display 'Treatment stopped - alternative therapy undertaken (situation)'
code "Polysomnography (procedure)": '60554003' from "SNOMEDCT" display 'Polysomnography (procedure)'
code "Cardiopulmonary exercise test (procedure)": '447346005' from "SNOMEDCT" display 'Cardiopulmonary exercise test (procedure)'
code "Secondary polycythemia": 'D75.1' from "ICD10CM" display 'Secondary polycythemia'
code "Age-related physical debility": 'R54' from "ICD10CM" display 'Age-related physical debility'
code "Breathless - mild exertion (finding)": '161940008' from "SNOMEDCT" display 'Breathless - mild exertion (finding)'
code "Peripheral vascular disease (disorder)": '400047006' from "SNOMEDCT" display 'Peripheral vascular disease (disorder)'
code "Desaturation of blood (disorder)": '238159008' from "SNOMEDCT" display 'Desaturation of blood (disorder)'
code "E0433": 'E0433' from "HCPCS"
code "E0434": 'E0434' from "HCPCS"
code "E0444": 'E0444' from "HCPCS"
code "E0431": 'E0431' from "HCPCS"
code "K0738": 'K0738' from "HCPCS"
code "E0443": 'E0443' from "HCPCS"
code "E1392": 'E1392' from "HCPCS"
code "E0439": 'E0439' from "HCPCS"
code "E0442": 'E0442' from "HCPCS"
code "E0424": 'E0424' from "HCPCS"
code "E0441": 'E0441' from "HCPCS"
code "E1390": 'E1390' from "HCPCS"
code "E1391": 'E1391' from "HCPCS"

//Immobilization_Codes
code "102491009": '102491009' from "SNOMEDCT"
code "129857008": '129857008' from "SNOMEDCT"
code "129859006": '129859006' from "SNOMEDCT"
code "160685001": '160685001' from "SNOMEDCT"
code "371632003": '371632003' from "SNOMEDCT"
code "8510008": '8510008' from "SNOMEDCT"

parameter "ServiceRequest" ServiceRequest
parameter "DeviceRequest" DeviceRequest

context Patient



define "DeviceRequestResource":
	"DeviceRequest"

define "CertificationDate":
	"DeviceRequest".authoredOn

define EncounterResource: 
	singleton from([Encounter]E where 'Encounter/' + E.id.value = Coalesce("DeviceRequest".encounter, "ServiceRequest".encounter).reference.value )

define function "EncounterDiagnosis"(Encounter Encounter):
  	Encounter.diagnosis D
  	return singleton from ([Condition]C where C.id.value = "GetId"(D.condition.reference.value))

define EncounterCondition:
    "EncounterDiagnosis"("EncounterResource")

define function "EncounterPractitioner"(Encounter Encounter):
	Encounter.participant PR
	return singleton from ([Practitioner]P where 'Practitioner/' + P.id.value = PR.individual.reference.value)

define "FaceToFaceEncounter":
	"EncounterResource" F2FEncounter
	where First(F2FEncounter.type) in "Face to Face Encounter"
	and First(F2FEncounter.participant).individual.type = 'http://hl7.org/fhir/StructureDefinition/Practitioner'
	and (First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code = 'MD'
		or First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code = 'NP'
		or First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code = 'CNS'
		or First("EncounterPractitioner"(F2FEncounter).qualification.code.coding).code = 'PA')

define function ToCode(coding FHIR.Coding):
    if coding is null then
        null
    else
        System.Code {
          code: coding.code.value,
          system: coding.system.value,
          version: coding.version.value,
          display: coding.display.value
        }

define "BloodGasStudy":
	(([Procedure]P
		where P.status.value = 'completed'
		and ("ToCode"(First(P.code.coding)) = "Blood gas analysis (procedure)"
				or "ToCode"(First(P.code.coding)) = "Blood gas measurement (procedure)")
		and "Normalize Interval"(P.performed) starts 2 days before end of "Normalize Interval"("FaceToFaceEncounter".period)
		and "FaceToFaceEncounter".serviceType in "Inpatient Stay")
	union
	([Procedure]P
		where P.status.value = 'completed'
		and ("ToCode"(First(P.code.coding)) = "Blood gas analysis (procedure)"
				or "ToCode"(First(P.code.coding)) = "Blood gas measurement (procedure)")
		and start of "Normalize Interval"(P.performed) in Interval["CertificationDate" , "CertificationDate"+30 days]
		and "FaceToFaceEncounter".serviceType in "Inpatient Stay"))

define BloodGasStudyDate:
	start of "Normalize Interval"(Last("BloodGasStudy").performed)

define BloodGasStudyPH:
	[Observation]O
		where "ToCode"(First(O.code.coding)) = "pH of Arterial blood"
	return FHIRHelpers.ToQuantity(O.value)

define BloodGasStudyPaCO2:
	[Observation]O
		where "ToCode"(First(O.code.coding)) = "Carbon dioxide [Partial pressure] in Arterial blood"
	return FHIRHelpers.ToQuantity(O.value) 

define BloodGasStudyO2Sat:
	[Observation]O
		where "ToCode"(First(O.code.coding)) = "Oxygen saturation in Arterial blood"
	return FHIRHelpers.ToQuantity(O.value)

define BloodGasStudyHCO3:
	[Observation]O
		where "ToCode"(First(O.code.coding)) = "Bicarbonate [Moles/volume] in Arterial blood"
	return FHIRHelpers.ToQuantity(O.value)

define BloodGasStudyHematocrit:
	[Observation]O
		where "ToCode"(First(O.code.coding)) = "Hematocrit [Volume Fraction] of Arterial blood"
	return FHIRHelpers.ToQuantity(O.value)

define BloodGasStudyPaO2:
	[Observation]O
		where "ToCode"(First(O.code.coding)) = "Oxygen [Partial pressure] in Arterial blood"
	return FHIRHelpers.ToQuantity(O.value)


define "Hematocrit_lab_test_Codes": { '20570-8', '31100-1', '32354-3', '41654-5', '41655-2', '4544-3', '4545-0', '71829-6', '71830-4', '71832-0', '71833-8' }

// Other codes
define "Immobilization_Codes": { '102491009', '129857008', '129859006', '160685001', '371632003', '8510008' }

define function "GetId"(uri String):
	Last(Split(uri, '/'))

define Covered:
	("EncounterCondition" C
		where First(C.code.coding) in "Interstitial lung disease"
			or First(C.code.coding) in "Chronic Obstructive Lung Disease (COPD) ICD10CM"
			or First(C.code.coding) in "Cystic Fibrosis"
			or First(C.code.coding) in "Bronchiectasis"
			or First(C.code.coding) in "Malignant Neoplasm of Respiratory and Intrathoracic Organs"
			or First(C.code.coding) =  "Pulmonary hypertension, unspecified"
			or First(C.code.coding) in "Home Oxygen Therapy Qualifying Conditions")Covered
			 where Covered.clinicalStatus.coding[0].code.value = 'active'
   				
define ArterialOxygenSaturation:
	(First([Observation] P
		where First(P.code.coding) = "Oxygen saturation in Arterial blood by Pulse oximetry"))O
			return FHIRHelpers.ToQuantity(O.value)
			
define ArterialPartialPressureExercise: 
	(First([Observation] P 
		where First(P.code.coding) = "Oxygen [Partial pressure] adjusted to patients actual temperature in Arterial blood"))O
		return FHIRHelpers.ToQuantity(O.value)
		
define ArterialPartialPressureOfOxygen: 
	(First([Observation] P 
		where First(P.code.coding) =  "Oxygen [Partial pressure] in Arterial blood"))O
		return FHIRHelpers.ToQuantity(O.value)
		
define ArterialOxygenSaturationExercise:
	(First([Observation] P 
		where First(P.code.coding) = "Oxygen saturation in Arterial blood by Pulse oximetry --W exercise"))O
		return FHIRHelpers.ToQuantity(O.value)

define ArterialOxygenSaturationExerciseWithOxygen:
	(First([Observation] P 
		where First(P.code.coding) = "6-minute walk test (procedure)"))O
		return FHIRHelpers.ToQuantity(O.value)
		
define PulseOximetryO2:
	(First([Observation] P 
		where First(P.code.coding) = "Overnight pulse oximetry (procedure)"))O
		return FHIRHelpers.ToQuantity(O.value)

define TestingDate:
	(First([Observation] P
		where First(P.code.coding) = "Oxygen saturation in Arterial blood by Pulse oximetry"))O
			return (O.effective as dateTime).value
		
define PatientMobile: 
	exists([Observation] P 
		where First(P.code.coding) = "Walks indoors - usual functional ability during assessment period [CMS Assessment]")

define InhaledFlowRate:
	(First([Observation] P 
		where First(P.code.coding) = "Inhaled oxygen flow rate"))O
		return FHIRHelpers.ToQuantity(O.value).value

define PatientDiagnoses:
		if exists([Condition] P
					where exists(P.code.coding P
						where P in "Chronic Obstructive Lung Disease (COPD) ICD10CM"))
			then 'COPD'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Bronchiectasis"))
			then 'Bronchiectasis'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Hypoxemia"))
			then 'Hypoxemia'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Interstitial lung disease"))
			then 'Diffuse interstitial lung disease'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Cystic Fibrosis"))
			then 'Cystic Fibrosis'
		else if exists([Condition] P
					where exists(P.code.coding P
						where P in "Malignant Neoplasm of Respiratory and Intrathoracic Organs"))
			then 'Pulmonary neoplasm'
		else if exists([Condition] P
					where "ToCode"(First(P.code.coding)) = "Familial erythrocytosis")
			then 'Erythrocytosis'
		else if exists([Condition] P
					where "ToCode"(First(P.code.coding)) = "Cor pulmonale (chronic)")
			then 'Pulmonary hypertension'
		else if exists([Condition] P
					where "ToCode"(First(P.code.coding)) = "Congestive heart failure (disorder)")
			then 'Recurring CHF d/t Cor Pulmonale'
		else ''




	

define HematocritThatIsGreaterThanThreshold: 
	FHIRHelpers.ToQuantity(singleton from([Observation] P where First(P.code.coding).code.value in "Hematocrit_lab_test_Codes").value).value 
	
define PatientHasHematocritThatIsGreaterThanThreshold: 
	if ("HematocritThatIsGreaterThanThreshold" >56)
	then true else false

define DeviceRequestDescription: 'HCPCS ' + First("DeviceRequest".code.coding).code.value + ' - ' + First("DeviceRequest".code.coding).display.value

define DeviceRequestedIsPortable: First("DeviceRequest".code.coding).code.value in { 'E0433', 'E0434', 'E0444', 'EO431', 'K0738', 'E0443', 'E1392' }

define DeviceRequestedIsStationary: First("DeviceRequest".code.coding).code.value in { 'E0439', 'E0442', 'E0424', 'E0441', 'E1390', 'E1391' }

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null
		





