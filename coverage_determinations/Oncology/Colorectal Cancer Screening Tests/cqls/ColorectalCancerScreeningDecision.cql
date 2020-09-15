library ColorectalCancerScreeningDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ColorectalCancerScreening version '1.0.0' called CCS

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
valueset "Screening computed tomographic colonography (CTC)": '2.16.840.1.113883.3.6037.1001.23.98.9'
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
	Last([DiagnosticReport]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Fecal Occult Blood Tests"
		sort by end of CCS."Normalize Interval Observation"(effective)
	)

define "FOBTPerformedDifference":
	difference in days between end of CCS."Normalize Interval Observation"("FecalOccultBloodTests".effective) and
		start of CCS."Normalize Interval Observation"("FOBTServiceRequestTest".occurrence) >= 365

define "FOBTPatientAgeGreaterThan50":
	AgeInYearsAt(start of CCS."Normalize Interval Observation"("FOBTServiceRequestTest".occurrence))>= 50

define "CologuardServiceRequestTest":
	"ServiceRequest"P where First(P.code.coding) in "The CologuardTM - Multitarget Stool DNA (sDNA)"

define "FOBTServiceRequestTest":
	"ServiceRequest"P where First(P.code.coding) in "Fecal Occult Blood Tests"

define "MultitargetStoolDNATest":
	Last([DiagnosticReport]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "The CologuardTM - Multitarget Stool DNA (sDNA)"
		sort by end of CCS."Normalize Interval Observation"(effective))

define "CologuardPerformedDifference":
	difference in days between end of CCS."Normalize Interval Observation"("MultitargetStoolDNATest".effective) and
		start of CCS."Normalize Interval Observation"("CologuardServiceRequestTest".occurrence) >= 1095

define "CologuardPatientAgeGreaterThan50":
	AgeInYearsAt(start of CCS."Normalize Interval Observation"("CologuardServiceRequestTest".occurrence))>= 50
		and AgeInYearsAt(start of CCS."Normalize Interval Observation"("CologuardServiceRequestTest".occurrence))<=85

define "FOBTObservation":
	[Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Fecal Occult Blood"
		and FHIRHelpers.ToConcept(P.value).codes[0].code in {'10828004','POSITIVE'}

define "FOBTPositive":
	"FOBTObservation" O
	with "FecalOccultBloodTests".result R
	such that R.reference.value = 'Observation/'+O.id.value

//Family Member Diagnosis History
define "Q24":
	("QT".item I
		where I.linkId.value = '2.4')QR
		return (QR.answer)


define "AsymptomaticAssessment":
	if (Last(CCS."LowerGastrointestinalPain") is null and Last(CCS."BloodInStool") is null and Last(FOBTPositive) is null)
	then true
	else false

define "PersonalHistoryAssessment":
	if (Last(CCS."AdenomatousPolyps") is null
		and Last(CCS."ColorectalCancer") is null
		and Last(CCS."InflammatoryBowelDisease") is null
		and Last(CCS."CrohnsDisease") is null)
	then true
	else false

define "FamilyHistoryAssessment":
	if (Last(CCS."FamilyMemberDiagnosisHistory") is null and not exists("Q24"))
	then true
	else false

define "FOBTSymptomsAssessment":
	if (Last(CCS."AdenomatousPolyps") is not null
			or Last(CCS."ColorectalCancer") is not null
			or Last(CCS."InflammatoryBowelDisease") is not null
			or Last(CCS."CrohnsDisease") is not null
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
	then (if "FOBTAssessment" and CCS."CTCProcedure" is null then 'YES'
				else 'NO')
	else
	if ("CologuardServiceRequestTest" is not null)
	then (if "CologuardAssessment" and CCS."CTCProcedure" is null then 'YES'
				else 'NO')
	else 'NO'


//define "PatientLinks":
//	Patient.link L where First(Split(L.other.reference.value, '/')) = 'Patient'
//		and L.type.value = 'refer'
//
//define "RelatedPersonLinks":
//	Patient.link L where First(Split(L.other.reference.value, '/')) = 'RelatedPerson'
//		and L.type.value = 'refer'
//
//define "RelatedPersonResources":
//	if exists("RelatedPersonLinks")
//	then ([RelatedPerson]RP
//				with "RelatedPersonLinks"L
//				such that L.other.reference.value = 'RelatedPerson/'+RP.id.value)
//	else null

//define "RelatedPersonPatients":
//	[Patient]P
//	with "RelatedPersonResources"RP
//	such that RP.patient.reference.value = 'Patient/'+P.id.value
//		and exists(RP.relationship R where First(R.coding) in "Blood Relationship")

//define "PatientFamilyMemberHistory":
//	[Condition]C
//	with "PatientLinks" L
//	such that C.subject.reference.value = L.other.reference.value
// 		and (First(C.code.coding) in "Adenomatous polyps"
//					or First(C.code.coding) in "Family history of colonic polyps"
//					or First(C.code.coding) in "Hereditary nonpolyposis colorectal cancer"
//					or First(C.code.coding) in "Colorectal cancer"
//				)
//
//define "RelatedPersonFamilyMemberHistory":
//	[Condition]C
//	with "RelatedPersonPatients" P
//	such that C.subject.reference.value = 'Patient/'+P.id.value
// 		and (First(C.code.coding) in "Adenomatous polyps"
//					or First(C.code.coding) in "Family history of colonic polyps"
//					or First(C.code.coding) in "Hereditary nonpolyposis colorectal cancer"
//					or First(C.code.coding) in "Colorectal cancer"
//				)
