library ColorectalCancerScreeningDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ColorectalCancerScreening version '1.0.0' called CCST

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Fecal Occult Blood Tests": '2.16.840.1.113883.3.6037.1001.23.98.0'
valueset "Lower gastrointestinal pain": '2.16.840.1.113883.3.6037.1001.23.98.1'
valueset "Adenomatous polyps": '2.16.840.1.113883.3.6037.1001.23.98.2'
valueset "Colorectal cancer": '2.16.840.1.113883.3.6037.1001.23.98.3'
valueset "Inflammatory bowel disease": '2.16.840.1.113883.3.6037.1001.23.98.4'
valueset "Crohn’s Disease": '2.16.840.1.113883.3.6037.1001.23.98.5'
valueset "Family history of colonic polyps": '2.16.840.1.113883.3.6037.1001.23.98.6'
valueset "Hereditary nonpolyposis colorectal cancer": '2.16.840.1.113883.3.6037.1001.23.98.7'
valueset "The CologuardTM - Multitarget Stool DNA (sDNA)": '2.16.840.1.113883.3.6037.1001.23.98.8'
valueset "CT Colonography": '2.16.840.1.113883.3.464.1003.108.12.1038'
valueset "Fecal Occult Blood": '2.16.840.1.113883.3.6037.1001.23.98.10'
valueset "Blood in stool": '2.16.840.1.113883.3.6037.1001.23.98.11'
valueset "Blood Relationship": '2.16.840.1.113883.3.6037.1001.23.98.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define FecalOccultBloodTests:
	CCST."FecalOccultBloodTests"

define "FOBTPerformedDifference":
	difference in days between end of CCST."Normalize Interval Observation"("FecalOccultBloodTests".effective)
	and Today() >= 365

define "FOBTPatientAgeGreaterThan50":
	AgeInYearsAt(Today())>= 50

define "CologuardServiceRequestTest":
	"ServiceRequest"P where First(P.code.coding) in "The CologuardTM - Multitarget Stool DNA (sDNA)"

define "FOBTServiceRequestTest":
	"ServiceRequest"P where First(P.code.coding) in "Fecal Occult Blood Tests"

define "MultitargetStoolDNATest":
	CCST."MultitargetStoolDNATest"

define "CologuardPerformedDifference":
	difference in days between end of CCST."Normalize Interval Observation"("MultitargetStoolDNATest".effective)
	and Today() >= 1095

define "CologuardPatientAgeGreaterThan50":
	AgeInYearsAt(Today())>= 50
		and AgeInYearsAt(Today())<=85

define "FOBTObservation":
	CCST."FOBTObservation"

define "FOBTPositive":
	"FOBTObservation" O
	with "FecalOccultBloodTests".result R
	such that R.reference.value = 'Observation/'+O.id.value

define "ColorectalCancer":
	CCST."ColorectalCancer"

define "LowerGastrointestinalPain":
	CCST."LowerGastrointestinalPain"

define "BloodInStool":
	CCST."BloodInStool"

define "AdenomatousPolyps":
	CCST."AdenomatousPolyps"

define "InflammatoryBowelDisease":
	CCST."InflammatoryBowelDisease"

define "CrohnsDisease":
	CCST."CrohnsDisease"

//Family Member Diagnosis History
define "Q24":
	("QT".item I
		where I.linkId.value = '2.4')QR
		return (QR.answer)


define "AsymptomaticAssessment":
	if (Last("LowerGastrointestinalPain") is null and Last("BloodInStool") is null and Last(FOBTPositive) is null)
	then true
	else false

define "PersonalHistoryAssessment":
	if (Last("AdenomatousPolyps") is null
		and Last("ColorectalCancer") is null
		and Last("InflammatoryBowelDisease") is null
		and Last("CrohnsDisease") is null)
	then true
	else false

define "FamilyMemberDiagnosisHistory":
	CCST."FamilyMemberDiagnosisHistory"

define "CTCProcedure":
	CCST."CTCProcedure"

define "FamilyHistoryAssessment":
	if (Last("FamilyMemberDiagnosisHistory") is null and not exists("Q24"))
	then true
	else false

define "FOBTSymptomsAssessment":
	if (Last("AdenomatousPolyps") is not null
			or Last("ColorectalCancer") is not null
			or Last("InflammatoryBowelDisease") is not null
			or Last("CrohnsDisease") is not null
			or "FamilyHistoryAssessment" =true)
	then true
	else false

define "FOBTAssessment":
	if ("FOBTPerformedDifference"
		and "FOBTPatientAgeGreaterThan50"
		and "FOBTSymptomsAssessment")
	then true
	else false

define "CologuardAssessment":
	if ("CologuardPatientAgeGreaterThan50"
		and "CologuardPerformedDifference"
		and "AsymptomaticAssessment"
		and ("PersonalHistoryAssessment"
					and "FamilyHistoryAssessment")
		)
	then true
	else false

define FinalDecision:
	if ("FOBTServiceRequestTest" is not null)
	then (if "FOBTAssessment" and "CTCProcedure" is null then 'YES'
				else 'NO')
	else
	if ("CologuardServiceRequestTest" is not null)
	then (if "CologuardAssessment" and "CTCProcedure" is null then 'YES'
				else 'NO')
	else 'NO'
