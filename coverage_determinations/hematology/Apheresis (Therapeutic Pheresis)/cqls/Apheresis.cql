library Apheresis version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include ApheresisDecision version '1.0.0' called ApheresisCommon
//include otherLibrary version 'x.x' called otherLibrary
//codesystem codeSystemName : 'OID' version 'x.x'
//valueset valuesetName : 'OID' version 'x.x' codesystems{codeSystem1 , codeSystem2, etc}
//code codeName : 'OID' from codeSystemName display 'displayName'
//concept conceptName : {codeName1, codeName2, etc} display 'displayName'
//parameter parameterName (dataType or default value)

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "CDCNHSN": '2.16.840.1.113883.6.277'

valueset "Apheresis (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Plasma filtration (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Perfusion (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Plasmapheresis": '2.16.840.1.113883.3.6037.1001.23.99.75'
valueset "Therapeutic plasma exchange": '2.16.840.1.113883.3.6037.1001.23.99.76'
valueset "Leukopheresis": '2.16.840.1.113883.3.6037.1001.23.99.77'

valueset "Acute care hospital Inpatient Encounter": '2.16.840.1.113883.3.666.5.2289'
valueset "Adult Outpatient Visit": '2.16.840.1.113883.3.464.1003.101.12.1065'
valueset "Ambulatory/ED Visit": '2.16.840.1.113883.3.464.1003.101.12.1061'


valueset "Serious or Life Threatening Illness":'2.16.840.1.113883.3.464.1003.199.11.1104'
valueset "Goodpasture's syndrome (disorder)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Chronic progressive renal failure (disorder)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Pulmonary hemorrhage (disorder)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Leukemia, unspecified not having achieved remission": '2.16.840.1.113883.3.6037.1001.23.99.57'
valueset "Toxic liver disease with cholestasis": '2.16.840.1.113883.3.6037.1001.23.99.58'
valueset "Absence of therapeutic response (finding)": '2.16.840.1.113883.3.6037.1001.23.99.59'
valueset "Myasthenia gravis": '2.16.840.1.113883.3.6037.1001.23.99.60'
valueset "Waldenstrom macroglobulinemia": '2.16.840.1.113883.3.6037.1001.23.99.61'
valueset "Hypergammaglobulinemia" : '2.16.840.1.113883.3.6037.1001.23.99.62'
valueset "Multiple myeloma not having achieved remission": '2.16.840.1.113883.3.6037.1001.23.99.63'
valueset "Cryoglobulinemia": '2.16.840.1.113883.3.6037.1001.23.99.64'
valueset "Other specified diseases of blood and blood-forming organs": '2.16.840.1.113883.3.6037.1001.23.99.65'
valueset "Thrombotic microangiopathy": '2.16.840.1.113883.3.6037.1001.23.99.66'
valueset "Rheumatoid vasculitis with rheumatoid arthritis of unspecified site": '2.16.840.1.113883.3.6037.1001.23.99.67'
valueset "Hypersensitivity angiitis": '2.16.840.1.113883.3.6037.1001.23.99.68'
valueset "Nephrotic syndrome with unspecified morphologic changes": '2.16.840.1.113883.3.6037.1001.23.99.69'
valueset "Chronic inflammatory demyelinating polyneuritis": '2.16.840.1.113883.3.6037.1001.23.99.70'
valueset "Systemic sclerosis with lung involvement":'2.16.840.1.113883.3.6037.1001.23.99.71'
valueset "Polymyositis, organ involvement unspecified": '2.16.840.1.113883.3.6037.1001.23.99.72'
valueset "Guillain-Barre syndrome": '2.16.840.1.113883.3.6037.1001.23.99.73'
valueset "Systemic lupus erythematosus, unspecified": '2.16.840.1.113883.3.6037.1001.23.99.74'




parameter "ServiceRequest" ServiceRequest
parameter "ClaimResponse" ClaimResponse

context Patient

define ServiceEncounter:
	ApheresisCommon."ServiceEncounter"

define QualifyingEncounter:
	ApheresisCommon."QualifyingEncounter"

define Condition1:
	ApheresisCommon."Condition1"

define Condition2:
	ApheresisCommon."Condition2"

