library PancreasTransplantDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include PancreasTransplant version '1.0.0' called PancreasTransplant

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Beta Cell Autoantibody Test": '2.16.840.1.113883.3.6037.1001.23.98.54'
valueset "Fasting C peptide Test": '2.16.840.1.113883.3.6037.1001.23.98.55'
valueset "Fasting Glucose Test": '2.16.840.1.113883.3.6037.1001.23.98.56'
valueset "Insulinopenia": '2.16.840.1.113883.3.6037.1001.23.98.57'
valueset "Labile brittle diabetes mellitus": '2.16.840.1.113883.3.6037.1001.23.98.58'
valueset "Insulin dependent diabetes mellitus": '2.16.840.1.113883.3.6037.1001.23.98.59'
valueset "Hypoglycemia unawareness": '2.16.840.1.113883.3.6037.1001.23.98.60'
valueset "Ketoacidosis": '2.16.840.1.113883.3.6037.1001.23.98.61'
valueset "Type 1 Diabetes ICD10": '2.16.840.1.113883.3.464.1003.103.11.1026'
valueset "Type 1 Diabetes SNOMEDCT": '2.16.840.1.113883.3.464.1003.103.11.1027'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define QA21:
	("QT".item I
		where I.linkId.value = '2.1')QR
		return First(QR.answer).value

define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

define QA23:
	("QT".item I
		where I.linkId.value = '2.3')QR
		return First(QR.answer).value

define QA24:
	("QT".item I
		where I.linkId.value = '2.4')QR
		return First(QR.answer).value

define QA25:
	("QT".item I
		where I.linkId.value = '2.5')QR
		return First(QR.answer).value

define QA16:
	("QT".item I
		where I.linkId.value = '1.6')QR
		return First(QR.answer).value

define "Type1DiabetesCondition":
  PancreasTransplant."Type1DiabetesCondition"

define "BCATest":
  if Last(PancreasTransplant."BCATest") is not null
  then true
  else false

define "CPeptideTestLowerLimit":
  PancreasTransplant."CPeptideTest" P
  return First(P.referenceRange).low.value

define "CPeptideTest":
  PancreasTransplant."CPeptideResult".value <= "CPeptideTestLowerLimit"*1.1

define "DiabeticAssessment":
  if (Last("Type1DiabetesCondition") is not null
    and (("BCATest"=true)
      or (("CPeptideTest"=true)
        and (Last(PancreasTransplant."InsulinopeniaCondition") is not null)
        and PancreasTransplant."GlucoseTestResult".value<=225)
      )
  )
  then true
  else false

define "OtherComplicationsAssessment":
  if Last(PancreasTransplant."BrittleLabileDiabetesCondition") is not null
    and Last(PancreasTransplant."InsulinDependentDiabetesCondition") is not null
    and Last(PancreasTransplant."OtherComplicationsResources") is not null
    and First("QA16") = true
  then true
  else false

define "FinalDecision":
	if ("DiabeticAssessment"=true
      and "OtherComplicationsAssessment"=true
      and First("QA21")=true
      and First("QA22")=true
      and First("QA23")>12
      and First("QA24")=true
      and First("QA25")=true)
	then 'YES'
	else 'NO'