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
valueset "Docetaxel": '2.16.840.1.113883.3.6037.1001.23.94.24'
valueset "Trastuzumab": '2.16.840.1.113883.3.6037.1001.23.94.25'
valueset "Carboplatin": '2.16.840.1.113883.3.6037.1001.23.94.26'

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

define DocetaxelMedication:
   exists([MedicationRequest] MR
      where First((MR.medication as CodeableConcept).coding) in "Docetaxel")

define CarboplatinMedication:
   exists([MedicationRequest] MR
      where First((MR.medication as CodeableConcept).coding) in "Carboplatin")

define TrastuzumabMedication:
   exists([MedicationRequest] MR
      where First((MR.medication as CodeableConcept).coding) in "Trastuzumab")

define QT:
	"QuestionnaireResponse".item

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

define QA51:
    ("QT".item I
		where I.linkId.value = '5.1')QR
		return First(QR.answer).value

define QA41:
    ("QT".item I
		where I.linkId.value = '4.1')QR
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

define ChemoNotNeeded:
    if (
        ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41") >1))
        or
        ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51") = false)
        and (First("QA24") = true)
        and (First("QA25") = false))
        or
        ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51")= false)
        and (First("QA21") = false)
        and (First("QA23")= true))
        or
        ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51")= false)
        and (First("QA21") = true)
        and (First("QA22") = true)
        and (First("QA23")= true))
        or 
        ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51") = false)
        and (First("QA27") = true)
        and (First("QA28") = false))
        or 
        ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51") = false)
        and (First("QA21") = true)
        and (First("QA22") = false))
        )
        then true
        else false

define TrastuzumabNotNeeded:
    if ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51") = false)
        and (First("QA24")= false)
        and (First("QA25")= true))
        then true
        else false

define TrastuzumabFinal:
   if (("ChemoNotNeeded" = false)
         and ("TrastuzumabMedication" = true)
         and ("TrastuzumabNotNeeded" = false)
         and (First("QA31") = true)
         and (First("QA32")= true)
         and (First("QA33")= true)
         and (First("QA41")= 1)
         and (First("QA51")= false)
         and ((First("QA24")= false)
               or ((First("QA24")= true) and (First("QA25")= true)))
         and ((First("QA27")= false)
               or ((First("QA27")= true) and (First("QA28")= true)))
         and ((First("QA21")= false)
               or ((First("QA21")= true) and (First("QA22")= true)))
         and (First("QA23")= false))
         then 'YES'
         else 'NO'

define DocetaxelNotNeeded:
    if ((First("QA41") = 1)
        and (First("QA51") = false)
        and (First("QA24")= false)
        and (First("QA27")= true)
        and (First("QA28")= true))
        then true
        else false

define DocetaxelFinal:
   if (("ChemoNotNeeded" = false)
         and ("DocetaxelMedication" = true)
         and ("DocetaxelNotNeeded" = false)
         and (First("QA31") = true)
         and (First("QA32")= true)
         and (First("QA33")= true)
         and (First("QA41")= 1)
         and (First("QA51")= false)
         and ((First("QA24")= false)
               or ((First("QA24")= true) and (First("QA25")= true)))
         and ((First("QA27")= false)
               or ((First("QA27")= true) and (First("QA28")= true)))
         and ((First("QA21")= false)
               or ((First("QA21")= true) and (First("QA22")= true)))
         and (First("QA23")= false))
         then 'YES'
         else 'NO'

define CarboplatinNotNeeded:
    if ((First("QA41") = 1)
        and (First("QA51") = false)
        and (First("QA24")= false)
        and ((First("QA27")= false)
                or (First("QA28")= true))
        and (First("QA21") = true)
        and (First("QA22") = false))
        then true
        else false

define CarboplatinFinal:
    if (("ChemoNotNeeded" = false)
         and ("CarboplatinMedication" = true)
         and ("CarboplatinNotNeeded" = false)
         and (First("QA31") = true)
         and (First("QA32")= true)
         and (First("QA33")= true)
         and (First("QA41")= 1)
         and (First("QA51")= false)
         and ((First("QA24")= false)
               or ((First("QA24")= true) and (First("QA25")= true)))
         and ((First("QA27")= false)
               or ((First("QA27")= true) and (First("QA28")= true)))
         and ((First("QA21")= false)
               or ((First("QA21")= true) and (First("QA22")= true)))
         and (First("QA23")= false))
         then 'YES'
         else 'NO'

define PrimaryDecision:
    if ((First("QA31") = true)
        and (First("QA32")= true)
        and (First("QA33")= true)
        and (First("QA41")= 1)
        and (First("QA51")= false)
        and ((First("QA24")= false)
               or ((First("QA24")= true) and (First("QA25")= true)))
        and ((First("QA27")= false)
               or ((First("QA27")= true) and (First("QA28")= true)))
        and ((First("QA21")= false)
               or ((First("QA21")= true) and (First("QA22")= true)))
        and (First("QA23")= false)
        and ("DocetaxelMedication" = true)
        and ("CarboplatinMedication" = true)
        and ("TrastuzumabMedication" = true))
        then true
        else false

define FinalDecision:
    if (("PrimaryDecision" = true) and ("ChemoNotNeeded" = true))
        then 'NO'
        else if (("PrimaryDecision" = true) and  ("TrastuzumabNotNeeded" = true))
            then 'TRASTUZUMAB NOT NEEDED FOR TREATMENT REGIMEN'
               else if (("PrimaryDecision" = true) and  ("DocetaxelNotNeeded" = true))
                  then 'DOCETAXEL NOT NEEDED FOR TREATMENT REGIMEN'
                     else if (("PrimaryDecision" = true) and  ("CarboplatinNotNeeded" = true))
                        then 'CARBOPLATIN NOT NEEDED FOR TREATMENT REGIMEN'
                           else if (("PrimaryDecision" = true) and ("ChemoNotNeeded" = false) and ("TrastuzumabNotNeeded" = false) and ("DocetaxelNotNeeded" = false) and ("CarboplatinNotNeeded" = false))
                              then 'YES'
                              else 'NO'





