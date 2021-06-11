library BotulinumUrinaryIncontinence version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'


//Valuesets for Spasticity
valueset "Spasticity Condition Codes": '2.16.840.1.113883.3.6037.1001.23.93.72'
valueset "Ischemic Stroke": '2.16.840.1.113883.3.117.1.7.1.247'
valueset "Multiple Sclerosis (ICD10CM)": '2.16.840.1.113762.1.4.1034.99'
valueset "Brain Injury": '2.16.840.1.113883.3.7587.2.1015'
valueset "Cerebral Palsy": '2.16.840.1.113883.3.7587.2.1012'
valueset "RehabilitationServices": '2.16.840.1.113883.3.117.1.7.1.221'
valueset "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral": '2.16.840.1.113883.3.6037.1001.23.99.41'
valueset "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral": '2.16.840.1.113883.3.6037.1001.23.99.47'
valueset "Chemodenervation of Neck Muscle(s)": '2.16.840.1.113883.3.6037.1001.23.93.73'
valueset "Chemodenervation of Larynx Muscle(s)": '2.16.840.1.113883.3.6037.1001.23.93.74'
valueset "Laryngoscopy Codes": '2.16.840.1.113883.3.6037.1001.23.93.80'
valueset "Chemodenervation Of Trunk Muscle(S); 1-5 Muscle(S)": '2.16.840.1.113883.3.6037.1001.23.93.75'
valueset "Chemodenervation Of Trunk Muscle(S); 6 Or More Muscles": '2.16.840.1.113883.3.6037.1001.23.93.78'
valueset "Chemodenervation Of One Extremity; 1-4 Muscle(S)": '2.16.840.1.113883.3.6037.1001.23.93.76'
valueset "Chemodenervation Of One Extremity; 5 Or More Muscles": '2.16.840.1.113883.3.6037.1001.23.93.77'
valueset "Chemodenervation of Extraocular Muscle": '2.16.840.1.113883.3.6037.1001.23.99.45'

//Valuesets for Blepharospasm
valueset "Blepharospasm Condition Codes": '2.16.840.1.113883.3.6037.1001.23.93.79'
valueset "Abnormal Involuntary Movements": '2.16.840.1.113883.3.6037.1001.23.93.57'
valueset "Keratopathy": '2.16.840.1.113883.3.6037.1001.23.93.58'
valueset "Disorder of Eye": '2.16.840.1.113883.3.6037.1001.23.93.59'

//Valuesets for Sialorrhea
valueset "Sialorrhea Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.27'
valueset "Parkinson’s disease (Disorders) (ICD10CM)": '2.16.840.1.113762.1.4.1146.1047'
valueset "Dental Caries": '2.16.840.1.113883.3.464.1003.125.11.1009'
valueset "Dental Conditions": '2.16.840.1.113883.3.6037.1001.23.93.45'
valueset "Adverse Effects causing Sialorrhea": '2.16.840.1.113883.3.6037.1001.23.93.46'
valueset "Biobehavioral Therapy": '2.16.840.1.113762.1.4.1034.570'
valueset "Partially successful": '2.16.840.1.113883.3.6037.1001.23.93.47'
valueset "Successful": '2.16.840.1.113883.3.6037.1001.23.93.48'
valueset "Glycopyrrolate": '2.16.840.1.113883.3.3616.200.110.102.2067'
valueset "Scopolamine": '2.16.840.1.113883.3.464.1003.196.12.1520'

//Valuesets for Achalasia
valueset "Esophagoscopy Codes": '2.16.840.1.113883.3.6037.1001.23.99.28'
valueset "Hypertensive LOS": '2.16.840.1.113883.3.6037.1001.23.93.61'
valueset "Malnutrition": '2.16.840.1.113883.3.6037.1001.23.93.62'
valueset "Oesophageal Biopsy": '2.16.840.1.113883.3.6037.1001.23.93.63'
valueset "Esophagus Disease Codes": '2.16.840.1.113883.3.6037.1001.23.93.64'
valueset "Epiphrenic Diverticulum": '2.16.840.1.113883.3.6037.1001.23.93.65'
valueset "Pneumatic Dilation": '2.16.840.1.113883.3.6037.1001.23.93.66'
valueset "Surgical Myotomy Codes": '2.16.840.1.113883.3.6037.1001.23.93.67'

