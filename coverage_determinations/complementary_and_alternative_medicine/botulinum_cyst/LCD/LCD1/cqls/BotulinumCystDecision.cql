library BotulinumCystDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BotulinumCyst version '1.0.0' called BTCommon

//include otherLibrary version 'x.x' called otherLibrary
//codesystem codeSystemName : 'OID' version 'x.x'
//valueset valuesetName : 'OID' version 'x.x' codesystems{codeSystem1 , codeSystem2, etc}
//code codeName : 'OID' from codeSystemName display 'displayName'
//concept conceptName : {codeName1, codeName2, etc} display 'displayName'
//parameter parameterName (dataType or default value)

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "ChemodenervationOfNeckMuscle Codes": '2.16.840.1.113883.3.6037.1001.23.99.36'
valueset "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral": '2.16.840.1.113883.3.6037.1001.23.99.37'
valueset "Esophagogastroduodenoscopy" : '2.16.840.1.113883.3.6037.1001.23.99.38'
valueset "Chemodenervation of Internal Anal Sphincter": '2.16.840.1.113883.3.6037.1001.23.99.39'
valueset "Cystourethroscopy, with Injection(s) for Chemodenervation of the Bladder": '2.16.840.1.113883.3.6037.1001.23.99.40'
valueset "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral": '2.16.840.1.113883.3.6037.1001.23.99.41'
valueset "Chemodenervation of Muscle(s); Neck Muscles(s), Muscles of the Larynx, Unilateral": '2.16.840.1.113883.3.6037.1001.23.99.42'
valueset "Chemodenervation of One Extremity, Trunk Muscles(s)" : '2.16.840.1.113883.3.6037.1001.23.99.43'
valueset "Chemodenervation of Eccrine Glands": '2.16.840.1.113883.3.6037.1001.23.99.44'
valueset "Chemodenervation of Extraocular Muscle": '2.16.840.1.113883.3.6037.1001.23.99.45'
valueset "Chemodenervation of Muscle(s)": '2.16.840.1.113883.3.6037.1001.23.99.46'
valueset "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral": '2.16.840.1.113883.3.6037.1001.23.99.47'
valueset "Onabotulinumtoxina":  '2.16.840.1.113883.3.6037.1001.23.99.78'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'
valueset "Successful": '2.16.840.1.113883.3.6037.1001.23.94.50'

valueset "Status of Patient Condition": '2.16.840.1.113762.1.4.1096.114'
valueset "Treatment Failure": '2.16.840.1.113762.1.4.1111.93'
valueset "Medical Contraindication": '2.16.840.1.113883.3.117.1.7.1.412'
valueset "Recommended Treatment Contraindicated or Ineffective": '2.16.840.1.113762.1.4.1034.557'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define ServiceEncounter:
	BTCommon."ServiceEncounter"

define QualifiedConditions:
	BTCommon."QualifiedConditions"

define Esophagoscopy:
	BTCommon."Esophagoscopy"

define Sialorrhea:
	BTCommon."Sialorrhea"

define AnalFissure:
	BTCommon."AnalFissure"

define Cystourethroscopy:
	BTCommon."Cystourethroscopy"

define Blepharospasm:
	BTCommon."Blepharospasm"

define CervicalDystonia:
	BTCommon."CervicalDystonia"

define ChemodenervationOfOneExtremity:
	BTCommon."ChemodenervationOfOneExtremity"

define Hyperhidrosis:
	BTCommon."Hyperhidrosis"
	
define ExtraOcularMuscle:
	BTCommon."ExtraOcularMuscle"

define ChemodenervationOfNeckMuscle:
	BTCommon."ChemodenervationOfNeckMuscle"

define MigraineWithoutAura:
	BTCommon."MigraineWithoutAura"

define Headaches:
	BTCommon."Headaches"

define Duration:
		[Condition] C
		where exists(C.code.coding C where C in "ChemodenervationOfNeckMuscle Codes")
		and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'
			and duration in days of Interval[start of "Normalize Interval"(C.onset),start of "Normalize Interval"(C.abatement)] > 14 days
			and "Normalize Interval"(C.onset) after (Today()-120 days)

define ThreeMonthHeadaches:
		if (Count("Duration") > 2)
			then true
			else false

define BotulinumAdministeredBefore:
		exists([Procedure]P
			where P.status.value = 'completed'
			and exists(P.code.coding C where C in "Chemodenervation of Muscle(s)"))

