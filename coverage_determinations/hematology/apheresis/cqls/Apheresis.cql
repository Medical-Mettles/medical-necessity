library Apheresis version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

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

valueset "Apheresis (procedure)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Plasma filtration (procedure)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Perfusion (procedure)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.80.28'
valueset "Plasmapheresis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.75'
valueset "Therapeutic plasma exchange": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.76'
valueset "Leukopheresis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.77'

valueset "Acute care hospital Inpatient Encounter": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.666.5.2289'
valueset "Adult Outpatient Visit": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1065'
valueset "Ambulatory/ED Visit": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1061'


valueset "Serious or Life Threatening Illness": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.464.1003.199.11.1104'
valueset "Goodpasture's syndrome (disorder)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Chronic progressive renal failure (disorder)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Pulmonary hemorrhage (disorder)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Leukemia, unspecified not having achieved remission": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.57'
valueset "Toxic liver disease with cholestasis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.58'
valueset "Absence of therapeutic response (finding)": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.59'
valueset "Myasthenia gravis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.60'
valueset "Waldenstrom macroglobulinemia": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.61'
valueset "Hypergammaglobulinemia" : 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.62'
valueset "Multiple myeloma not having achieved remission": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.63'
valueset "Cryoglobulinemia": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.64'
valueset "Other specified diseases of blood and blood-forming organs": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.65'
valueset "Thrombotic microangiopathy": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.66'
valueset "Rheumatoid vasculitis with rheumatoid arthritis of unspecified site": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.67'
valueset "Hypersensitivity angiitis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.68'
valueset "Nephrotic syndrome with unspecified morphologic changes": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.69'
valueset "Chronic inflammatory demyelinating polyneuritis": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.70'
valueset "Systemic sclerosis with lung involvement":'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.71'
valueset "Polymyositis, organ involvement unspecified": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.72'
valueset "Guillain-Barre syndrome": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.73'
valueset "Systemic lupus erythematosus, unspecified": 'https://fhir-dev.mettles.com/interop/fhir/ValueSet/2.16.840.1.113883.3.6037.1001.23.99.74'

parameter "ServiceRequest" ServiceRequest
parameter "ClaimResponse" ClaimResponse

context Patient

define SR:
	First([ServiceRequest])
	
define ServiceEncounter:
	First([Encounter]E where 'Encounter/' + E.id.value = "SR".encounter.reference.value)

define QualifyingEncounter:
	"ServiceEncounter" S
	where S.type in "Acute care hospital Inpatient Encounter"
	or S.type in "Adult Outpatient Visit"
	or S.type in "Ambulatory/ED Visit"


define Condition1:
	First([Condition]C
	 	with [Procedure]P
	 	such that First(C.code.coding) in "Myasthenia gravis"
	 	and First(P.code.coding) in "Therapeutic plasma exchange"
	 	and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition2:
	First([Condition]C
		with [Procedure]P
		such that First(C.code.coding) in "Leukemia, unspecified not having achieved remission"
		and First(P.code.coding) in "Leukopheresis"
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition3:
	First([Condition]C
	with [Procedure]P
	such that First(C.code.coding) in "Waldenstrom macroglobulinemia"
	and First(P.code.coding) in "Plasmapheresis"
	and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition4A:
	First([Condition]C
		where First(C.code.coding) in "Hypergammaglobulinemia")

define Condition4B:
	First([Condition]C
		where First(C.code.coding) in "Multiple myeloma not having achieved remission"
				or First(C.code.coding) in "Cryoglobulinemia"
				or First(C.code.coding) in "Other specified diseases of blood and blood-forming organs")
define Condition4:
		"Condition4A" A
		with "Condition4B" B
		such that "Normalize Onset"(A.onset) overlaps "Normalize Onset"(B.onset)

define Condition5:
	First([Condition]C
	with [Procedure]P
	such that First(C.code.coding) in "Thrombotic microangiopathy"
		and (First(P.code.coding) in "Plasmapheresis"
			or First(P.code.coding) in "Therapeutic plasma exchange")
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition6:
	First([Condition]C
	with [Procedure]P
	such that First(C.code.coding) in "Rheumatoid vasculitis with rheumatoid arthritis of unspecified site"
			//or  C.code in "Serious or Life Threatening Illness"
		and (First(P.code.coding) in "Plasmapheresis"
			or First(P.code.coding) in "Therapeutic plasma exchange")
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition7:
	First([Condition]C
		with [Procedure]P
			such that First(C.code.coding) in "Toxic liver disease with cholestasis"
			and First(P.code.coding) in  "Plasmapheresis"
			and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))


define Condition8:
	First([Condition]C
	with [Procedure]P
	such that  First(C.code.coding) in "Hypersensitivity angiitis"
		and First(P.code.coding) in "Therapeutic plasma exchange"
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition9:
	First([Condition]C
		with [Procedure]P
		such that First(C.code.coding) in "Nephrotic syndrome with unspecified morphologic changes"
			and First(P.code.coding) in "Therapeutic plasma exchange"
			and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition10:
	First([Condition]C
		with [Condition]F
		such that First(C.code.coding) in "Chronic inflammatory demyelinating polyneuritis"
		and First(F.code.coding) in "Absence of therapeutic response (finding)"
		//and C.code in "Serious or Life Threatening Illness"
			)

define Condition11:
	First([Condition]C
		with [Condition]F
		such that (First(C.code.coding) in "Systemic sclerosis with lung involvement"
			//and First(C.code.coding) in "Serious or Life Threatening Illness"
			and First(F.code.coding)  in "Absence of therapeutic response (finding)")
	   		 or (First(C.code.coding)  in "Polymyositis, organ involvement unspecified"
			//and  First(C.code.coding) in "Serious or Life Threatening Illness"
			and  First(F.code.coding) in "Absence of therapeutic response (finding)"))


define Condition12:
	First([Condition]C
	where First(C.code.coding) in "Guillain-Barre syndrome")

define Condition13:
	First([Condition]C
		with [Condition]F
		such that First(C.code.coding) in "Systemic lupus erythematosus, unspecified"
		and First(F.code.coding) in "Absence of therapeutic response (finding)"
		//and C.code in "Serious or Life Threatening Illness"
			)

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
