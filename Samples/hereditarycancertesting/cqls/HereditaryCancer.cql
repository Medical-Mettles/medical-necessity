library HereditaryCancer version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Blood Relationship": '2.16.840.1.113883.3.6037.1001.23.98.12'
valueset "Breast Cancer": '2.16.840.1.113883.3.1434.1000.1095'
valueset "Bone marrow transplant ICD10PCS": '2.16.840.1.113883.3.666.5.404'
valueset "Blood Transfusion Administration": '2.16.840.1.113762.1.4.1029.209'
valueset "Bone Marrow Transplant SNOMED CT": '2.16.840.1.113883.3.666.5.335'
valueset "Cancer": '2.16.840.1.113883.3.526.3.1010'
valueset "Prostate Cancer": '2.16.840.1.113883.3.526.3.319'
valueset "Ovarian Cancer": '2.16.840.1.113762.1.4.1116.535'
valueset "Colorectal Cancer": '2.16.840.1.113762.1.4.1116.255'
valueset "Breast Cancer Triple Negative": '2.16.840.1.113883.3.6037.1001.23.98.23'
valueset "Colonic polyps": '2.16.840.1.113883.3.6037.1001.23.98.25'
valueset "Ductal carcinoma in situ": '2.16.840.1.113883.3.6037.1001.23.98.24'
valueset "Endometrial Cancer": '2.16.840.1.113883.3.6037.1001.23.98.26'
valueset "Genetic Counseling": '2.16.840.1.113883.3.6037.1001.23.98.21'
valueset "Pancreatic Cancer": '2.16.840.1.113883.3.6037.1001.23.98.27'
valueset "Renal Cancer": '2.16.840.1.113883.3.6037.1001.23.98.28'
valueset "Stem Cell Transplant": '2.16.840.1.113883.3.6037.1001.23.98.22'
valueset "BRCA1/2 Comprehensive Analysis": '2.16.840.1.113883.3.6037.1001.23.98.20'
valueset "Comprehensive Test- 27 genes": '2.16.840.1.113883.3.6037.1001.23.98.29'
valueset "Comprehensive Test Without BRCA- 25 genes": '2.16.840.1.113883.3.6037.1001.23.98.30'
valueset "Breast- 19 genes": '2.16.840.1.113883.3.6037.1001.23.98.31'
valueset "Breast- 9 genes": '2.16.840.1.113883.3.6037.1001.23.98.32'
valueset "Breast and Gyn- 25 genes": '2.16.840.1.113883.3.6037.1001.23.98.33'
valueset "Gyn- 11 genes": '2.16.840.1.113883.3.6037.1001.23.98.34'
valueset "Colorectal- 7 genes": '2.16.840.1.113883.3.6037.1001.23.98.35'
valueset "Colorectal- 22 genes": '2.16.840.1.113883.3.6037.1001.23.98.36'
valueset "Pancreatic- 14 genes": '2.16.840.1.113883.3.6037.1001.23.98.37'
valueset "Endocrine- 13 genes": '2.16.840.1.113883.3.6037.1001.23.98.38'
valueset "Renal- 19 genes": '2.16.840.1.113883.3.6037.1001.23.98.39'
valueset "Brain/CNS/PNS - 17 Genes": '2.16.840.1.113883.3.6037.1001.23.98.40'
valueset "MSI Test": '2.16.840.1.113883.3.6037.1001.23.98.41'
valueset "IHC Test": '2.16.840.1.113883.3.6037.1001.23.98.42'
valueset "BRCA1/2 Ashkenazi Jewish Profile": '2.16.840.1.113883.3.6037.1001.23.98.43'
valueset "BRCA1/2 Deletion/Duplication Analysis": '2.16.840.1.113883.3.6037.1001.23.98.44'
valueset "BRCA1 Targeted Analysis": '2.16.840.1.113883.3.6037.1001.23.98.45'
valueset "BRCA2 Targeted Analysis": '2.16.840.1.113883.3.6037.1001.23.98.46'
valueset "Gleason score": '2.16.840.1.113883.3.6037.1001.23.97.4'
valueset "Metastatic Cancer": '2.16.840.1.113883.3.6037.1001.23.98.47'
valueset "Paternal Blood Relationship": '2.16.840.1.113883.3.6037.1001.23.98.48'
valueset "Maternal Blood Relationship": '2.16.840.1.113883.3.6037.1001.23.98.49'
valueset "Premenopausal Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.98.50'
valueset "Left Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.98.51'
valueset "Right Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.98.52'
valueset "Triple Negative Breast Cancer": '2.16.840.1.113883.3.6037.1001.23.98.53'

