library RhinoplastyDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include Rhinoplasty version '1.0.0' called Rhinoplasty

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Rhinoplasty Procedures": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.7'
valueset "Rhinoplasty Diagnoses": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.8'
valueset "Operative / procedure report": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.9'
valueset "Practitioner, nurse, and ancillary progress notes": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.10'
valueset "Physician consultations": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.11'
valueset "Advanced beneficiary notice": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.12'
valueset "Documentation of presurgical conservative measures/treatments":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.13'
valueset "Imaging reports prior to the visits or treatments": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.97.14'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "Diagnoses":
	Rhinoplasty."Diagnoses"

define "ProcedureNote":
	First([DocumentReference]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(D.type.coding) in "Operative / procedure report")

define "ProgressNotes":
	First([DocumentReference]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(D.type.coding) in "Practitioner, nurse, and ancillary progress notes")

define "ConsultNote":
	First([DocumentReference]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(D.type.coding) in "Physician consultations")

define "BeneficiaryNotice":
	First([DocumentReference]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(D.type.coding) in "Advanced beneficiary notice")

define "PresurgicalTreatments":
	First([DocumentReference]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(D.type.coding) in "Documentation of presurgical conservative measures/treatments")

define "ImagingReports":
	First([DocumentReference]D
		where D.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(D.type.coding) in "Imaging reports prior to the visits or treatments")

define "Documentation":
	if ("ProcedureNote" is not null
		and "ProgressNotes" is not null
		and "ConsultNote" is not null
		and "BeneficiaryNotice" is not null
		and "PresurgicalTreatments" is not null
		and "ImagingReports" is not null)
	then true
	else false

define "FinalDecision":
	if (First("Diagnoses") is not null
		and "Documentation")
	then 'HUMAN REVIEW'
	else 'NO'
