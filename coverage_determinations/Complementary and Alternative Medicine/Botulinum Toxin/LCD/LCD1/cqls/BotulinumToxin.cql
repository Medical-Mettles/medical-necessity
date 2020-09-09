library BotulinumToxin version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

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

valueset "BotulinumToxin Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.26'
valueset "Sialorrhea Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.27'
valueset "Esophagoscopy Codes": '2.16.840.1.113883.3.6037.1001.23.99.28'
valueset "AnalFissure Codes": '2.16.840.1.113883.3.6037.1001.23.99.29'
valueset "Cystourethroscopy Codes": '2.16.840.1.113883.3.6037.1001.23.99.30'
valueset "Blepharospasm Codes": '2.16.840.1.113883.3.6037.1001.23.99.31'
valueset "CervicalDystonia Codes": '2.16.840.1.113883.3.6037.1001.23.99.32'
valueset "ChemodenervationOfOneExtremity Codes": '2.16.840.1.113883.3.6037.1001.23.99.33'
valueset "Hyperhidrosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.34'
valueset "ExtraOcularMuscle Codes": '2.16.840.1.113883.3.6037.1001.23.99.35'
valueset "ChemodenervationOfNeckMuscle Codes": '2.16.840.1.113883.3.6037.1001.23.99.36'
valueset "MigraineWithoutAura Codes": '2.16.840.1.113883.3.6037.1001.23.99.48'
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

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define QualifiedConditions:
	First([Condition]C
		where First(C.code.coding) in "BotulinumToxin Diagnosis Codes")

define Esophagoscopy:
	First([Condition]C
		where First(C.code.coding) in "Esophagoscopy Codes")

define Sialorrhea:
	First([Condition]C
		where First(C.code.coding) in "Sialorrhea Diagnosis Codes")

define AnalFissure:
	First([Condition]C
		where First(C.code.coding) in "AnalFissure Codes")

define Cystourethroscopy:
	First([Condition]C
		where First(C.code.coding) in "Cystourethroscopy Codes")

define Blepharospasm:
	First([Condition]C
		where First(C.code.coding) in "Blepharospasm Codes")

define CervicalDystonia:
	First([Condition]C
		where First(C.code.coding) in "CervicalDystonia Codes")

define ChemodenervationOfOneExtremity:
	First([Condition]C
		where First(C.code.coding) in "ChemodenervationOfOneExtremity Codes")

define Hyperhidrosis:
	First([Condition]C
		where First(C.code.coding) in "Hyperhidrosis Codes")

define ExtraOcularMuscle:
	First([Condition]C
		where First(C.code.coding) in "ExtraOcularMuscle Codes")

define ChemodenervationOfNeckMuscle:
	First([Condition]C
		where First(C.code.coding) in "ChemodenervationOfNeckMuscle Codes")

define MigraineWithoutAura:
	First([Condition]C
		where First(C.code.coding) in "MigraineWithoutAura Codes")

define Headaches:
	exists([Condition]C
		where First(C.code.coding) in "ChemodenervationOfNeckMuscle Codes")

define Preclusion:
	FHIRHelpers.ToQuantity("ServiceRequest".quantity as Quantity).value


define ServiceCode1:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Parotid and Submandibular salivary glands, Bilateral")
		and ("Sialorrhea" is not null))
	then true
	else false

define ServiceCode2:
	if ((First("ServiceRequest".code.coding) in "Esophagogastroduodenoscopy")
		and ("Esophagoscopy" is not null))
	then true
	else false

define ServiceCode3:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Internal Anal Sphincter")
		and ("AnalFissure" is not null))
	then true
	else false

define ServiceCode4:
	if ((First("ServiceRequest".code.coding) in "Cystourethroscopy, with Injection(s) for Chemodenervation of the Bladder")
		and ("Cystourethroscopy" is not null))
	then true
	else false

define ServiceCode5:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial Nerve,Unilateral")
		and ("Blepharospasm" is not null))
	then true
	else false

define ServiceCode6:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Muscle(s); Neck Muscles(s), Muscles of the Larynx, Unilateral")
		and ("CervicalDystonia" is not null))
	then true
	else false

define ServiceCode7:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of One Extremity, Trunk Muscles(s)")
		and ("ChemodenervationOfOneExtremity" is not null))
	then true
	else false

define ServiceCode8:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Eccrine Glands")
		and ("Hyperhidrosis" is not null))
	then true
	else false

define ServiceCode9:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Extraocular Muscle")
		and ("ExtraOcularMuscle" is not null))
	then true
	else false

define ServiceCode10:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Muscle(s)")
		and ("Headaches" is not null))
	then true
	else false

define ServiceCode11:
	if ((First("ServiceRequest".code.coding) in "Chemodenervation of Muscle(s); Muscle(s) innervated by Facial, Trigeminal, Cervical, Spinal and Accessory Nerves, Bilateral")
		and ("MigraineWithoutAura" is not null))
	then true
	else false