parameter "ServiceRequest" ServiceRequest

context Patient

define "Gender":
	Patient.gender.value
//	if Patient.gender.value = 'female' then {"code":'female',"display":'Female'}
//	else (if Patient.gender.value = 'male' then {"code":'male',"display":'Male'} else {"code":'',"display":''})

define "Email":
	(First (
  	"Patient".telecom telecom
    		where telecom.system.value = 'email')).value.value

define "ServiceRequestCode":
	"ServiceRequest".code.coding

define "SingleGeneTest":
	{
		(if exists("ServiceRequestCode" P where P in "BRCA1/2 Comprehensive Analysis") then 'BRCA1/2 Comprehensive Analysis' else ''),
		(if exists("ServiceRequestCode" P where P in "BRCA1/2 Ashkenazi Jewish Profile") then 'BRCA1/2 Ashkenazi Jewish Profile' else ''),
		(if exists("ServiceRequestCode" P where P in "BRCA1/2 Deletion/Duplication Analysis") then 'BRCA1/2 Deletion/Duplication Analysis' else ''),
		(if exists("ServiceRequestCode" P where P in "BRCA1 Targeted Analysis") then 'BRCA1 Targeted Analysis' else ''),
		(if exists("ServiceRequestCode" P where P in "BRCA2 Targeted Analysis") then 'BRCA2 Targeted Analysis' else '')
	}

define "MultiGeneTest":
	{
		(if exists("ServiceRequestCode" P where P in "Comprehensive Test- 27 genes") then 'Comprehensive - 27 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Comprehensive Test Without BRCA- 25 genes") then 'Comprehensive w/o BRCA - 25 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Breast- 19 genes") then 'Breast - 19 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Breast- 9 genes") then 'Breast - 9 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Breast and Gyn- 25 genes") then 'Breast & Gyn - 25 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Gyn- 11 genes") then 'Gyn - 11 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Colorectal- 7 genes") then 'Colorectal - 7 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Colorectal- 22 genes") then 'Colorectal - 22 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Pancreatic- 14 genes") then 'Pancreatic - 14 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Endocrine- 13 genes") then 'Endocrine - 13 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Renal- 19 genes") then 'Renal - 19 Genes' else ''),
		(if exists("ServiceRequestCode" P where P in "Brain/CNS/PNS - 17 Genes") then 'Brain/CNS/PNS - 17 Genes' else '')
	}

define "DiagnosticReportSingleGeneTests":
	[DiagnosticReport]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and D.status.value in {'final', 'amended', 'corrected'}
		and exists(D.category category where exists(category.coding x where x.code.value = 'GE'))
		and (exists(D.code.coding x where x in "BRCA1/2 Comprehensive Analysis")
				or exists(D.code.coding x where x in "BRCA1/2 Ashkenazi Jewish Profile")
				or exists(D.code.coding x where x in "BRCA1/2 Deletion/Duplication Analysis")
				or exists(D.code.coding x where x in "BRCA1 Targeted Analysis")
				or exists(D.code.coding x where x in "BRCA2 Targeted Analysis")
				)

define "DiagnosticReportMultiGeneTests":
	[DiagnosticReport]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and D.status.value in {'final', 'amended', 'corrected'}
		and exists(D.category category where exists(category.coding x where x.code.value = 'GE'))
		and (exists(D.code.coding x where x in "Comprehensive Test- 27 genes")
				or exists(D.code.coding x where x in "Comprehensive Test Without BRCA- 25 genes")
				or exists(D.code.coding x where x in "Breast- 19 genes")
				or exists(D.code.coding x where x in "Breast- 9 genes")
				or exists(D.code.coding x where x in "Breast and Gyn- 25 genes")
				or exists(D.code.coding x where x in "Gyn- 11 genes")
				or exists(D.code.coding x where x in "Colorectal- 7 genes")
				or exists(D.code.coding x where x in "Colorectal- 22 genes")
				or exists(D.code.coding x where x in "Pancreatic- 14 genes")
				or exists(D.code.coding x where x in "Endocrine- 13 genes")
				or exists(D.code.coding x where x in "Renal- 19 genes")
				or exists(D.code.coding x where x in "Brain/CNS/PNS - 17 Genes")
				)

define "PreviousTesting":
	if (exists("DiagnosticReportSingleGeneTests") or exists("DiagnosticReportMultiGeneTests"))
	then true
	else false


define "Counseling":
	if exists([Procedure]P
	where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value= 'completed'
 		and exists(P.code.coding x where x in "Genetic Counseling"))
	then true
	else false

