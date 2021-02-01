library BreastsCancerChemoDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include BreastsCancerChemo version '1.0.0' called BCChemo

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Breast Cancer": '2.16.840.1.113883.3.1434.1000.1095'
valueset "Estrogen Receptor Positive": '2.16.840.1.113762.1.4.1116.320'
valueset "Breast Cancer ER or PR Positive": '2.16.40.1.113883.3.526.2.1387'
valueset "Breast Cancer Primary Tumor Size T1": '2.16.840.1.113883.3.526.3.1305'
valueset "Breast Cancer Primary Tumor Size T1a": '2.16.840.1.113883.3.526.3.1164'
valueset "Breast Cancer Regional Lymph Node Status N0": '2.16.840.1.113883.3.526.3.1310'
valueset "Breast Distant Metastasis Status M0": '2.16.840.1.113883.3.526.3.1302'
valueset "HER2 Presence in Tissue": '2.16.840.1.113883.3.1444.5.207'
valueset "Docetaxel, Carboplatin and Trastuzumab Chemotherapy drugs": '2.16.840.1.113883.3.6037.1001.23.96.13'
valueset "Chemotherapy drugs allergy": '2.16.840.1.113883.3.6037.1001.23.96.14'
valueset "Cardiac Disease": '2.16.840.1.113762.1.4.1029.341'
valueset "Chronic Obstructive Pulmonary Diseases": '2.16.840.1.113883.17.4077.3.2063'
valueset "Liver Disease": '	2.16.840.1.113762.1.4.1047.42'
valueset "Renal Disease": '2.16.840.1.113762.1.4.1029.335'
valueset "Bleeding Disorder": '2.16.840.1.113762.1.4.1029.287'
valueset "Tumor size": '2.16.840.1.113883.3.6037.1001.23.98.81'
valueset "Progesterone receptor": '2.16.840.1.113883.3.6037.1001.23.96.16'
valueset "Estrogen receptor": '2.16.840.1.113883.3.6037.1001.23.96.15'
valueset "Neutrophil": '2.16.840.1.113883.3.6037.1001.23.96.17'
valueset "Positive": '2.16.840.1.113883.17.4077.3.2025'
valueset "Breasts BodySite": '2.16.840.1.113883.3.6037.1001.23.96.18'
valueset "Left breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.19'
valueset "Right breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.20'
valueset "Bilateral breast cancer": '2.16.840.1.113883.3.6037.1001.23.96.21'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define BreastCancerCondition:
   BCChemo."BreastCancerCondition"

define BreastCancerStaging:
   BCChemo."BreastCancerStaging"

define HER2Observation:
   BCChemo."HER2Observation"

define PRObservation:
   BCChemo."PRObservation"

define ERObservation:
   BCChemo."ERObservation"

define NeutrophilObservation:
   BCChemo."NeutrophilObservation"

define NeutrophilResult:
	BCChemo."NeutrophilResult"

define ChemoDrugsAdministration:
   BCChemo."ChemoDrugsAdministration"

define ChemoDrugsAllergy:
   BCChemo."ChemoDrugsAllergy"

define CardiacConditions:
   BCChemo."CardiacConditions"

define LiverConditions:
   BCChemo."LiverConditions"

define RenalConditions:
   BCChemo."RenalConditions"

define PreExistingConditions:
   BCChemo."PreExistingConditions"

define PulmonaryConditionsHistory:
   BCChemo."PulmonaryConditionsHistory"

define BleedingConditions:
   BCChemo."BleedingConditions"

define TumorSizeObservation:
   BCChemo."TumorSizeObservation"

define TumourSize:
   BCChemo."TumourSize"

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

define QA27:
    ("QT".item I
		where I.linkId.value = '2.7')QR
		return First(QR.answer).value

define QA28:
    ("QT".item I
		where I.linkId.value = '2.8')QR
		return First(QR.answer).value

define QA29:
    ("QT".item I
		where I.linkId.value = '2.9')QR
		return First(QR.answer).value

define QA210:
    ("QT".item I
		where I.linkId.value = '2.10')QR
		return First(QR.answer).value

define QA211:
    ("QT".item I
		where I.linkId.value = '2.11')QR
		return First(QR.answer).value

define QA212:
    ("QT".item I
		where I.linkId.value = '2.12')QR
		return First(QR.answer).value

define QA31:
    ("QT".item I
		where I.linkId.value = '3.1')QR
		return First(QR.answer).value

define QA32:
    ("QT".item I
		where I.linkId.value = '3.2')QR
		return First(QR.answer).value

define QA33:
    ("QT".item I
		where I.linkId.value = '3.3')QR
		return First(QR.answer).value

define ChemoNotNeeded:
    if (
        ((First("QA21") = true)
        and (First("QA22")= true)
        and (First("QA23")= true)
        and (First("QA24")= true)
        and (First("QA27")= false))
        or
        ((First("QA21") = true)
        and (First("QA22")= true)
        and (First("QA23")= true)
        and (First("QA24")= false)
        and (First("QA28") = false)
        and (First("QA29") = true))
        or
        ((First("QA21") = true)
        and (First("QA22")= true)
        and (First("QA23")= true)
        and (First("QA24")= false)
        and (First("QA28")= false)
        and (First("QA29")= false)
        and (First("QA211")= false)
        and (First("QA31")= false)
        and (First("QA32")= true))
        )
        then true
        else false

define TrastuzumabNotNeeded:
    if ((First("QA24") = false)
        and (First("QA28") = false)
        and (First("QA29")= false)
        and (First("QA210")= true))
        then true
        else false

define DocetaxelNotNeeded:
    if ((First("QA24") = false)
        and (First("QA28") = false)
        and (First("QA29")= false)
        and (First("QA211")= true)
        and (First("QA212")= true))
        then true
        else false

define CarboplatinNotNeeded:
    if ((First("QA24") = false)
        and (First("QA28") = false)
        and (First("QA29")= false)
        and ((First("QA211")= false)
                or (First("QA212")= true))
        and (First("QA31") = true)
        and (First("QA32") = false))
        then true
        else false

define PrimaryDecision:
    if ((First("QA21") = true)
        and (First("QA22")= true)
        and (First("QA23")= true)
        and (First("QA24")= false)
        and (First("QA28")= false)
        and (First("QA29")= false)
        and (First("QA211")= false)
        and (First("QA31")= false)
        and (First("QA32")= false))
        then true
        else false

define FinalDecision:
    if (("PrimaryDecision" = true))
        then 'YES'
        else 'NO'





