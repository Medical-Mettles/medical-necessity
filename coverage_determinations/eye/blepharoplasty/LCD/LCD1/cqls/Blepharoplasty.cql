library Blepharoplasty version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Blepharoplasty of Upper Eyelid Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.18'
valueset "Blepharoplasty of Lower Eyelid Diagnosis Codes": '2.16.840.1.113883.3.6037.1001.23.99.19'
valueset "Functional Deficits in EyeLid": '2.16.840.1.113883.3.6037.1001.23.99.20'
valueset "Botox Cosmetic Injectable Product": '2.16.840.1.113883.3.6037.1001.23.99.21'
valueset "Changes in skin texture": '2.16.840.1.113883.3.6037.1001.23.99.22'
valueset "Blepharospasm": '2.16.840.1.113883.3.6037.1001.23.99.23'
valueset "Margin reflex distance": '2.16.840.1.113883.3.6037.1001.23.99.24'
valueset "Sockets": '2.16.840.1.113883.3.6037.1001.23.99.25'
valueset "Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.99.50'



parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "ServiceRequest".encounter.reference.value)

define function "EncounterDiagnosis1"(Encounter Encounter):
	Encounter.diagnosis D
	return First([Condition]C
				where C.id.value = "GetId"(D.condition.reference.value)
					and FHIRHelpers.ToInteger(D.rank) = 2)

define function "EncounterDiagnosis"(Encounter Encounter):
	Encounter.diagnosis D
	return First([Condition]C
				where C.id.value = "GetId"(D.condition.reference.value)
					and FHIRHelpers.ToInteger(D.rank) = 1)

define function "GetId"(uri String):
	Last(Split(uri, '/'))

define ServiceCondition:
	"EncounterDiagnosis"("ServiceEncounter")

define ServiceCondition1:
	"EncounterDiagnosis1"("ServiceEncounter")

define ServiceDiagnosis:
	First("ServiceCondition" S
			where (First(S.code.coding) in "Blepharoplasty of Upper Eyelid Diagnosis Codes"
				or First(S.code.coding) in "Blepharoplasty of Lower Eyelid Diagnosis Codes")
			)

define RelevantServiceDiagnosis:
	First("ServiceCondition1" S
			where (First(S.code.coding) in "Blepharoplasty of Upper Eyelid Diagnosis Codes"
				or First(S.code.coding) in "Blepharoplasty of Lower Eyelid Diagnosis Codes")
			)

define RelevantDiagnosis:
	First("RelevantServiceDiagnosis".code.coding).display.value

define ServiceDiagnosis1:
	First("ServiceCondition" S
			where First(S.code.coding) in "Blepharoplasty of Upper Eyelid Diagnosis Codes"
			)

define ServiceDiagnosis2:
	First("ServiceCondition" S
			where First(S.code.coding) in "Blepharoplasty of Lower Eyelid Diagnosis Codes"
			)

define FunctionalDef:
	First([Condition]C
		where First(C.code.coding) in "Functional Deficits in EyeLid" 
			and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define FunctionalDeficits:
	First([Condition]C
		where First(C.code.coding) in "Sockets"
			and First(C.clinicalStatus.coding).code.value = 'active'
			and First(C.verificationStatus.coding).code.value = 'confirmed')

define Botox:
	First([Procedure]P
		where First(P.code.coding) in "Botox Cosmetic Injectable Product"
			and P.status.value ='completed'
		 	and First(P.outcome.coding) in "Unsuccessful")

define TreatmentFailed:
	First("Botox".code.coding).display.value

define BlepharospasmCondition:
	First([Condition]C
		with [Procedure]P
		such that First(C.code.coding) in "Blepharospasm"
		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.verificationStatus.coding).code.value = 'confirmed'
		and First(P.code.coding) in "Botox Cosmetic Injectable Product"
		and P.status.value ='completed'
		)

define Blepharoptosis:
	First([Observation]O
		where First(O.code.coding) in "Margin reflex distance"
			and O.status.value = 'final'
			and FHIRHelpers.ToQuantity(O.value) <= 2)

define MRD:
	(First([Observation]O
		where First(O.code.coding) in "Margin reflex distance"
			and O.status.value = 'final'
			and FHIRHelpers.ToQuantity(O.value) <= 2))M
		 return FHIRHelpers.ToQuantity(M.value)

define BrowRepair:
	First([Condition]C
		where First(C.code.coding) in "Changes in skin texture"
		and First(C.clinicalStatus.coding).code.value = 'active'
		and First(C.verificationStatus.coding).code.value = 'confirmed')

define BlepharospasmDescription:
	if ("BlepharospasmCondition" is not null)
	then "BlepharospasmCondition".stage.summary.coding.display.value
	else null
