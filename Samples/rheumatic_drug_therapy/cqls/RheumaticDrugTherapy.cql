library RheumaticDrugTherapy version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'
codesystem "RXNORM" : 'http://www.nlm.nih.gov/research/umls/rxnorm'

valueset "Psoriatic Arthritis": '2.16.840.1.113883.3.464.1003.113.11.1093'
valueset "Rheumatoid Arthritis (Ra)": '2.16.840.1.113762.1.4.1222.649'
valueset "Ankylosing Spondylitis": '2.16.840.1.113883.3.464.1003.113.11.1090'
valueset "Plaque Psoriasis": '2.16.840.1.113883.3.6037.1001.23.93.239'
valueset "Rheumatoid Factor Test": '2.16.840.1.113883.3.6037.1001.23.93.240'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Negative Result": '2.16.840.1.113762.1.4.1116.292'
valueset "Anti CCP Test": '2.16.840.1.113883.3.6037.1001.23.93.241'
valueset "DMARD Therapy": '2.16.840.1.113883.3.6037.1001.23.93.242'
valueset "Partially successful": '2.16.840.1.113883.3.6037.1001.23.93.47'
valueset "Successful": '2.16.840.1.113883.3.6037.1001.23.93.48'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'
valueset "NSAID Therapy": '2.16.840.1.113883.3.6037.1001.23.93.243'
valueset "Biologic Drugs": '2.16.840.1.113883.3.6037.1001.23.93.244'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "Genital Herpes": '2.16.840.1.113883.3.464.1003.110.11.1123'
valueset "Hepatitis A (Disorders) (ICD10CM)": '2.16.840.1.113762.1.4.1146.94'
valueset "Hepatitis B": '2.16.840.1.113883.3.464.1003.110.11.1073'
valueset "Chronic Obstructive Pulmonary Diseases": '2.16.840.1.113883.17.4077.3.2063'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define Request:
	"ServiceRequest"

define PsoriaticArthritisCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Psoriatic Arthritis")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define PsoriaticArthritis:
	if exists("PsoriaticArthritisCondition")
		then true
			else false

define RheumatoidArthritisCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Rheumatoid Arthritis (Ra)")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and First(C.severity.coding).display.value in {'Severe', 'Moderate'}

define RheumatoidArthritis:
	if exists("RheumatoidArthritisCondition")
		then true
			else false

define AnkylosingSpondylitisCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Ankylosing Spondylitis")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and First(C.severity.coding).display.value in {'Severe', 'Moderate'}

define AnkylosingSpondylitis:
	if exists("AnkylosingSpondylitisCondition")
		then true
			else false

define PlaquePsoriasisCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Plaque Psoriasis")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
					and First(C.severity.coding).display.value = 'Severe'

define PlaquePsoriasis:
	if exists("PlaquePsoriasisCondition")
		then true
			else false

define RheumatoidFactorTest:
  exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Rheumatoid Factor Test"))

define RheumatoidFactorTestPositive:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Rheumatoid Factor Test")
			and (P.value as CodeableConcept) in "Positive"

define RheumatoidFactorTestNegative:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Rheumatoid Factor Test")
			and (P.value as CodeableConcept) in "Negative Result"

define RheumatoidFactorTestResult:
	if exists("RheumatoidFactorTestPositive")
		then true
			else if exists("RheumatoidFactorTestNegative")
				then false
					else null

define AntiCCPTest:
  exists([Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Anti CCP Test"))

define AntiCCPTestTestPositive:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Anti CCP Test")
			and (P.value as CodeableConcept) in "Positive"

define AntiCCPTestTestNegative:
	[Observation]P
			where P.status.value in {'final', 'amended', 'corrected'}
			and exists(P.code.coding x where x in "Anti CCP Test")
			and (P.value as CodeableConcept) in "Negative Result"

define AntiCCPTestResult:
	if exists("AntiCCPTestTestPositive")
		then true
			else if exists("AntiCCPTestTestNegative")
				then false
					else null

define PastConventionalDMARDTherapyProcedure:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "DMARD Therapy")

define PastConventionalDMARDTherapy:
	if exists("PastConventionalDMARDTherapyProcedure")
		then true
			else null

define PastConventionalDMARDTherapyDurationProc:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "DMARD Therapy")

