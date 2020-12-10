library CryosurgeryofProstateDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include CryosurgeryofProstate version '1.0.0' called CryosurgeryofProstate

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Malignant neoplasm of prostate": '2.16.840.1.113883.3.6037.1001.23.97.0'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Tumor Stage T2b or below": '2.16.840.1.113883.3.6037.1001.23.97.2'
valueset "Radiation Treatment Management": '2.16.840.1.113883.3.6037.1001.23.97.3'
valueset "Gleason score": '2.16.840.1.113883.3.6037.1001.23.97.4'
valueset "Prostate specific Ag": '2.16.840.1.113883.3.6037.1001.23.97.5'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define QA14:
	("QT".item I
		where I.linkId.value = '1.4')QR
		return First(QR.answer).value

define RadiationTherapy:
	CryosurgeryofProstate."RadiationTherapyResource"

define TumorStage:
	CryosurgeryofProstate."TumorStageResource"

define GleasonScore:
	CryosurgeryofProstate."GleasonScoreResource"

define ProstateSpecificAntigen:
	CryosurgeryofProstate."ProstateSpecificAntigenResource"

define AssessmentCriteria:
	if ((First("QA14") = true )
			and exists("RadiationTherapy" P where First(P.outcome.coding) in "Procedure Unsuccessful"))
	then true
	else false

define ObservationCriteria:
	if (exists("TumorStage" P where (First(First(P.stage).summary.coding) in "Tumor Stage T2b or below"))
		or exists("ProstateSpecificAntigen" A where FHIRHelpers.ToQuantity(A.value).value < 8)
		or exists("GleasonScore" G where FHIRHelpers.ToQuantity(G.value).value < 9))
	then true
	else false

define PrimaryDecision:
	if (("AssessmentCriteria" = true) and ("ObservationCriteria" = true))
	then true
	else false
	
define FinalDecision:
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'NO'
