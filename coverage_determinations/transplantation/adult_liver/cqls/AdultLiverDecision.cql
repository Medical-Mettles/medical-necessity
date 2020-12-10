library AdultLiverDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include AdultLiverTransplant version '1.0.0' called ALT

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Primary Diagnoses- Adult Liver Transplant": '2.16.840.1.113883.3.6037.1001.23.98.79'
valueset "End Stage Liver Disease": '2.16.840.1.113883.3.6037.1001.23.98.80'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Liver bodysite": '2.16.840.1.113883.3.6037.1001.23.98.82'
valueset "Hepatocellular carcinoma": '2.16.840.1.113883.3.6037.1001.23.98.83'

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

define "EndStageCondition":
  ALT."EndStageCondition"

define "Malignancies":
  ALT."Malignancies"

define "CarcinomaCondition":
  ALT."CarcinomaCondition"

define "LiverCellCarcinoma":
	if First("CarcinomaCondition") is not null
	then true
	else false

define "TumorSizeObservation":
  ALT."TumorSizeObservation"

define "SizeofTumor":
  if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'mm'
	then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value/10
  else (if FHIRHelpers.ToQuantity("TumorSizeObservation".value).unit = 'cm'
        then FHIRHelpers.ToQuantity("TumorSizeObservation".value).value
        else 0)

define "DiagnosesAssessment":
  if Last("EndStageCondition") is not null
    or Last("Malignancies") is not null
  then true
  else false

define "OtherAssessments":
  if ("LiverCellCarcinoma"=true
      and "SizeofTumor"<=5
      and First("QA21")=false
      and First("QA22")=false
      and First("QA23")=false)
	then true
	else false

define "FinalDecision":
	if (("DiagnosesAssessment"=true
        or "OtherAssessments"=true)
      and First("QA24")=true)
	then 'YES'
	else 'NO'