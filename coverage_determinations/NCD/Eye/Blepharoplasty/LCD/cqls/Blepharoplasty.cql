library Blepharoplasty version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers


codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Blepharoplasty of Upper Eyelid Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.18'
valueset "Blepharoplasty of Lower Eyelid Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.19'
valueset "Functional Deficits in EyeLid": '2.16.840.1.113883.3.6037.1001.23.99.20'
valueset "Botox Cosmetic Injectable Product": '2.16.840.1.113883.3.6037.1001.23.99.21'
valueset "Changes in skin texture": '2.16.840.1.113883.3.6037.1001.23.99.22'
valueset "Blepharospasm": '2.16.840.1.113883.3.6037.1001.23.99.23'
valueset "Margin reflex distance": '2.16.840.1.113883.3.6037.1001.23.99.24'
valueset "Sockets": '2.16.840.1.113883.3.6037.1001.23.99.25'

/*code "Interference with vision (finding)": '246638009' from "SNOMED-CT"
code "Difficulty reading (finding)": '309253009' from "SNOMED-CT"
code "Difficulty driving a car (finding)": '300638003' from "SNOMED-CT"
code "Eyelid malposition (disorder)": '404625000' from "SNOMED-CT"
code "Eyelid laceration without lid margin involvement (disorder)": '314535007' from "SNOMED-CT"
code "Blepharitis of bilateral eyelids caused by staphylococcus (disorder)": '675421000119103' from "SNOMED-CT"
code "Blepharitis of left eyelid caused by staphylococcus (disorder)": '675431000119100' from "SNOMED-CT"
code "Blepharitis of right eyelid caused by staphylococcus (disorder)": '675441000119109' from "SNOMED-CT"
code "Acquired absence of eye": 'Z90.01' from "ICD-10-CM"
code "Microphthalmic socket (disorder)": '762414004' from "SNOMED-CT"
code "Enophthalmos due to trauma or surgery, unspecified eye": 'H05.429' from "ICD-10-CM"
code "Other anophthalmos": 'Q11.1' from "ICD-10-CM"
code "Blepharospasm":'G24.5' from  "ICD-10-CM"
code "Botox Cosmetic Injectable Product": '1175723' from "SNOMED-CT"
code "Margin reflex distance": '422462002' from "SNOMED-CT"
code "Erythematous condition, unspecified": 'L53.9' from "ICD-10-CM"
code "Edema, unspecified": 'R60.9' from "ICD-10-CM"
code "Changes in skin texture": 'R23.4' from "ICD-10-CM"*/

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define function "EncounterDiagnosis"(Encounter Encounter):
	Encounter.diagnosis D
	return First([Condition]C
				where C.id.value = "GetId"(D.condition.reference.value)
					and FHIRHelpers.ToInteger(D.rank) = 2)
define function "GetId"(uri String):
	Last(Split(uri, '/'))

define ServiceCondition:
	"EncounterDiagnosis"("ServiceEncounter")

define ServiceDiagnosis:
	First("ServiceCondition" S
			where (First(S.code.coding) in "Blepharoplasty of Upper Eyelid Diagnosis Codes"
				or First(S.code.coding) in "Blepharoplasty of Lower Eyelid Diagnosis Codes")
			)

define ServiceDiagnosis1:
	First("ServiceCondition" S
			where First(S.code.coding) in "Blepharoplasty of Upper Eyelid Diagnosis Codes"
			)

define ServiceDiagnosis2:
	First("ServiceCondition" S
			where First(S.code.coding) in "Blepharoplasty of Lower Eyelid Diagnosis Codes"
			)

define FunctionalDef:
	[Condition]C
		where (First(C.code.coding) in "Functional Deficits in EyeLid" )

define FunctionalDeficits:
	[Condition]C
		where (First(C.code.coding) in "Sockets"
			and (First("QA31".value) = true))