define Condition3:
	ApheresisCommon."Condition3"
	
define Condition4A:
	ApheresisCommon."Condition4A"
	
define Condition4B:
	ApheresisCommon."Condition4B"
	
define Condition4:
	ApheresisCommon."Condition4"

define Condition5:
	ApheresisCommon."Condition5"

define Condition6:
	ApheresisCommon."Condition6"
	
define Condition7:
	ApheresisCommon."Condition7"

define Condition8:
	ApheresisCommon."Condition8"

define Condition9:
	ApheresisCommon."Condition9"
	
define Condition10:
	ApheresisCommon."Condition10"

define Condition11:
	ApheresisCommon."Condition11"

define Condition12:
	ApheresisCommon."Condition12"

define Condition13:
	ApheresisCommon."Condition13"

define ServiceCondition:
	First([Condition]C
		where First(C.code.coding) in "Myasthenia gravis"
			or First(C.code.coding) in "Leukemia, unspecified not having achieved remission"
			or First(C.code.coding) in "Waldenstrom macroglobulinemia"
			or First(C.code.coding) in "Hypergammaglobulinemia"
			or First(C.code.coding) in "Multiple myeloma not having achieved remission"
			or First(C.code.coding) in "Cryoglobulinemia"
			or First(C.code.coding) in "Other specified diseases of blood and blood-forming organs"
			or First(C.code.coding) in "Thrombotic microangiopathy"
			or First(C.code.coding) in "Rheumatoid vasculitis with rheumatoid arthritis of unspecified site"
			or First(C.code.coding) in "Toxic liver disease with cholestasis"
			or First(C.code.coding) in "Hypersensitivity angiitis"
			or First(C.code.coding) in "Nephrotic syndrome with unspecified morphologic changes"
			or First(C.code.coding) in "Chronic inflammatory demyelinating polyneuritis"
			or First(C.code.coding) in "Systemic sclerosis with lung involvement"
			or First(C.code.coding) in "Polymyositis, organ involvement unspecified"
			or First(C.code.coding) in "Guillain-Barre syndrome"
			or First(C.code.coding) in "Systemic lupus erythematosus, unspecified"
			//or First(C.code.coding) in "Serious or Life Threatening Illness"
			)

define RelevantDiagnosis:
		First("ServiceCondition".code.coding).display.value

define DateOfOnset:
	start of "Normalize Onset"("ServiceCondition".onset)

define RelevantProcedure:
	First([Procedure]P
		where First(P.code.coding) in "Therapeutic plasma exchange"
			or First(P.code.coding) in "Leukopheresis"
			or First(P.code.coding) in "Plasmapheresis"
			)

define ProcedurePerformed:
	First("RelevantProcedure".code.coding).display.value

define ProcedureDate:
	start of "Normalize Interval Procedure"("RelevantProcedure".performed)


define function "Normalize Interval Procedure"(choice Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
 	 if choice is FHIR.dateTime then
 		  Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
	  else if choice is FHIR.Period then
		  FHIRHelpers.ToInterval(choice as FHIR.Period)
		else if choice is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	  else if choice is FHIR.Age then
	 	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age),
 		FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(choice as FHIR.Age) + 1 year)
		else if choice is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((choice as FHIR.Range).high) + 1 year)
	  else null


define function "Normalize Onset"(onset Choice<FHIR.dateTime, FHIR.Age, FHIR.Period, FHIR.Range, FHIR.string>):
  if onset is FHIR.dateTime then
	  Interval[FHIRHelpers.ToDateTime(onset as FHIR.dateTime), FHIRHelpers.ToDateTime(onset as FHIR.dateTime)]
	else if onset is FHIR.Period then
	  FHIRHelpers.ToInterval(onset as FHIR.Period)
	else if onset is FHIR.string then
    Message(null as Interval<DateTime>, true, '1', 'Error', 'Cannot compute an interval from a String value')
	else if onset is FHIR.Age then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity(onset as FHIR.Age) + 1 year)
	else if onset is FHIR.Range then
	  Interval[FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).low),
		  FHIRHelpers.ToDate(Patient.birthDate) + FHIRHelpers.ToQuantity((onset as FHIR.Range).high) + 1 year)
	else null