//Valuesets for Anal Fissure
valueset "AnalFissure Codes": '2.16.840.1.113883.3.6037.1001.23.99.29'
valueset "Fiber Supplements RXNORM Codes": '2.16.840.1.113883.3.6037.1001.23.93.68'
valueset "Stool softeners and laxatives": '2.16.840.1.113762.1.4.1032.44'
valueset "Sitz Bath": '2.16.840.1.113883.3.6037.1001.23.93.69'
valueset "Topical Anaesthetic Application": '2.16.840.1.113883.3.6037.1001.23.93.70'

//Valuesets for Hyperhydrosis
valueset "Hyperhidrosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.34'
valueset "Generalised Hyperhidrosis": '2.16.840.1.113883.3.6037.1001.23.93.71'
valueset "Anticholinergic Medications": '2.16.840.1.113762.1.4.1034.127'

//Valuesets for Urinary Incontinence
valueset "Cystourethroscopy Codes": '2.16.840.1.113883.3.6037.1001.23.99.30'

//Valuesets for Prior Botox Administration
valueset "Botulinum Toxin RXNORM Codes": '2.16.840.1.113883.3.6037.1001.23.93.60'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'

//Valuesets for Comorbidities - Sialorrhea and Urinary Incontinence
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

//Valuesets for Botox Allergy
valueset "Allergy to Clostridium Botulinum": '2.16.840.1.113883.3.6037.1001.23.93.55'

//Valuesets for Botulinum Conditions (Questions yet be added)


parameter "ServiceRequest" ServiceRequest

context Patient

