library BotulinumSialorrhea version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Sialorrhea Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.27'
valueset "Cerebral Palsy": '2.16.840.1.113883.3.7587.2.1012'
valueset "Parkinson’s disease (Disorders) (ICD10CM)": '2.16.840.1.113762.1.4.1146.1047'
valueset "Dental Caries": '2.16.840.1.113883.3.464.1003.125.11.1009'
valueset "Dental Conditions": '2.16.840.1.113883.3.6037.1001.23.93.45'
valueset "Adverse Effects causing Sialorrhea": '2.16.840.1.113883.3.6037.1001.23.93.46'
valueset "Biobehavioral Therapy": '2.16.840.1.113762.1.4.1034.570'
valueset "Partially successful": '2.16.840.1.113883.3.6037.1001.23.93.47'
valueset "Successful": '2.16.840.1.113883.3.6037.1001.23.93.48'
valueset "Onabotulinumtoxina": '2.16.840.1.113883.3.6037.1001.23.99.78'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'
valueset "Glycopyrrolate": '2.16.840.1.113883.3.3616.200.110.102.2067'
valueset "Scopolamine": '2.16.840.1.113883.3.464.1003.196.12.1520'
valueset "Ischemic Stroke": '2.16.840.1.113883.3.117.1.7.1.247'
valueset "Myasthenia Gravis": '2.16.840.1.113883.3.6037.1001.23.93.49'
valueset "Hyperthyroidism": '2.16.840.1.113883.3.464.1003.117.11.1031'
valueset "Glaucoma": '2.16.840.1.113883.3.526.2.1561'
valueset "Benign Prostatic Hyperplasia": '1.2.91.13925.17760.4352590'
valueset "Hypertension": '2.16.840.1.113762.1.4.1029.330'
valueset "Urinary Tract Blockage": '2.16.840.1.113883.3.6037.1001.23.93.50'
valueset "Tachycardia (ICD10CM)": '2.16.840.1.113762.1.4.1146.1238'
valueset "Heart Failure": '2.16.840.1.113762.1.4.1200.123'
valueset "Dry Mouth": '2.16.840.1.113883.3.6037.1001.23.93.51'
valueset "Hiatal Hernia": '2.16.840.1.113883.3.6037.1001.23.93.52'
valueset "Constipation": '2.16.840.1.113883.3.6037.1001.23.93.53'
valueset "Down’s Syndrome": '2.16.840.1.113883.3.6037.1001.23.93.54'
valueset "Allergy to Clostridium Botulinum": '2.16.840.1.113883.3.6037.1001.23.93.55'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "Botulinum Toxin Type A (BoNT A) Injection (RXNORM)": '2.16.840.1.113762.1.4.1034.433'


parameter "MedicationRequest" MedicationRequest

context Patient

define Sialorrhea:
	[Condition]S
		where exists(S.code.coding C where C in "Sialorrhea Diagnosis Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define SpecifySialorrheaCondition:
	First("Sialorrhea".code.coding).display.value

define CerebralPalsy:
	[Condition]C
    where exists(C.code.coding C where C in "Cerebral Palsy")
            and First(C.clinicalStatus.coding).code.value = 'active'
			        and First(C.verificationStatus.coding).code.value = 'confirmed'

define ParkinsonDisease:
	[Condition]C
    where exists(C.code.coding C where C in "Parkinson’s disease (Disorders) (ICD10CM)")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define IschemicStroke:
	[Condition]C
    where exists(C.code.coding C where C in "Ischemic Stroke")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define NeuromuscularSensoryDysfunction:
  if exists("CerebralPalsy")
			or exists("ParkinsonDisease")
				or exists("IschemicStroke")
    			then true
      			else false

define DentalCaries:
  [Condition]C
    where exists(C.code.coding C where C in "Dental Caries")
            and First(C.clinicalStatus.coding).code.value = 'active'
			        and First(C.verificationStatus.coding).code.value = 'confirmed'

define DentalConditions:
	[Condition]C
    where exists(C.code.coding C where C in "Dental Conditions")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define LocalFactors:
  if exists("DentalCaries")
			or exists("DentalConditions")
    		then true
      		else false

define AdverseEffectSialorrhea:
		[AdverseEvent]A
					where A.actuality in {'actual', 'potential'}
      			and First((A.event as CodeableConcept).coding) in "Adverse Effects causing Sialorrhea"


define CheckAdverseEffectSialorrhea:
	"Sialorrhea" S
		with "AdverseEffectSialorrhea" A
			such that exists(A.resultingCondition r where r.reference.value = 'Condition/'+S.id.value)

define AdverseEffect:
  if exists("CheckAdverseEffectSialorrhea")
    then true
      else false

define BiofeedbackTherapyProcedure:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "Biobehavioral Therapy")

define BiofeedbackTherapy:
  if exists("BiofeedbackTherapyProcedure")
    then true
      else false

