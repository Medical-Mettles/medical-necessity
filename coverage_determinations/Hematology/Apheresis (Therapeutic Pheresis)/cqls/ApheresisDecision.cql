library ApheresisDecision version '1.0.0'

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

valueset "Apheresis (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Myasthenia gravis (disorder)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Deterioration of status (qualifier value)":'2.16.840.1.113762.1.4.1181.5'
valueset "Medical procedure AND/OR service (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Medical assessment (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Medical service (procedure)":'2.16.840.1.113883.3.88.12.80.28'
valueset "Under care of public health physician (finding)":'2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Seen by physician (finding)": '2.16.840.1.113883.3.88.12.3221.7.4'
valueset "Acute care hospital Inpatient Encounter": '2.16.840.1.113883.3.666.5.2289'
valueset "Adult Outpatient Visit": '2.16.840.1.113883.3.464.1003.101.12.1065'
valueset "Ambulatory/ED Visit": '2.16.840.1.113883.3.464.1003.101.12.1061'

code "Leukemia, unspecified not having achieved remission": 'C95.90' from "ICD-10-CM" display 'Leukemia, unspecified not having achieved remission'
code "Toxic liver disease with cholestasis": 'K71.0' from "ICD-10-CM" display 'Toxic liver disease with cholestasis'
code "Absence of therapeutic response (finding)": '102471002' from "SNOMED-CT" display 'Absence of therapeutic response (finding)'
code "Myasthenia gravis": 'G70.0' from "ICD-10-CM" display 'Myasthenia gravis'
code "Waldenstrom macroglobulinemia": 'C88.0' from "ICD-10-CM" display 'Waldenstrom macroglobulinemia'
code "Hypergammaglobulinemia, unspecified" : 'D89.2' from "ICD-10-CM" display 'Hypergammaglobulinemia, unspecified'
code "Multiple myeloma not having achieved remission": 'C90.00' from "ICD-10-CM" display 'Multiple myeloma not having achieved remission'
code "Cryoglobulinemia": 'D89.1' from "ICD-10-CM" display 'Cryoglobulinemia'
code "Other specified diseases of blood and blood-forming organs": 'D75.89' from "ICD-10-CM" display 'Other specified diseases of blood and blood-forming organs'
code "Thrombotic microangiopathy": 'M31.1' from "ICD-10-CM" display 'Thrombotic microangiopathy'
code "Rheumatoid vasculitis with rheumatoid arthritis of unspecified site": 'M05.20' from "ICD-10-CM" display 'Rheumatoid vasculitis with rheumatoid arthritis of unspecified site'
code "Hypersensitivity angiitis": 'M31.0' from "ICD-10-CM" display 'Hypersensitivity angiitis'
code "Nephrotic syndrome with unspecified morphologic changes": 'N04.9' from "ICD-10-CM" display 'Nephrotic syndrome with unspecified morphologic changes'
code "Chronic inflammatory demyelinating polyneuritis": 'G61.81' from "ICD-10-CM" display 'Chronic inflammatory demyelinating polyneuritis'
code "Systemic sclerosis with lung involvement": 'M34.81' from "ICD-10-CM" display 'Systemic sclerosis with lung involvement'
code "Polymyositis, organ involvement unspecified": 'M33.20' from "ICD-10-CM" display 'Polymyositis, organ involvement unspecified'
code "Guillain-Barre syndrome": 'G61.0' from "ICD-10-CM" display 'Guillain-Barre syndrome'
code "Systemic lupus erythematosus, unspecified": 'M32.9' from "ICD-10-CM" display 'Systemic lupus erythematosus, unspecified'
code "Plasmapheresis (procedure)": '20720000' from "SNOMED-CT" display 'Plasmapheresis (procedure)'
code "Therapeutic plasma exchange (procedure)": '225067007' from "SNOMED-CT" display 'Therapeutic plasma exchange (procedure)'
code "Leukopheresis (procedure)": '77257005' from "SNOMED-CT" display 'Leukopheresis (procedure)'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireReesponse" QuestionnaireResponse

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
	 	such that First(C.code.coding) = "Myasthenia gravis"
	 	and First(P.code.coding) = "Therapeutic plasma exchange (procedure)"
	 	and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
	