define "HistoryOfTransplant":
	if exists([Procedure]P
	where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value= 'completed'
 		and (exists(P.code.coding x where x in "Bone marrow transplant ICD10PCS")
				or exists(P.code.coding x where x in "Bone Marrow Transplant SNOMED CT")
				or exists(P.code.coding x where x in "Stem Cell Transplant")
				)
	)
	then true
	else false

define "BloodTransfusion":
	if exists([Procedure]P
	where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value= 'completed'
 		and exists(P.code.coding x where x in "Blood Transfusion Administration"))
	then true
	else false

define "CancerHistory":
	if exists([Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Cancer"))
	then true
	else false

define "BreastCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and (exists(C.code.coding x where x in "Breast Cancer")
					or exists(C.code.coding x where x in "Ductal carcinoma in situ"))

define "BreastCancer":
	if exists("BreastCancerResource")
	then true
	else false

define "BreastCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("BreastCancerResource").onset))
//	CalendarAgeInYearsAt(DateTime(year from Patient.birthDate.value, month from Patient.birthDate.value, day from Patient.birthDate.value, 0, 0, 0, 0),start of "Normalize Interval"(Last("BreastCancerResource").onset))

define "BreastCancerTypeResource":
	"BreastCancerResource".code.coding

define "LeftBreastCancer":
	First([Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
		and (exists(C.code.coding x where x in "Left Breast Cancer")))

define "RightBreastCancer":
	First([Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
		and (exists(C.code.coding x where x in "Right Breast Cancer")))
			
define "BilateralBreastCancer":
	if (("LeftBreastCancer" is not null) and ("RightBreastCancer" is not null))
	then true
	else false

define "BreastCancerType":
	if ("BilateralBreastCancer" = true)
	then 'Bilateral'
	else
	if (exists("BreastCancerTypeResource" B where B in "Premenopausal Breast Cancer"))
	then 'Premenopausal'
	else 
	if (exists("BreastCancerTypeResource" B where B in "Triple Negative Breast Cancer"))
	then 'Triple negative (ER-,PR-,HER2-)'
	else 'None'
	
define "ColorectalCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Colorectal Cancer")

define "ColorectalCancer":
	if exists("ColorectalCancerResource")
	then true
	else false

define "ColorectalCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("ColorectalCancerResource").onset))

define "MSIResults":
	FHIRHelpers.ToConcept(Last([Observation]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "MSI Test").value).codes[0].display

define "IHCResults":
	FHIRHelpers.ToString(Last([Observation]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "IHC Test").value)

define "ColonPolypsResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Colonic polyps")

define "ColonPolyps":
	if exists("ColonPolypsResource")
	then true
	else false

define "ColonPolypsOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("ColonPolypsResource").onset))

define "PolypsCount":
	Count(Last("ColonPolypsResource").bodySite)

define "OvarianCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Ovarian Cancer")

define "OvarianCancer":
	if exists("OvarianCancerResource")
	then true
	else false

define "OvarianCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("OvarianCancerResource").onset))

define "PancreaticCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Pancreatic Cancer")

define "PancreaticCancer":
	if exists("PancreaticCancerResource")
	then true
	else false

define "PancreaticCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("PancreaticCancerResource").onset))

define "EndometrialCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Endometrial Cancer")

define "EndometrialCancer":
	if exists("EndometrialCancerResource")
	then true
	else false

define "EndometrialCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("EndometrialCancerResource").onset))

define "ProstateCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Prostate Cancer")

define "ProstateCancer":
	if exists("ProstateCancerResource")
	then true
	else false

