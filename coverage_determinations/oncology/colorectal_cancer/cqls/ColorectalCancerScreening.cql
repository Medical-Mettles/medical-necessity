library ColorectalCancerScreening version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Fecal Occult Blood Tests": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.0'
valueset "Lower gastrointestinal pain": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.1'
valueset "Adenomatous polyps": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.2'
valueset "Colorectal cancer": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.3'
valueset "Inflammatory bowel disease": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.4'
valueset "Crohn’s Disease": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.5'
valueset "Family history of colonic polyps": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.6'
valueset "Hereditary nonpolyposis colorectal cancer": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.7'
valueset "The CologuardTM - Multitarget Stool DNA (sDNA)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.8'
valueset "CT Colonography": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1038'
valueset "Fecal Occult Blood": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.10'
valueset "Blood in stool": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.11'
valueset "Blood Relationship": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.98.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "MultitargetStoolDNATest":
	Last([DiagnosticReport]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "The CologuardTM - Multitarget Stool DNA (sDNA)"
		sort by end of "Normalize Interval Observation"(effective))

define "FecalOccultBloodTests":
	Last([DiagnosticReport]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Fecal Occult Blood Tests"
		sort by end of "Normalize Interval Observation"(effective)
	)


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
	end of "Normalize Interval Observation"("DiagnosticReportResource".effective)

define "ExpectedDate":
	start of "Normalize Interval Observation"("ServiceRequestResource".occurrence)

define "FOBTObservation":
	[Observation]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Fecal Occult Blood"
		and FHIRHelpers.ToConcept(P.value).codes[0].code in {'10828004','POSITIVE'}

define "FOBTPositive":
	"FOBTObservation" O
	with "FecalOccultBloodTests".result R
	such that R.reference.value = 'Observation/'+O.id.value

define "LowerGastrointestinalPain":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding) in "Lower gastrointestinal pain"

define "BloodInStool":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.code.coding) in "Blood in stool"

define "Symptom1":
	if Last("LowerGastrointestinalPain") is not null then 'Lower Gastrointestinal Pain' else ''

define "Symptom2":
	if Last("BloodInStool") is not null then ', Blood In Stool' else ''

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

define "AdenomatousPolyps":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.code.coding) in "Adenomatous polyps"

define "InflammatoryBowelDisease":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.code.coding) in "Inflammatory bowel disease"

define "CrohnsDisease":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.code.coding) in "Crohn’s Disease"

define "ColorectalCancer":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.code.coding) in "Colorectal cancer"

define "Condition1":
	if exists("AdenomatousPolyps") then 'Adenomatous Polyps' else ''

define "Condition2":
	if exists("InflammatoryBowelDisease")  then ', Inflammatory Bowel Disease' else ''

define "Condition3":
	if exists("CrohnsDisease") then ', Crohns Disease' else ''

define "Condition4":
	if exists("ColorectalCancer") then ', Colorectal Cancer' else ''

define "PersonalHistoryFinal":
	"Condition1"+ "Condition2"+ "Condition3"+ "Condition4"

define "PersonalHistory":
	if Length("PersonalHistoryFinal")>0
	then (if "PersonalHistoryFinal"[0] = ','
				then Substring("PersonalHistoryFinal", 2, Length("PersonalHistoryFinal")-1)
				else "PersonalHistoryFinal")
	else ''

define "FamilyMemberDiagnosisHistory":
	if exists([FamilyMemberHistory])
	then ([FamilyMemberHistory]F
		where F.patient.reference.value = 'Patient/'+ Patient.id.value
		and (F.relationship R where First(R.coding) in "Blood Relationship") is not null
		and exists(F.condition FC where First(FC.code.coding) in "Adenomatous polyps"
						or First(FC.code.coding) in "Family history of colonic polyps"
						or First(FC.code.coding) in "Hereditary nonpolyposis colorectal cancer"
						or First(FC.code.coding) in "Colorectal cancer"
				))
	else null

define "FamilyHistory":
	if Last("FamilyMemberDiagnosisHistory") is not null
	then "FamilyMemberDiagnosisHistory"
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

define "CTCProcedure":
	Last(
	[DiagnosticReport]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "CT Colonography")

define "FamilyMemberHistory":
	{if "Adenomatous Polyps Resource" then 'Adenomatous Polyps' else '',
		if "Colonic Polyps Resource" then 'Colonic Polyps' else '',
		if "Hereditary Nonpolyposis Colorectal Cancer Resource" then 'Nonpolyposis Colorectal Cancer' else '',
		if "Colorectal Cancer Resource" then 'Colorectal Cancer' else ''}

define "ScreeningCTC":
	if "CTCProcedure" is not null
	then 'Screening computed tomographic colonography (CTC)'
	else ''

define function "Normalize Interval Observation"(choice Choice<FHIR.dateTime, FHIR.Period>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
	  else null