define Condition2:
	First([Condition]C
		with [Procedure]P
		such that First(C.code.coding) = "Leukemia, unspecified not having achieved remission"
		and First(P.code.coding) = "Leukopheresis (procedure)"
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
		
define Condition3:
	First([Condition]C
	with [Procedure]P
	such that First(C.code.coding) = "Waldenstrom macroglobulinemia"
	and First(P.code.coding) = "Plasmapheresis (procedure)"
	and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
	
define Condition4A:
	First([Condition]C
		where First(C.code.coding) = "Hypergammaglobulinemia, unspecified")
		
define Condition4B:
	First([Condition]C
		where First(C.code.coding) = "Multiple myeloma not having achieved remission"
				or First(C.code.coding) = "Cryoglobulinemia"
				or First(C.code.coding) = "Other specified diseases of blood and blood-forming organs")
define Condition4:
		"Condition4A" A
		with "Condition4B" B
		such that "Normalize Onset"(A.onset) overlaps "Normalize Onset"(B.onset)
		
define Condition5:
	First([Condition]C
	with [Procedure]P
	such that First(C.code.coding) = "Thrombotic microangiopathy"
		and (First(P.code.coding) = "Plasmapheresis (procedure)"
			or First(P.code.coding) = "Therapeutic plasma exchange (procedure)")
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
	
define Condition6:
	First([Condition]C
	with [Procedure]P
	such that First(C.code.coding) = "Rheumatoid vasculitis with rheumatoid arthritis of unspecified site"
			//or  C.code in "Serious or Life Threatening Illness"	
		and (First(P.code.coding) = "Plasmapheresis (procedure)"
			or First(P.code.coding) = "Therapeutic plasma exchange (procedure)")
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
	
define Condition7:
	First([Condition]C
		with [Procedure]P
			such that First(C.code.coding) = "Toxic liver disease with cholestasis"
			and First(P.code.coding) =  "Plasmapheresis (procedure)"
			and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
	

define Condition8:
	First([Condition]C
	with [Procedure]P
	such that  First(C.code.coding) = "Hypersensitivity angiitis"
		and First(P.code.coding) = "Therapeutic plasma exchange (procedure)"
		and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))
	
define Condition9:
	First([Condition]C
		with [Procedure]P
		such that First(C.code.coding) = "Nephrotic syndrome with unspecified morphologic changes"
			and First(P.code.coding) = "Therapeutic plasma exchange (procedure)"
			and "Normalize Onset"(C.onset) starts after "Normalize Interval Procedure"(P.performed))

define Condition10:
	First([Condition]C
		with [Condition]F
		such that First(C.code.coding) = "Chronic inflammatory demyelinating polyneuritis"
		and First(F.code.coding) = "Absence of therapeutic response (finding)"
		//and C.code in "Serious or Life Threatening Illness"
			)
		
define Condition11:
	First([Condition]C
		with [Condition]F
		such that (First(C.code.coding) = "Systemic sclerosis with lung involvement"
			//and First(C.code.coding) in "Serious or Life Threatening Illness"
			and First(F.code.coding)  = "Absence of therapeutic response (finding)")
	   		 or (First(C.code.coding)  = "Polymyositis, organ involvement unspecified"
			//and  First(C.code.coding) in "Serious or Life Threatening Illness"
			and  First(F.code.coding) = "Absence of therapeutic response (finding)"))
	

define Condition12:
	First([Condition]C
	where First(C.code.coding) = "Guillain-Barre syndrome")

define Condition13:
	First([Condition]C
		with [Condition]F
		such that First(C.code.coding) = "Systemic lupus erythematosus, unspecified"
		and First(F.code.coding) = "Absence of therapeutic response (finding)"
		//and C.code in "Serious or Life Threatening Illness"
			)
			

define PrimaryDecision:
	if(("QualifyingEncounter" is not null)
		and (("Condition1" is not null)
			or ("Condition2" is not null)
			or ("Condition3" is not null)
			or ("Condition4" is not null) 
			or ("Condition5" is not null) 
			or ("Condition6" is not null)
			or ("Condition7" is not null) 
			or ("Condition8" is not null) 
			or ("Condition9" is not null) 
			or ("Condition10" is not null) 
			or ("Condition11" is not null) 
			or ("Condition12" is not null) 
			or ("Condition13" is not null)))
	then true
	else false
	
define "FinalDecision":
	if ("PrimaryDecision" = true)
	then 'YES'
	else 'NO'
	
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