define RefractoryToTherapy:
		exists([Condition]C
				with [Condition]R
				such that exists(C.code.coding C where C in "Recommended Treatment Contraindicated or Ineffective")
				and First(C.clinicalStatus.coding).code.value = 'active'
				and First(C.verificationStatus.coding).code.value = 'confirmed'
				and exists(R.code.coding Q where Q in "ChemodenervationOfNeckMuscle Codes")
				and First(R.clinicalStatus.coding).code.value = 'active'
				and First(R.verificationStatus.coding).code.value = 'confirmed'
				and "Normalize Interval"(C.onset) starts after end of "Normalize Interval"(R.onset))



							
define BotoxAdministered:
		exists([Procedure]P
				with [Procedure]R
				such that P.status.value = 'completed'
				and R.status.value = 'completed'
				and (	(exists(P.code.coding C where C in "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral")
							and exists(R.code.coding C where C in "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral"))
						or 
						(exists(P.code.coding C where C in "Esophagogastroduodenoscopy")
							and exists(R.code.coding C where C in "Esophagogastroduodenoscopy"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Internal Anal Sphincter")
							and exists(R.code.coding C where C in "Chemodenervation of Internal Anal Sphincter"))
						or 
						(exists(P.code.coding C where C in "Cystourethroscopy, with Injection(s) for Chemodenervation of the Bladder")
							and exists(R.code.coding C where C in "Cystourethroscopy, with Injection(s) for Chemodenervation of the Bladder"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral")
							and exists(R.code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Muscle(s); Neck Muscles(s), Muscles of the Larynx, Unilateral")
							and exists(R.code.coding C where C in "Chemodenervation of Muscle(s); Neck Muscles(s), Muscles of the Larynx, Unilateral"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of One Extremity, Trunk Muscles(s)")
							and exists(R.code.coding C where C in "Chemodenervation of One Extremity, Trunk Muscles(s)"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Eccrine Glands")
							and exists(R.code.coding C where C in "Chemodenervation of Eccrine Glands"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Extraocular Muscle")
							and exists(R.code.coding C where C in "Chemodenervation of Extraocular Muscle"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Muscle(s)")
							and exists(R.code.coding C where C in "Chemodenervation of Muscle(s)"))
						or 
						(exists(P.code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral")
							and exists(R.code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral"))
						or 
						(exists(P.code.coding C where C in "Onabotulinumtoxina")
							and exists(R.code.coding C where C in "Onabotulinumtoxina"))
					)
				and First(P.outcome.coding) in "Unsuccessful"
				and First(R.outcome.coding) in "Unsuccessful"
				and "Normalize Interval"(P.performed) starts before "Normalize Interval"(R.performed)
				and "Normalize Interval"(R.performed) starts after (Today()-1 year))



define ConsecutiveBotoxFailure:
		if ("BotoxAdministered" = true)
		then true
		else false

define ImprovementInHeadachesAfterBotoxAdministration:
		exists([Condition] C
		with [Procedure]P
		such that exists(C.code.coding C where C in "ChemodenervationOfNeckMuscle Codes")
			and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'
			and exists(P.code.coding C where C in "Chemodenervation of Muscle(s)")
			and P.status.value = 'completed'
			and First(P.outcome.coding) in "Successful"
			and First(First(C.stage).summary.coding) in "Status of Patient Condition")

define HeadacheFrequencyReductionAfterBotoxAdministration:
		exists([Condition] C
		with [Procedure]P
		such that exists(C.code.coding C where C in "ChemodenervationOfNeckMuscle Codes")
			and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed'
			and exists(P.code.coding C where C in "Chemodenervation of Muscle(s)")
			and P.status.value = 'completed'
			and "Normalize Interval"(P.performed) before C.onset
			and C.onset in Interval[start of "Normalize Interval"(P.performed), start of "Normalize Interval"(P.performed) + 120 days])
			
define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.date, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
	if onset is FHIR.date then
	  Interval[ToDateTime(onset as FHIR.date), ToDateTime(onset as FHIR.date)]
        else if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null



define QT:
	"QuestionnaireResponse".item

define QA14:
	("QT".item I
		where I.linkId.value = '1.4')QR
		return First(QR.answer).value

define QA21:
	("QT".item I
		where I.linkId.value = '2.1')QR
		return First(QR.answer).value

//headache disorders occurring greaterthan 15 days a month for a period of at least 3months
define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

//have been refractory to standard and usual conventional therapy
define QA23:
	("QT".item I
		where I.linkId.value = '2.3')QR
		return First(QR.answer).value

//Is the patient administered botulin toxin before
define QA24:
	("QT".item I
		where I.linkId.value = '2.4')QR
		return First(QR.answer).value

// the patients must demonstrate a significant decrease in the number and frequency ofheadaches and an improvement in function upon receiving Botulinum toxin
define QA25:
	("QT".item I
		where I.linkId.value = '2.5')QR
		return First(QR.answer).value

//failure of two definitive, consecutive, treatment sessions involving a muscle or group of muscles when treated with botulinum toxin
define QA31:
	("QT".item I
		where I.linkId.value = '3.1')QR
		return First(QR.answer).value

define HeadachesCriteria:
	if	( 
			("Headaches" = true)
			and 
			(
				(
					(
						(First("QA22") = true) 
						and (First("QA23") = true)
					)
					or 
					(	
						(First("QA24") = true) 
						and (First("QA25") = true)
					)
				)
				or
				(
					(
						("ThreeMonthHeadaches"= true)
						and ("RefractoryToTherapy" = true)
					)
					or 
					(
						("BotulinumAdministeredBefore" = true)
						and (("ImprovementInHeadachesAfterBotoxAdministration"= true)
								or ("HeadacheFrequencyReductionAfterBotoxAdministration" = true))
					)
				)
			)
	    )
		then true
		else false

define theclaim:
	[Claim]C

define Request:
	"ServiceRequest"

define Preclusion:
	("ServiceRequest".quantity).value.value

define ServiceCode1:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral"))
		and ("Sialorrhea" is not null)
		and ((First("QA14") = true)
				or
			exists([Procedure]P
						where P.status.value = 'completed'
							and exists(P.code.coding C where C in "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral")
							and First(P.outcome.coding) in "Recommended Treatment Contraindicated or Ineffective")
			))
	then true
	else false

define ServiceCode2:
	if ((exists("Request".code.coding C where C in "Esophagogastroduodenoscopy"))
		and ("Esophagoscopy" is not null)
		and ((First("QA14") = true)
			or
				exists([Procedure]P
							where P.status.value = 'completed'
								and exists(P.code.coding C where C in "Esophagogastroduodenoscopy")
								and First(P.outcome.coding) in "Recommended Treatment Contraindicated or Ineffective")
		))
	then true
	else false

define ServiceCode3:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Internal Anal Sphincter"))
		and ("AnalFissure" is not null)
		and ((First("QA14") = true)
			or
				exists([Procedure]P
							where P.status.value = 'completed'
								and exists(P.code.coding C where C in "Chemodenervation of Internal Anal Sphincter")
								and First(P.outcome.coding) in "Recommended Treatment Contraindicated or Ineffective")
		))
	then true
	else false

define ServiceCode4:
	if ((exists("Request".code.coding C where C in "Cystourethroscopy, with Injection(s) for Chemodenervation of the Bladder"))
		and ("Cystourethroscopy" is not null))
	then true
	else false

define ServiceCode5:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral"))
			and ("Blepharospasm" is not null))
	then true
	else false

define ServiceCode6:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Muscle(s); Neck Muscles(s), Muscles of the Larynx, Unilateral"))
		and ("CervicalDystonia" is not null))
	then true
	else false

define ServiceCode7:
	if ((exists("Request".code.coding C where C in "Chemodenervation of One Extremity, Trunk Muscles(s)"))
		and ("ChemodenervationOfOneExtremity" is not null))
	then true
	else false

define ServiceCode8:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Eccrine Glands"))
		and ("Hyperhidrosis" is not null))
	then true
	else false

define ServiceCode9:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Extraocular Muscle"))
		and ("ExtraOcularMuscle" is not null))
	then true
	else false

define ServiceCode10:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Muscle(s)"))
		and ("HeadachesCriteria" = true))
	then true
	else false

define ServiceCode11:
	if ((exists("Request".code.coding C where C in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral"))
		and ("MigraineWithoutAura" is not null))
	then true
	else false

define ServiceCode12:
		if ((exists("Request".code.coding C where C in "Onabotulinumtoxina"))
			and ("Hyperhidrosis" is not null)
			and (("ServiceCode5" = true) and ("ServiceCode11" = true)))
		then true
		else false

define Limitations:
	if (
		("QualifiedConditions" is not null)
		and ("Preclusion" <2)
		and ((First("QA31") = false)
				or ("ConsecutiveBotoxFailure" = false))
	   )
		then true
		else false

define PrimaryDecision:
	if(
		(("ServiceCode1" = true)
		or ("ServiceCode2" = true)
		or ("ServiceCode3" = true)
		or ("ServiceCode4" = true)
		or ("ServiceCode6" = true)
		or ("ServiceCode7" = true)
		or ("ServiceCode8" = true)
		or ("ServiceCode9" = true)
		or ("ServiceCode10" = true)
		or ("ServiceCode11" = true)
		or ("ServiceCode12" = true))
	    and
	        ("Limitations" = true))
	        then true
	        else false

define FinalDecision:
	if (("ServiceCode5" = true) 
			and (IsNull("Blepharospasm")= false)
			and ("Limitations" = true))
		then 'HUMAN REVIEW NEEDED'
		else if ("PrimaryDecision" = true)
		then 'YES'
		else 'NO'