define BlepharospasmCondition:
	First([Condition]C
		with [Procedure]P
		such that First(C.code.coding) in "Blepharospasm"
		and First(P.code.coding) in "Botox Cosmetic Injectable Product")

define Blepharoptosis:
	First([Observation]O
		where First(O.code.coding) in "Margin reflex distance"
			and FHIRHelpers.ToQuantity(O.value) <= 2)

define MRD:
	(First([Observation]O
		where First(O.code.coding) in "Margin reflex distance"
			and FHIRHelpers.ToQuantity(O.value) <= 2))M
		 return FHIRHelpers.ToQuantity(M.value)


define QT:
	"QuestionnaireResponse".item

// the more ptotic eye clearly meets the MRD criteria
define QA21:
	("QT".item I
		where I.linkId.value = '2.1')QR
		return First(QR.answer).value

//lifting the more ptotic lid with tape or by instillation of phenylephrine drops into the superior fornix causes the less ptotic lid to drop downward
define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

//Redundant eyelid tissue touching the eyelashes or hanging over the eyelid margin resulting in pseudoptosis where the “pseudo” margin produces a central "pseudo-MRD" of 2.0 mm or less
define QA23:
	("QT".item I
		where I.linkId.value = '2.3')QR
		return First(QR.answer).value

//Redundant eyelid tissue predominantly medially or laterally clearly obscures the line of sight incorresponding gaze
define QA24:
	("QT".item I
		where I.linkId.value = '2.4')QR
		return First(QR.answer).value

define QA25:
	("QT".item I
		where I.linkId.value = '2.5')QR
		return First(QR.answer).value

define QA26:
	("QT".item I
		where I.linkId.value = '2.6')QR
		return First(QR.answer).value

define QA27:
	("QT".item I
		where I.linkId.value = '2.7')QR
		return First(QR.answer).value

define QA31:
	("QT".item I
		where I.linkId.value = '3.1')QR
		return First(QR.answer).value

define BothEyelidsBlepharoptosis:
 	if ((("Blepharoptosis" is not null) or (First("QA21".value) = true))
 		and ((First("QA22".value) = true) or (First("QA23".value) = true))
 		and (First("QA22".value) = true) or (First("QA24".value) = true))
 		then true
 		else false

define BrowRepair:
	First([Condition]C
		where First(C.code.coding) in "Changes in skin texture")

define UpperBlepharoplasty:
	if ( ((First("QA25".value) = true)
		or (First("QA26".value) = true)
		or (First("QA27".value) = true))
		and ("BrowRepair" is not null))
		then true
		else false

define BlepharospasmDescription:
	if ("BlepharospasmCondition" is not null)
	then "BlepharospasmCondition".stage.summary.coding.display.value
	else null

define UpperPrimaryDecision:
	if( "ServiceDiagnosis1" is not null
		and "FunctionalDeficits" is not null
		and ("UpperBlepharoplasty" = true))
		then true
		else false

define LowerPrimaryDecision:
	if( "ServiceDiagnosis2" is not null
		and "FunctionalDeficits" is not null)
		then true
		else false

define BothEyelidPrimaryDecision:
	if( "ServiceDiagnosis" is not null
		and "FunctionalDeficits" is not null
		and ("BothEyelidsBlepharoptosis" = true))
		then true
		else false

define IntermediateDecision:
	if ("UpperPrimaryDecision" = true)
	then 'YES FOR UPPER EYELID.PHOTOGRAPHIC EVIDENCE TO BE REVIEWED'
	else
	if ("LowerPrimaryDecision" = true)
	then 'YES FOR LOWER EYELID.PHOTOGRAPHIC EVIDENCE TO BE REVIEWED'
	else
	if ("BothEyelidPrimaryDecision" = true)
	then 'YES FOR UPPER AND LOWER EYELIDS.PHOTOGRAPHIC EVIDENCE TO BE REVIEWED'
	else 'NO'