//BOTULINUM CONDITIONS
define SpasticityCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Spasticity Condition Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define BlepharospasmCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Blepharospasm Condition Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define AchalasiaCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Esophagoscopy Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define AnalFissureCondition:
	[Condition]S
		where exists(S.code.coding C where C in "AnalFissure Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define HyperhidrosisCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Hyperhidrosis Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define SialorrheaCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Sialorrhea Diagnosis Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define UrinaryIncontinenceCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Cystourethroscopy Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

/*define MigraineConditon:
	[Condition]S
		where exists(S.code.coding C where C in "Migraine Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'*/

define BotoxDiagnosisConditions:
	if exists("AchalasiaCondition")
		then 'Achalasia'
			else if exists("AnalFissureCondition")
				then 'Anal Fissure'
					else if exists("HyperhidrosisCondition")
						then 'Primary Axillary Hyperhidrosis'
							else if exists("SialorrheaCondition")
								then 'Sialorrhea'
									else if exists("UrinaryIncontinenceCondition")
										then 'Urinary Incontinence'
											else if exists("SpasticityCondition")
												then 'Spasticity'
													else if exists("BlepharospasmCondition")
														then 'Blepharospasm'
															else ''
															/*else if exists("MigraineConditon")
																then 'Headache/Migraine'
																	else ''*/

//PRIOR BOTULINUM ADMINISTRATION
define MedicationAdministrationResources:
		[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and First((M.medication as CodeableConcept).coding) in "Botulinum Toxin RXNORM Codes"

define MedicationResources:
	[Medication]med where (First(med.code.coding) in "Botulinum Toxin RXNORM Codes") is not null

define ProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define CheckBotoxAdministration:
	"MedicationAdministrationResources" M
		with "ProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define SpecifyBotoxAdministrationMedicationCode:
		"MedicationAdministrationResources".medication M

//SPASTICITY
define Request:
	"ServiceRequest"

define SpasticityFacialUnilateral:
if (exists("Request".code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral"))
	then true
	else false

define SpasticityFacialBilateral:
if (exists("Request".code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral"))
	then true
	else false

define SpasticityNeck:
if (exists("Request".code.coding C where C in "Chemodenervation of Neck Muscle(s)"))
	then true
	else false

define SpasticityLarynx:
if (exists("Request".code.coding C where C in "Chemodenervation of Larynx Muscle(s)"))
	then true
	else false

define SpasticityLarygoscopy:
if (exists("Request".code.coding C where C in "Laryngoscopy Codes"))
	then true
	else false

define SpasticityTrunkOneToFiveMuscles:
if (exists("Request".code.coding C where C in "Chemodenervation Of Trunk Muscle(S); 1-5 Muscle(S)"))
	then true
	else false

define SpasticityTrunkSixOrMoreMuscles:
if (exists("Request".code.coding C where C in "Chemodenervation Of Trunk Muscle(S); 6 Or More Muscles"))
	then true
	else false

define SpasticityOneExtremityOneToFourMuscles:
if (exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 1-4 Muscle(S)"))
	then true
	else false

define SpasticityOneExtremityFiveOrMoreMuscles:
if (exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 5 Or More Muscles"))
	then true
	else false

define SpasticityExtraocular:
if (exists("Request".code.coding C where C in "Chemodenervation of Extraocular Muscle"))
	then true
	else false

define SpasticityMuscleGroups:
	if (("SpasticityFacialUnilateral" = true)
				or ("SpasticityFacialBilateral"= true))
					then 'Face'
						else if ("SpasticityNeck" = true)
							then 'Neck'
								else if (("SpasticityLarynx" = true)
									or ("SpasticityLarygoscopy" = true))
										then 'Muscles of larynx'
											else if (("SpasticityTrunkOneToFiveMuscles" = true)
												or ("SpasticityTrunkSixOrMoreMuscles" = true))
													then 'Trunk muscles'
														else if (("SpasticityOneExtremityOneToFourMuscles" = true)
															or ("SpasticityOneExtremityFiveOrMoreMuscles" = true))
																then 'Extremity muscles'
																	else if ("SpasticityExtraocular" = true)
																		then 'Extraocular Mucles'
																			else ''

define SpasticityFaceInjectionSide:
	if ("SpasticityFacialUnilateral" = true)
		then 'Unilateral'
			else if ("SpasticityFacialBilateral"= true)
				then 'Bilateral'
					else ''

define InjectionSideExtremity:
	if ("SpasticityOneExtremityOneToFourMuscles" = true)
		then '1-4 muscle groups'
			else if ("SpasticityOneExtremityFiveOrMoreMuscles" = true)
				then '5 or more muscles'
					else ''

define InjectionSideTrunk:
	if ("SpasticityTrunkOneToFiveMuscles" = true)
		then '1-5 muscles'
			else if ("SpasticityTrunkSixOrMoreMuscles" = true)
				then '6 or more muscles'
					else ''

define IschemicStroke:
	[Condition]C
    where exists(C.code.coding C where C in "Ischemic Stroke")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define MultipleSclerosis:
	[Condition]C
    where exists(C.code.coding C where C in "Multiple Sclerosis (ICD10CM)")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define BrainInjury:
	[Condition]C
    where exists(C.code.coding C where C in "Brain Injury")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define CerebralPalsy:
	[Condition]C
    where exists(C.code.coding C where C in "Cerebral Palsy")
            and First(C.clinicalStatus.coding).code.value = 'active'
			        and First(C.verificationStatus.coding).code.value = 'confirmed'

define Etiology:
	if exists("IschemicStroke")
		then 'Ischemic Stroke'
			else if exists("MultipleSclerosis")
				then 'Multiple Sclerosis'
					else if exists("BrainInjury")
						then 'Traumatic Brain Injury'
							else if exists("CerebralPalsy")
								then 'Cerebral Palsy'
									else ''

define AdjunctivePhysiotherapyProcedure:
	[Procedure]P
		where P.status.value = 'completed'
			and exists(P.code.coding C where C in "RehabilitationServices")

define AdjunctivePhysiotherapy:
	if exists("AdjunctivePhysiotherapyProcedure")
		then true
			else false

define SpasticityEarlierBotulinumAdministration:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define SpasticitySpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define SpasticityPostBotoxImprovement:
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

//BLEPHAROSPASM
define KeratopathyCondition:
  [Condition]B
		where exists(B.code.coding C where C in "Keratopathy")
		  and First(B.clinicalStatus.coding).code.value = 'active'
			  and First(B.verificationStatus.coding).code.value = 'confirmed'

define CheckKeratopathy:
  if exists("KeratopathyCondition")
    then true
      else false

define AbnormalInvoluntaryMovements:
  [Condition]B
		where exists(B.code.coding C where C in "Abnormal Involuntary Movements")
		  and First(B.clinicalStatus.coding).code.value = 'active'
			  and First(B.verificationStatus.coding).code.value = 'confirmed'

define CheckAbnormalInvoluntaryMovements:
  if exists("AbnormalInvoluntaryMovements")
    then true
      else false

define OcularIrritation:
  [Condition]B
		where exists(B.code.coding C where C in "Disorder of Eye")
		  and First(B.clinicalStatus.coding).code.value = 'active'
			  and First(B.verificationStatus.coding).code.value = 'confirmed'

define CheckOcularIrritation:
  if exists("OcularIrritation")
    then true
      else false

define BlepharospasmEarlierBotulinumAdministration:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define BlepharospasmSpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define BlepharospasmPostBotoxImprovement:
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

//SIALORRHEA
define ParkinsonDisease:
	[Condition]C
    where exists(C.code.coding C where C in "Parkinson’s disease (Disorders) (ICD10CM)")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define NeuromuscularSensoryDysfunction:
  if exists("CerebralPalsy") 		// The function for this condition has been defined above with Spasticity
			or exists("ParkinsonDisease")
				or exists("IschemicStroke") // The function for this condition has been defined above with Spasticity
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
	"SialorrheaCondition" S
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

define SialorrheaEarlierBotulinumAdministration:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define SialorrheaSpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define SialorrheaPostBotoxImprovement:
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

define SialorrheaAnticholinergicContraindications:
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

//ACHALASIA
define HypertensiveLOSCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Hypertensive LOS")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define HypertensiveLOS:
	if exists("HypertensiveLOSCondition")
		then true
			else false

define MalnutritionCondition:
	[Condition]C
    where exists(C.code.coding C where C in "Malnutrition")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define OesophagealBiopsy:
	[Procedure]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
 				and P.status.value = 'completed'
						and First(P.code.coding) in "Oesophageal Biopsy"

define EsophagusDisease:
	[Condition]C
    where exists(C.code.coding C where C in "Esophagus Disease Codes")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define EpiphrenicDiverticulum:
	[Condition]C
    where exists(C.code.coding C where C in "Epiphrenic Diverticulum")
              and First(C.clinicalStatus.coding).code.value = 'active'
			          and First(C.verificationStatus.coding).code.value = 'confirmed'

define RiskFactorsEsophagealPerforation:
	if (exists("MalnutritionCondition")
				or exists("OesophagealBiopsy")
					or exists("EsophagusDisease")
						or exists("EpiphrenicDiverticulum"))
							then true
								else false

define PneumaticDilation:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Pneumatic Dilation"

define SurgicalMyotomy:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Surgical Myotomy Codes"

define AchalasiaProcedures:
	if exists("PneumaticDilation")
		then 'Pneumatic Dilation'
			else if exists("SurgicalMyotomy")
				then 'Surgical Myotomy'
					else ''

define PostPneumaticDilationImprovement:
	"PneumaticDilation" P
		where First(P.outcome.coding) in "Unsuccessful"

define PostSurgicalMyotomyImprovement:
	"SurgicalMyotomy" P
		where First(P.outcome.coding) in "Unsuccessful"

define AchalasiaPostProceduresImprovement:
	if exists("PostPneumaticDilationImprovement")
		or exists("PostSurgicalMyotomyImprovement")
			then false
				else true

define AchalasiaEarlierBotulinumAdministration:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define AchalasiaSpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define AchalasiaPostBotoxImprovement:
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

//ANAL FISSURE
define DurationOfAnalFissure:
	[Condition]S
		where exists(S.code.coding C where C in "AnalFissure Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'
						and "Normalize Onset"(S.onset) starts after (Today()-90 days)

define CheckDurationOfAnalFissure:
	if exists("DurationOfAnalFissure")
		then true
			else false

define FiberSupplementDrugResources:
		[MedicationAdministration]M
			where M.subject.reference.value = 'Patient/'+ Patient.id.value
				and M.status.value = 'completed'
					and First((M.medication as CodeableConcept).coding) in "Fiber Supplements RXNORM Codes"

define FiberMedicationResources:
	[Medication]med where (First(med.code.coding) in "Fiber Supplements RXNORM Codes") is not null

define FiberProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define CheckFiberAdministration:
	"FiberSupplementDrugResources" M
		with "FiberProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define StoolSoftenersDrugResources:
		[MedicationAdministration]M
			where M.subject.reference.value = 'Patient/'+ Patient.id.value
				and M.status.value = 'completed'
					and First((M.medication as CodeableConcept).coding) in "Stool softeners and laxatives"

define StoolSoftenersMedicationResources:
	[Medication]med where (First(med.code.coding) in "Stool softeners and laxatives") is not null

define StoolSoftenersProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define CheckStoolSoftenersAdministration:
	"StoolSoftenersDrugResources" M
		with "StoolSoftenersProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define SitzBath:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Sitz Bath"

define TopicalAnaestheticApplication:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Topical Anaesthetic Application"

define ConservativeTreatmentOptions:
  if Last("CheckFiberAdministration") is not null
		then 'Fiber Supplements'
			else if Last("CheckStoolSoftenersAdministration")  is not null
				then 'Stool Softeners'
					else if exists("SitzBath")
						then 'Sitz Bath'
							else if exists("TopicalAnaestheticApplication")
								then 'Topical Anaesthetic Application'
									else ''

define PostFiberImprovement:
	"FiberSupplementDrugResources" M
		with "FiberProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
				and First(P.outcome.coding) in "Unsuccessful"


define PostStoolSoftnersImprovement:
	"StoolSoftenersDrugResources" M
		with "StoolSoftenersProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
				and First(P.outcome.coding) in "Unsuccessful"

define PostSitzBathImprovement:
	"SitzBath" P
			where First(P.outcome.coding) in "Unsuccessful"

define PostTopicalAnaestheticApplicationImprovement:
	"TopicalAnaestheticApplication" P
			where First(P.outcome.coding) in "Unsuccessful"

define PostConservativeTreatmentImprovement:
	if (exists("PostFiberImprovement")
				or exists("PostStoolSoftnersImprovement")
					or exists("PostSitzBathImprovement")
						or exists("PostTopicalAnaestheticApplicationImprovement"))
							then false
								else true

define AnalFissurePriorBotulinumToxin:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define AnalFissureSpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define AnalFissurePostBotoxImprovement:
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

//HYPERHIDROSIS
define SevereSweating:
	[Condition]C
    where exists(C.code.coding C where C in "Generalised Hyperhidrosis")
			and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'

define CheckSevereSweating:
	if exists("SevereSweating")
		then true
			else false

define DurationOfSweating:
	"AnalFissureCondition" C
		where "Normalize Interval"(C.onset) after (Today()-180 days)

define CheckDurationOfSweating:
	if exists("DurationOfSweating")
		then true
			else false

define AnticholinergicDrugResources:
		[MedicationAdministration]M
			where M.subject.reference.value = 'Patient/'+ Patient.id.value
				and M.status.value = 'completed'
					and First((M.medication as CodeableConcept).coding) in "Anticholinergic Medications"

define AnticholinergicMedicationResources:
	[Medication]med where (First(med.code.coding) in "Anticholinergic Medications") is not null

define AnticholinergicProcedureResources:
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and First(P.code.coding) in "Procedure for Medication Administration"

define CheckAnticholinergicAdministration:
	"AnticholinergicDrugResources" M
		with "AnticholinergicProcedureResources" P
			such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define AnticholinergicMedications:
  if Last("CheckAnticholinergicAdministration") is not null
	then true
	else false

define PostAnticholinergicImprovement:
	if exists("AnticholinergicDrugResources" M
							with "AnticholinergicProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

define HyperhydrosisPriorBotulinumToxin:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define HyperhydrosisSpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define HyperhydrosisPostBotoxImprovement:
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true


//URINARY INCONTINENCE
define CheckUrinaryIncontinenceAntiCholinergicTreatment: /*Definitions for these have been defined above under Hyperhydrosis*/
  if Last("CheckAnticholinergicAdministration") is not null
		then true
			else false

define PostUrinaryIncontinenceAnticholinergicImprovement:
	if exists("AnticholinergicDrugResources" M
							with "AnticholinergicProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

define UrinaryIncontinencePriorBotulinumToxin:
  if Last("CheckBotoxAdministration") is not null
	then true
	else false

define UrinaryIncontinenceSpecifyBotoxAdministration:
	"SpecifyBotoxAdministrationMedicationCode".coding M
		return (M.display.value)

define UrinaryIncontinencePostBotoxImprovement:
	if exists("MedicationAdministrationResources" M
							with "ProcedureResources" P
								such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)
 										and First(P.outcome.coding) in "Unsuccessful")
					then false
						else true

define UrinaryIncontinenceAnticholinergicContraindications:
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

//BOTOX ALLERGY
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