define "ProstateCancerMetastatic":
	if exists([Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Metastatic Cancer"))
	and "ProstateCancer"
	then true
	else false

define "ProstateCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("ProstateCancerResource").onset))

define GleasonScoreResource:
	Last([Observation]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and P.status.value in {'final', 'amended', 'corrected'}
		and First(P.code.coding) in "Gleason score")

define GleasonScore:
	FHIRHelpers.ToQuantity("GleasonScoreResource".value).value

define "RenalCancerResource":
	[Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Renal Cancer")

define "RenalCancer":
	if exists("RenalCancerResource")
	then true
	else false

define "RenalCancerOnset":
	AgeInYearsAt(start of "Normalize Interval"(Last("RenalCancerResource").onset))

define "CancerType":
	{
		if "BreastCancer" then 'Breast Cancer' else '',
		if "ColorectalCancer" then 'Colorectal Cancer' else '',
		if "ColonPolyps" then 'History of Colon Polyps' else '',
		if "OvarianCancer" then 'Ovarian Cancer' else '',
		if "PancreaticCancer" then 'Pancreatic Cancer' else '',
		if "EndometrialCancer" then 'Endometrial Cancer' else '',
		if "ProstateCancer" then 'Prostate Cancer' else '',
		if "RenalCancer" then 'Renal Cancer' else ''
	}

define "OtherCancer":
	Last([Condition]C
		where C.subject.reference.value = 'Patient/'+ Patient.id.value
			and exists(C.code.coding x where x in "Cancer")
			and not exists(C.code.coding x where x in "Breast Cancer")
			and not exists(C.code.coding x where x in "Prostate Cancer")
			and not exists(C.code.coding x where x in "Ovarian Cancer")
			and not exists(C.code.coding x where x in "Colorectal Cancer")
			and not exists(C.code.coding x where x in "Colonic polyps")
			and not exists(C.code.coding x where x in "Ductal carcinoma in situ")
			and not exists(C.code.coding x where x in "Pancreatic Cancer")
			and not exists(C.code.coding x where x in "Endometrial Cancer")
			and not exists(C.code.coding x where x in "Renal Cancer")).code.coding[0].display.value

define "FamilyMemberDiagnosisHistory":
	if exists([FamilyMemberHistory])
	then ([FamilyMemberHistory]F
		where F.patient.reference.value = 'Patient/'+ Patient.id.value
		and ((F.relationship.coding R where R in "Blood Relationship") is not null)
		and exists(F.condition FC where exists(FC.code.coding x where x in "Cancer")
				)
		)
	else null

define "MaternalRelationship":
	"FamilyMemberDiagnosisHistory" F where ((F.relationship.coding R where R in "Maternal Blood Relationship") is not null)

define "PaternalRelationship":
	"FamilyMemberDiagnosisHistory" F where ((F.relationship.coding R where R in "Paternal Blood Relationship") is not null)

define "NumberOfRelatives":
	Count("FamilyMemberDiagnosisHistory")

define "LimitedFamilyHistory":
	if ("FamilyMemberDiagnosisHistory" is not null)
	then false
	else true

define "Relative1":
	First("FamilyMemberDiagnosisHistory")

define "Relative1Name":
	"Relative1".name.value

define "R1MaternalPaternal":
	if ("Relative1".relationship.coding R where R in "Maternal Blood Relationship") is not null
	then 'Maternal'
	else (if ("Relative1".relationship.coding R where R in "Paternal Blood Relationship") is not null
				then 'Paternal'
				else '')

define "R1CancerTypeCondition":
	"Relative1".condition

define "R1CancerType":
	{
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Breast Cancer")) is not null then 'Breast Cancer' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Colorectal Cancer")) is not null then 'Colorectal Cancer' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Colonic polyps")) is not null then 'History of Colon Polyps' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Ovarian Cancer")) is not null then 'Ovarian Cancer' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Pancreatic Cancer")) is not null then 'Pancreatic Cancer' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Endometrial Cancer")) is not null then 'Endometrial Cancer' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Prostate Cancer")) is not null then 'Prostate Cancer' else ''),
		(if First("R1CancerTypeCondition" C where exists(C.code.coding x where x in "Renal Cancer")) is not null then 'Renal Cancer' else ''),
		(if First("R1OtherCancer") is not null then 'Other Cancer' else '')
	}

define "R1OtherCancer":
	"R1CancerTypeCondition" C
		where exists(C.code.coding x where x in "Cancer")
			and not exists(C.code.coding x where x in "Breast Cancer")
			and not exists(C.code.coding x where x in "Prostate Cancer")
			and not exists(C.code.coding x where x in "Ovarian Cancer")
			and not exists(C.code.coding x where x in "Colorectal Cancer")
			and not exists(C.code.coding x where x in "Colonic polyps")
			and not exists(C.code.coding x where x in "Ductal carcinoma in situ")
			and not exists(C.code.coding x where x in "Pancreatic Cancer")
			and not exists(C.code.coding x where x in "Endometrial Cancer")
			and not exists(C.code.coding x where x in "Renal Cancer")

define "R1CancerOnsetAge":
	CalculateAgeInYearsAt(FHIRHelpers.ToDate("Relative1".born),start of "Normalize Interval"(First("R1CancerTypeCondition").onset))

define "Relative2":
	if "NumberOfRelatives">1
	then "FamilyMemberDiagnosisHistory"[1]
	else null

define "Relative3":
	if "NumberOfRelatives">2
	then "FamilyMemberDiagnosisHistory"[2]
	else null

