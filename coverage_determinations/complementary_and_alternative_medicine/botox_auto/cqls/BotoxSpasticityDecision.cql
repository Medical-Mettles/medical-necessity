library BotoxSpasticityDecision version '1.0.0'

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
valueset "Physiotherapy Codes": '2.16.840.1.113883.3.6037.1001.23.93.89'
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



parameter "ServiceRequest" ServiceRequest

context Patient

//BOTULINUM CONDITION
define SpasticityCondition:
	[Condition]S
		where exists(S.code.coding C where C in "Spasticity Condition Codes")
		  and First(S.clinicalStatus.coding).code.value = 'active'
			  and First(S.verificationStatus.coding).code.value = 'confirmed'

define BotoxDiagnosisConditions:
	if exists("SpasticityCondition")
            then 'Spasticity'
                else ''

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

define SpasticityLaryngoscopy:
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
									or ("SpasticityLaryngoscopy" = true))
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

define BotoxConditionsDecision:
  if ("BotoxDiagnosisConditions" = 'Spasticity')
    then true
      else false


define ChemodenervationOneExtremityQualifiedConditions:
      if ("BotoxConditionsDecision" = true)
          then true
            else false

define ChemodenervationOneExtremityServiceRequest:
if (exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 1-4 Muscle(S)")
      or exists("Request".code.coding C where C in "Chemodenervation Of One Extremity; 5 Or More Muscles"))
  	    then true
	        else false

define ReasonForDenial:
	if("ChemodenervationOneExtremityQualifiedConditions" = false)
		then 'HP001 -The documentation does not support medical necessity of a specific condition as indicated for the administration of botulinum toxin. Refer to 42 Code of Federal Regulations (CFR) 411.15(k)(1), Social Security Act (SSA) Title XVIII, Section 1862(a)(1)(A), Internet Only Manual (IOM) Publication (Pub.) 100-02, Chapter 16, Section 120 and IOM Pub. 100-08, Chapter 3, Section 3.6.2.2. Refer to the MAC LCD and/or LCA if applicable'
			else null
			
define PrimaryDecision:
      if (("ChemodenervationOneExtremityServiceRequest" = true)
            and ("ChemodenervationOneExtremityQualifiedConditions" = true))
        then true
          else false

define FinalDecision:
      if  ("PrimaryDecision" = true)
              then 'YES'
                else 'HUMAN REVIEW NEEDED'