define PastConventionalDMARDTherapyDuration:
	if exists("PastConventionalDMARDTherapyDurationProc")
		then true
			else null

define ConventionalDMARDTherapySuccessfulOutcome:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "DMARD Therapy")
				and "LengthInDays"("Normalize Interval Procedure"(P.performed)) > 90 days
					and (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful")

define ConventionalDMARDTherapyUnsuccessfulOutcome:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "DMARD Therapy")
				and (First(P.outcome.coding) in "Unsuccessful")


define PastConventionalDMARDTherapyOutcome:
	if exists("ConventionalDMARDTherapySuccessfulOutcome")
		then true
			else if exists("ConventionalDMARDTherapyUnsuccessfulOutcome")
				then false
					else null

define ContraindicationDMARDTherapyProc:
	[Procedure]P
		where P.status.value in {'stopped','not-done'}
			and exists(P.code.coding C where C in "DMARD Therapy")

define ContraindicationDMARDTherapy:
	if exists("ContraindicationDMARDTherapyProc")
		then true
			else null

define PastConventionalNSAIDTherapyProc:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "NSAID Therapy")

define PastConventionalNSAIDTherapy:
	if exists("PastConventionalNSAIDTherapyProc")
		then true
			else null

define NSAIDTherapySuccessfulOutcome:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "NSAID Therapy")
				and (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful")

define NSAIDTherapyUnsuccessfulOutcome:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "NSAID Therapy")
				and (First(P.outcome.coding) in "Unsuccessful")

define PastConventionalNSAIDTherapyOutcome:
	if exists("NSAIDTherapySuccessfulOutcome")
		then true
			else if exists("NSAIDTherapyUnsuccessfulOutcome")
				then false
					else null

define ContraindicationNSAIDTherapyProc:
	[Procedure]P
		where P.status.value in {'stopped','not-done'}
			and exists(P.code.coding C where C in "NSAID Therapy")

define NSAIDContraindication:
	if exists("ContraindicationNSAIDTherapyProc")
		then true
			else null

define BiologicMedicalAdministration:
	[MedicationAdministration]M
		where M.subject.reference.value = 'Patient/'+ Patient.id.value
			and M.status.value = 'completed'
				and First((M.medication as CodeableConcept).coding) in "Biologic Drugs"

define BiologicDrugProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'completed', 'in-progress'}
		and (First(P.code.coding) in "Procedure for Medication Administration")

define CheckBiologicMedicalAdministration:
	"BiologicMedicalAdministration" M
		with "BiologicDrugProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define PreviousBiologicDrugs:
	if Last("CheckBiologicMedicalAdministration") is not null
		then true
			else false

define PostBiologicSuccessfulOutcome:
	exists("BiologicMedicalAdministration" M
							with "BiologicDrugProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and (First(P.outcome.coding) in "Successful" or First(P.outcome.coding) in "Partially successful"))

define PostBiologicUnsuccessfulOutcome:
	exists("BiologicMedicalAdministration" M
							with "BiologicDrugProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")

define BiologicOutcome:
	if ("PostBiologicSuccessfulOutcome" = true)
		then true
			else if ("PostBiologicUnsuccessfulOutcome" = true)
				then false
					else null

define CombinationOtherDrugs:
	exists([Procedure]P
		where P.status.value = 'in-progress'
			and (exists(P.code.coding C where C in "NSAID Therapy")
						or exists(P.code.coding C where C in "DMARD Therapy")))

define Herpes:
	[Condition]C
    where exists(C.code.coding C where C in "Genital Herpes")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define Hepatitis:
	[Condition]C
    where (exists(C.code.coding C where C in "Hepatitis A (Disorders) (ICD10CM)")
						or exists(C.code.coding C where C in "Hepatitis B"))
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define BacterialFungalInfections:
	if (exists("Herpes")
			or exists("Hepatitis"))
				then true
					else false

define COPD:
	exists([Condition]C
    where exists(C.code.coding C where C in "Chronic Obstructive Pulmonary Diseases")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed')

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

define function "LengthInDays"(Value Interval<DateTime>):
	difference in days between start of Value and end of Value