define "Relative2Name":
	"Relative2".name.value

define "R2MaternalPaternal":
	if ("Relative2".relationship.coding R where R in "Maternal Blood Relationship") is not null
	then 'Maternal'
	else (if ("Relative2".relationship.coding R where R in "Paternal Blood Relationship") is not null
				then 'Paternal'
				else '')

define "R2CancerTypeCondition":
	"Relative2".condition

define "R2CancerType":
	{
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Breast Cancer")) is not null then 'Breast Cancer' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Colorectal Cancer")) is not null then 'Colorectal Cancer' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Colonic polyps")) is not null then 'History of Colon Polyps' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Ovarian Cancer")) is not null then 'Ovarian Cancer' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Pancreatic Cancer")) is not null then 'Pancreatic Cancer' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Endometrial Cancer")) is not null then 'Endometrial Cancer' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Prostate Cancer")) is not null then 'Prostate Cancer' else ''),
		(if First("R2CancerTypeCondition" C where exists(C.code.coding x where x in "Renal Cancer")) is not null then 'Renal Cancer' else ''),
		(if First("R2OtherCancer") is not null then 'Other Cancer' else '')
	}

define "R2OtherCancer":
	"R2CancerTypeCondition" C
		where exists(C.code.coding x where x in "Cancer")
			and not exists(C.code.coding x where x in "Breast Cancer")
			and not exists(C.code.coding x where x in "Prostate Cancer")
			and not exists(C.code.coding x where x in "Ovarian Cancer")
			and not exists(C.code.coding x where x in "Colorectal Cancer")
			and not exists(C.code.coding x where x in "Colonic polyps")
			and not exists(C.code.coding x where x in "Ductal carcinoma in situ")
			and not exists(C.code.coding x where x in "Pancreatic Cancer")
			and not exists(C.code.coding x where x in "Endometrial Cancer")
			and not exists(C.code.coding x where x in "Renal Cancer")

define "R2CancerOnsetAge":
	CalculateAgeInYearsAt(FHIRHelpers.ToDate("Relative2".born),start of "Normalize Interval"(First("R2CancerTypeCondition").onset))

define "Relative3Name":
	"Relative3".name.value

define "R3MaternalPaternal":
	if ("Relative3".relationship.coding R where R in "Maternal Blood Relationship") is not null
	then 'Maternal'
	else (if ("Relative3".relationship.coding R where R in "Paternal Blood Relationship") is not null
				then 'Paternal'
				else '')

define "R3CancerTypeCondition":
	"Relative3".condition

define "R3CancerType":
	{
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Breast Cancer")) is not null then 'Breast Cancer' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Colorectal Cancer")) is not null then 'Colorectal Cancer' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Colonic polyps")) is not null then 'History of Colon Polyps' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Ovarian Cancer")) is not null then 'Ovarian Cancer' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Pancreatic Cancer")) is not null then 'Pancreatic Cancer' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Endometrial Cancer")) is not null then 'Endometrial Cancer' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Prostate Cancer")) is not null then 'Prostate Cancer' else ''),
		(if First("R3CancerTypeCondition" C where exists(C.code.coding x where x in "Renal Cancer")) is not null then 'Renal Cancer' else ''),
		(if First("R3OtherCancer") is not null then 'Other Cancer' else '')
	}

define "R3OtherCancer":
	"R3CancerTypeCondition" C
		where exists(C.code.coding x where x in "Cancer")
			and not exists(C.code.coding x where x in "Breast Cancer")
			and not exists(C.code.coding x where x in "Prostate Cancer")
			and not exists(C.code.coding x where x in "Ovarian Cancer")
			and not exists(C.code.coding x where x in "Colorectal Cancer")
			and not exists(C.code.coding x where x in "Colonic polyps")
			and not exists(C.code.coding x where x in "Ductal carcinoma in situ")
			and not exists(C.code.coding x where x in "Pancreatic Cancer")
			and not exists(C.code.coding x where x in "Endometrial Cancer")
			and not exists(C.code.coding x where x in "Renal Cancer")

define "R3CancerOnsetAge":
	CalculateAgeInYearsAt(FHIRHelpers.ToDate("Relative3".born),start of "Normalize Interval"(First("R3CancerTypeCondition").onset))

define "R1Mutation":
	if exists("R1CancerTypeCondition")
	then true
	else false

define "R2Mutation":
	if exists("R2CancerTypeCondition")
	then true
	else false

define "R3Mutation":
	if exists("R3CancerTypeCondition")
	then true
	else false

define function "Normalize Interval"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else null