define BiofeedbackOutcome:
  "BiofeedbackTherapyProcedure" P
		where (First(P.outcome.coding) in "Successful"
            or First(P.outcome.coding) in "Partially successful")

define PostBiofeedbackImprovement:
  if exists("BiofeedbackOutcome")
    then true
      else false

define "MedicationAdministrationResources":
		[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Botulinum Toxin Type A (BoNT A) Injection (RXNORM)"

define "MedicationResources":
	[Medication]med where (First(med.code.coding) in "Botulinum Toxin Type A (BoNT A) Injection (RXNORM)") is not null

define "ProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define "CheckBotoxAdministration":
	"MedicationAdministrationResources" M
	with "ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)


define "EarlierBotulinumAdministration":
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define "PostBotoxImprovement":
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

define "GlycopyrrolateDrugResources":
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Glycopyrrolate"

define "GlycopyrrolateMedicationResources":
	[Medication]med where (First(med.code.coding) in "Glycopyrrolate") is not null

define "GlycopyrrolateProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define "CheckGlycopyrrolateAdministration":
	"GlycopyrrolateDrugResources" M
	with "GlycopyrrolateProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)


define "GlycopyrrolateMedication":
  if Last("CheckGlycopyrrolateAdministration") is not null
	then true
	else false

define "PostGlycopyrrolateImprovement":
	if exists("GlycopyrrolateDrugResources" M
							with "GlycopyrrolateProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and Last(P.outcome.coding) in "Unsuccessful")
					then false
						else true

define "ScopolamineDrugResources":
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Scopolamine"

define "ScopolamineMedicationResources":
	[Medication]med where (First(med.code.coding) in "Scopolamine") is not null

define "ScopolamineProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define "CheckScopolamineAdministration":
	"ScopolamineDrugResources" M
	with "ScopolamineProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)


define "ScopolamineMedication":
  if Last("CheckScopolamineAdministration") is not null
	then true
	else false

define "PostScopolamineImprovement":
	if exists("ScopolamineDrugResources" M
							with "ScopolamineProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and Last(P.outcome.coding) in "Unsuccessful")
					then false
						else true

define MyastheniaGravis:
	[Condition]S
		where exists(S.code.coding C where C in "Myasthenia Gravis")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define "HyperthyroidismCondition":
  [Condition]S
		where exists(S.code.coding C where C in "Hyperthyroidism")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define GlaucomaCondition:
  [Condition]S
		where exists(S.code.coding C where C in "Glaucoma")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define BenignProstaticHyperplasia:
  [Condition]S
		where exists(S.code.coding C where C in "Benign Prostatic Hyperplasia")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define HypertensionCondition:
  [Condition]S
		where exists(S.code.coding C where C in "Hypertension")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define UrinaryTractBlockage:
  [Condition]S
		where exists(S.code.coding C where C in "Urinary Tract Blockage")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define Tachycardia:
  [Condition]S
		where exists(S.code.coding C where C in "Tachycardia (ICD10CM)")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define HeartFailure:
  [Condition]S
		where exists(S.code.coding C where C in "Heart Failure")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define DryMouth:
  [Condition]S
		where exists(S.code.coding C where C in "Dry Mouth")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define HiatalHernia:
  [Condition]S
		where exists(S.code.coding C where C in "Hiatal Hernia")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define ConstipationCondition:
  [Condition]S
		where exists(S.code.coding C where C in "Constipation")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define DownSyndrome:
  [Condition]S
		where exists(S.code.coding C where C in "Down’s Syndrome")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define AnticholinergicContraindications:
	if exists("MyastheniaGravis")
		then 'Myasthenia Gravis'
			else if exists("HyperthyroidismCondition")
				then 'Hyperthyroidism'
					else if exists("GlaucomaCondition")
						then 'Glaucoma'
							else if exists("BenignProstaticHyperplasia")
								then 'Enlarged Prostate'
									else if exists("HypertensionCondition")
										then 'Hypertension'
											else if exists("UrinaryTractBlockage")
												then 'Urinary Tract Blockage'
													else if exists("Tachycardia")
														then 'Tachycardia'
															else if exists("HeartFailure")
																then 'Heart Failure'
																	else if exists("DryMouth")
																		then 'Dry Mouth'
																			else if exists("HiatalHernia")
																				then 'Hiatal Hernia'
																					else if exists("ConstipationCondition")
																						then 'Constipation'
																							else if exists("DownSyndrome")
																								then 'Down’s Syndrome'
																									else ''

define BotoxAllergyIntolerance:
	exists([AllergyIntolerance]A
		where First(A.clinicalStatus.coding).code.value = 'active'
    and exists(A.code.coding x where x in "Allergy to Clostridium Botulinum"))

define BotoxAllergy:
	if ("BotoxAllergyIntolerance"  is true)
	then true
	else false

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