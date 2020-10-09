library BlepharoplastyPrepopulation version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include Blepharoplasty version '1.0.0' called BLCommon


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
	BLCommon."ServiceEncounter"
	
define ServiceCondition:
	BLCommon."ServiceCondition"

define ServiceDiagnosis:
	BLCommon."ServiceDiagnosis"

define ServiceDiagnosis1:
	BLCommon."ServiceDiagnosis1"
	
define RelevantDiagnosis:
	First("ServiceDiagnosis".code.coding).display.value

define ServiceDiagnosis2:
	BLCommon."ServiceDiagnosis2"
	
define FunctionalDeficits:
	BLCommon."FunctionalDeficits"

define Botox:
	First([Procedure]P
		where First(P.code.coding) in "Botox Cosmetic Injectable Product"
		 and First(P.outcome.coding) in "Unsuccessful")

define TreatmentFailed:
	First("Botox".code.coding).display.value



define BlepharospasmCondition:
	BLCommon."BlepharospasmCondition"

define Blepharoptosis:
	BLCommon."Blepharoptosis"

define MRD:
	BLCommon."MRD"
	
define BrowRepair:
	BLCommon."BrowRepair"

define BlepharospasmDescription:
	if ("BlepharospasmCondition" is not null)
	then "BlepharospasmCondition".stage.summary.coding.display.value
	else null
