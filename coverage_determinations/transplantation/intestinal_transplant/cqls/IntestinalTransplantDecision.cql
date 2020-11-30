library IntestinalTransplantDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include IntestinalTransplant version '1.0.0' called IntestinalTransplant

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Total parenteral nutrition therapy": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.28'
valueset "Liver injury": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.29'
valueset "Liver failure": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.30'
valueset "Liver injury clinical manifestations": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.31'
valueset "Thrombosis of jugular, subclavian, and femoral veins": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.32'
valueset "Thrombolysis contraindication": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.33'
valueset "Sequelae of venous thrombosis": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.34'
valueset "Line infection or sepsis": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.35'
valueset "Other Sepsis Conditions": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.38'
valueset "Frequent episodes of severe dehydration": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.36'
valueset "Intestinal and Multi-Visceral Transplantation": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.37'
valueset "Procedure Unsuccessful": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Procedure for Medication Administration": 'https://ValueSet/2.16.840.1.113883.3.6037.1001.23.96.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define QT:
	"QuestionnaireResponse".item

define QA13:
	("QT".item I
		where I.linkId.value = '1.3')QR
		return First(QR.answer).value

define QA22:
	("QT".item I
		where I.linkId.value = '2.2')QR
		return First(QR.answer).value

define "LiverFailureResource":
	IntestinalTransplant."LiverFailureResource"

define "LiverComplicationsDueToTPN":
  IntestinalTransplant."LiverComplicationsDueToTPN"

define "SequelaeOfThrombosisResource":
  IntestinalTransplant."SequelaeOfThrombosisResource"

define "ThrombosisDueToTPN":
  IntestinalTransplant."ThrombosisDueToTPN"

define "LineInfectionResource":
  IntestinalTransplant."LineInfectionResource"

define "OtherSepsisResource":
	IntestinalTransplant."OtherSepsisResource"

define "SepsisDueToTPN":
  IntestinalTransplant."SepsisDueToTPN"

define "DehydrationDueToTPN":
  IntestinalTransplant."DehydrationDueToTPN"

define "LiverFailureAssessment":
  if (First("LiverComplicationsDueToTPN") is not null
    and First("LiverFailureResource") is not null)
  then true
  else false

define "DehydrationAssessment":
  if (First("DehydrationDueToTPN") is not null)
  then true
  else false

define "SepsisAssessment":
  if (First("SepsisDueToTPN") is not null
    and Count("LineInfectionResource")>1
    and Count("OtherSepsisResource")>0)
  then true
  else false

define "ThrombosisAssessment":
  if (First("ThrombosisDueToTPN") is not null
    and First("SequelaeOfThrombosisResource") is not null
    and First("QA13")>1)
  then true
  else false

define "TPNFailureAssessment":
  if ("LiverFailureAssessment"=true)
    or ("ThrombosisAssessment"=true)
    or ("SepsisAssessment"=true)
    or ("DehydrationAssessment"=true)
  then true
  else false

define "FinalDecision":
	if ("TPNFailureAssessment"=true
      and First("QA22")=true)
	then 'YES'
	else 'NO'