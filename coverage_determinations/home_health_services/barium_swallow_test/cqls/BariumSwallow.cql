library BariumSwallow version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD10CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "LOINC": 'http://loinc.org'
codesystem "NUCCPT": 'https://www.nlm.nih.gov/research/umls/sourcereleasedocs/current/NUCCPT/sourcerepresentation.html'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "ActEncounterCodev2": 'http://terminology.hl7.org/CodeSystem/v2-0004'
codesystem "ActEncounterCode": 'http://terminology.hl7.org/ValueSet/v3-ActEncounterCode'

valueset "Primary Diagnosis Codes for MBS": '2.16.840.1.113883.3.6037.1001.23.95.51'
valueset "Secondary Diagnosis Codes for MBS": '2.16.840.1.113883.3.6037.1001.23.95.52'

parameter "Encounter" Encounter
parameter "ServiceRequest" ServiceRequest

context Patient


