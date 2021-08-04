library CTForHeadDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include CTForHead version '1.0.0' called CTHead

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'


parameter "ServiceRequest" ServiceRequest

context Patient

define BlurredVision:
    CTHead."BlurredVision"

define Nausea:
    CTHead."Nausea"

define Vomiting:
    CTHead."Vomiting"

define SignsOfWeakness:
    CTHead."SignsOfWeakness"

define SymptomsOfParalysis:
    CTHead."SymptomsOfParalysis"

define ExtremeObesity:
    CTHead."ExtremeObesity"

define InabilityToLieStill:
    CTHead."InabilityToLieStill"

define HeadachesOrDizziness:
    CTHead."HeadachesOrDizziness"

define HeadachesOnset:
    CTHead."HeadachesOnset"

define HeadachesSeverity:
    CTHead."HeadachesSeverity"

define Trauma:
    CTHead."Trauma"

define AcuteHemorrhage:
    CTHead."AcuteHemorrhage"

define StrokesEncephalomalacia:
    CTHead."StrokesEncephalomalacia"

define Seizures:
    CTHead."Seizures"

define IntracranialLesions:
    CTHead."IntracranialLesions"

define UsageOfMetallicEquipments:
    CTHead."UsageOfMetallicEquipments"

define RequirementOfContrastCT:
    CTHead."RequirementOfContrastCT"

define DiagnosisForContrastCT:
    CTHead."DiagnosisForContrastCT"

define Symptoms:
    if(("BlurredVision" = true)
        or ("Nausea" = true)
        or ("Vomiting" = true)
        or ("SignsOfWeakness" = true)
        or ("SymptomsOfParalysis" = true))
        then true 
        else false

define QualifyingHeadaches:
    if("HeadachesOrDizziness" = true)
        then true
        else false

define QualifyingDiagnosis:
    if(("ExtremeObesity" = true)
        or ("InabilityToLieStill" = true)
        or ("Trauma" = true)
        or ("AcuteHemorrhage" = true)
        or ("StrokesEncephalomalacia" = true)
        or ("Seizures" = true)
        or ("IntracranialLesions" = true))
        then true
        else false

define Limitations:
    if(("RequirementOfContrastCT" = true)
        or ("UsageOfMetallicEquipments" = true))
        then true
        else false

define FinalDecision:
    'YES'


        


