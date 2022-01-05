library SubsequentHospitalCare version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "Chest Pain": '2.16.840.1.113883.3.6037.1001.23.93.246'
valueset "Pain in Arm, Neck, Back or Jaw": '2.16.840.1.113883.3.6037.1001.23.93.247'
valueset "ST elevation myocardial infarction (STEMI)": '2.16.840.1.113883.3.6037.1001.23.93.248'
valueset "Bypass Grafting with a Vein Only": '2.16.840.1.113883.3.6037.1001.23.93.249'
valueset "Acute Ischemia": '2.16.840.1.113883.3.6037.1001.23.93.250'
valueset "Shortness Of Breath": '2.16.840.1.113883.3.6037.1001.23.93.251'
valueset "Dizziness": '2.16.840.1.113883.3.6037.1001.23.93.252'
valueset "Nausea (ICD10CM)": '2.16.840.1.113762.1.4.1146.863'
valueset "Fatigue": '2.16.840.1.113883.3.6037.1001.23.93.253'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define "EncounterResource":
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define "EncounterPatient":
	"EncounterResource"

define Patient:
	([Patient]P with "EncounterResource" E
    		such that ('Patient/' + P.id.value) = E.subject.reference.value)

define PatientMedicaidNumber:
	"Patient".identifier.value

define DiscomformInChest:
	[Condition]C
		where exists(C.code.coding C where C in "Chest Pain")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define PainOtherAreas:
	[Condition]C
		where exists(C.code.coding C where C in "Pain in Arm, Neck, Back or Jaw")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define ShortnessOfBreath:
	[Condition]C
		where exists(C.code.coding C where C in "Shortness Of Breath")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define DizzinessCondition:
	[Condition]C
		where exists(C.code.coding C where C in "Dizziness")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define FatigueCondition:
	[Condition]C
		where exists(C.code.coding C where C in "Fatigue")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define Nausea:
	[Condition]C
		where exists(C.code.coding C where C in "Nausea (ICD10CM)")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define Symptoms:
	if exists("DiscomformInChest")
		then 'Pain/Discomfort in the chest'
			else if exists("PainOtherAreas")
				then 'Pain in Neck, Back, Arm or Jaw'
					else if exists("ShortnessOfBreath")
						then 'Shortness of Breath'
							else if exists("DizzinessCondition")
								then 'Dizziness'
									else if exists("Nausea")
										then 'Nausea'
											else if exists("FatigueCondition")
												then 'Extreme Tiredness'
													else ''

define STEMICondition:
	[Condition]C
		where exists(C.code.coding C where C in "ST elevation myocardial infarction (STEMI)")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define AcuteIschemia:
	[Condition]C
		where exists(C.code.coding C where C in "Acute Ischemia")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'

define BypassGraftingProcedure:
	[Procedure]P
		where exists(P.code.coding C where C in "Bypass Grafting with a Vein Only")
		and P.status.value = 'completed'

define ClinicalIndications:
	if exists("STEMICondition")
		then 'Elevated Cardiac Troponin Level'
			else if exists("AcuteIschemia")
				then 'ECG Changes consistent with Ischemia'
					else ''
