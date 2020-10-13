library ColorectalCancerScreening version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ColorectalCancerScreeningDecision version '1.0.0' called CCSD

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

define "MultitargetStoolDNATest":
	CCSD."MultitargetStoolDNATest"

define "FecalOccultBloodTests":
	CCSD."FecalOccultBloodTests"

define "CologuardServiceRequestTest":
	"ServiceRequest"P where First(P.code.coding) in "The CologuardTM - Multitarget Stool DNA (sDNA)"

define "FOBTServiceRequestTest":
	"ServiceRequest"P where First(P.code.coding) in "Fecal Occult Blood Tests"

define "ServiceRequestResource":
	if "FOBTServiceRequestTest" is not null
	then "FOBTServiceRequestTest"
	else (if "CologuardServiceRequestTest" is not null
				then "CologuardServiceRequestTest"
				else null)

define "DiagnosticReportResource":
	if First("MultitargetStoolDNATest".code.coding) = First("ServiceRequestResource".code.coding)
			then "MultitargetStoolDNATest"
			else (if First("FecalOccultBloodTests".code.coding) = First("ServiceRequestResource".code.coding)
						then "FecalOccultBloodTests"
						else null)

define "TypeOfTest":
	if "ServiceRequestResource" is not null
	then "ServiceRequestResource".code.coding[0].display.value
	else ''

define "LastPerformedDate":
	end of CCSD."Normalize Interval Observation"("DiagnosticReportResource".effective)

define "ExpectedDate":
	start of CCSD."Normalize Interval Observation"("ServiceRequestResource".occurrence)

define "FOBTObservation":
	CCSD."FOBTObservation"

define "FOBTPositive":
	"FOBTObservation" O
	with "FecalOccultBloodTests".result R
	such that R.reference.value = 'Observation/'+O.id.value

define "Symptom1":
	if Last(CCSD."LowerGastrointestinalPain") is not null then 'Lower Gastrointestinal Pain' else ''

define "Symptom2":
	if Last(CCSD."BloodInStool") is not null then ', Blood In Stool' else ''

define "SymptomsFinal":
	"Symptom1"+"Symptom2"

define "Symptoms":
	if Length("SymptomsFinal")>0
	then (if "SymptomsFinal"[0] = ','
				then Substring("SymptomsFinal", 2, Length("SymptomsFinal")-1)
				else "SymptomsFinal")
	else ''

define "TestsPerformed":
	if Last("FOBTPositive")  is not null then 'Positive Fecal Occult Blood Test' else ''

define "Condition1":
	if exists(CCSD."AdenomatousPolyps") then 'Adenomatous Polyps' else ''

define "Condition2":
	if exists(CCSD."InflammatoryBowelDisease")  then ', Inflammatory Bowel Disease' else ''

define "Condition3":
	if exists(CCSD."CrohnsDisease") then ', Crohns Disease' else ''

define "Condition4":
	if exists(CCSD."ColorectalCancer") then ', Colorectal Cancer' else ''

define "PersonalHistoryFinal":
	"Condition1"+ "Condition2"+ "Condition3"+ "Condition4"

define "PersonalHistory":
	if Length("PersonalHistoryFinal")>0
	then (if "PersonalHistoryFinal"[0] = ','
				then Substring("PersonalHistoryFinal", 2, Length("PersonalHistoryFinal")-1)
				else "PersonalHistoryFinal")
	else ''

define "FamilyHistory":
	if Last(CCSD."FamilyMemberDiagnosisHistory") is not null
	then CCSD."FamilyMemberDiagnosisHistory"
	else null

define "Adenomatous Polyps Resource":
	if Last("FamilyHistory" F
			where Last(F.condition FC where First(FC.code.coding) in "Adenomatous polyps") is not null) is not null
	then true
	else false

define "Colonic Polyps Resource":
	if Last("FamilyHistory" F
			where Last(F.condition FC where First(FC.code.coding) in "Family history of colonic polyps") is not null) is not null
	then true
	else false

define "Hereditary Nonpolyposis Colorectal Cancer Resource":
	if Last("FamilyHistory" F
			where Last(F.condition FC where First(FC.code.coding) in "Hereditary nonpolyposis colorectal cancer") is not null) is not null
	then true
	else false

define "Colorectal Cancer Resource":
	if Last("FamilyHistory" F
			where Last(F.condition FC where First(FC.code.coding) in "Colorectal cancer") is not null) is not null
	then true
	else false

define "FamilyMemberHistory":
	{if "Adenomatous Polyps Resource" then 'Adenomatous Polyps' else '',
		if "Colonic Polyps Resource" then 'Colonic Polyps' else '',
		if "Hereditary Nonpolyposis Colorectal Cancer Resource" then 'Nonpolyposis Colorectal Cancer' else '',
		if "Colorectal Cancer Resource" then 'Colorectal Cancer' else ''}

define "ScreeningCTC":
	if CCSD."CTCProcedure" is not null
	then 'Screening computed tomographic colonography (CTC)'
	else ''

