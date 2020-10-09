library VeinAblation version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include VeinAblationDecision version '1.0.0' called VeinAblationCommon

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
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Oral venoactive drugs": '2.16.840.1.113883.3.6037.1001.23.99.85'
valueset "Weight Loss (ICD10CM)": '2.16.840.1.113762.1.4.1146.703'
valueset "Daily exercise plan": '2.16.840.1.113883.3.6037.1001.23.99.87'
valueset "Periodic leg elevation": '2.16.840.1.113883.3.6037.1001.23.99.88'
valueset "Compression Therapy":  '2.16.840.1.113883.3.6037.1001.23.99.89'
valueset "Ulceration": '2.16.840.1.113883.3.6037.1001.23.99.90'
valueset "Chronic Pain": '2.16.840.1.113883.3.6037.1001.23.99.91'
valueset "Edema": '2.16.840.1.113883.3.6037.1001.23.99.92'
valueset "Bleeding": '2.16.840.1.113883.3.6037.1001.23.99.93'
valueset "Saphenous Reflux": '2.16.840.1.113883.3.6037.1001.23.99.94'
valueset "Superficial varicosity": '2.16.840.1.113883.3.6037.1001.23.99.95'
valueset "Superficial phlebitis": '2.16.840.1.113883.3.6037.1001.23.99.96'
valueset "Stasis dermatitis": '2.16.840.1.113883.3.6037.1001.23.99.97'
valueset "Dependent edema": '2.16.840.1.113883.3.6037.1001.23.99.98'
valueset "Perforator reflux": '2.16.840.1.113883.3.6037.1001.23.99.99'
valueset "Deep venous thromboembolism": '2.16.840.1.113883.3.6037.1001.23.95.1'
valueset "Duplex studies of venous system": '2.16.840.1.113883.3.6037.1001.23.95.2'
valueset "Sclerotherapy": '2.16.840.1.113883.3.6037.1001.23.95.3'
valueset "Hereditary hemorrhagic telangiectasia": '2.16.840.1.113883.3.6037.1001.23.95.4'
valueset "Venous Stripping": '2.16.840.1.113883.3.6037.1001.23.95.5'
valueset "Venous insufficiency (chronic) (peripheral)": '2.16.840.1.113883.3.6037.1001.23.95.6'
valueset "Varicose veins of bilateral lower extremities with pain": '2.16.840.1.113883.3.6037.1001.23.95.7'
valueset "Phlebitis and thrombophlebitis": '2.16.840.1.113883.3.6037.1001.23.95.8'
valueset "Injection/Compression Sclerotherapy": '2.16.840.1.113883.3.6037.1001.23.95.9'
valueset "Stab Phlebectomy": '2.16.840.1.113883.3.6037.1001.23.95.10'
valueset "Subfascial Endoscopic Perforator Surgery (SEPS)": '2.16.840.1.113883.3.6037.1001.23.95.11'
valueset "Laser ablation of veins": '2.16.840.1.113883.3.6037.1001.23.95.12'
valueset "Treatment of spider veins": '2.16.840.1.113883.3.6037.1001.23.95.13'
valueset "Klippel-Trenaunay Syndrome": '2.16.840.1.113883.3.6037.1001.23.95.14'
valueset "Congenital venous abnormalities": '2.16.840.1.113883.3.6037.1001.23.95.15'
valueset "Pregnancy equivalent diagnoses": '2.16.840.1.113762.1.4.1138.480'


parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse

context Patient

define ServiceEncounter:
	VeinAblationCommon."ServiceEncounter"

define function "GetId"(uri String):
	Last(Split(uri, '/'))
		
define function "EncounterDiagnosis"(Encounter Encounter):
	Encounter.diagnosis D
	return First([Condition]C
				where C.id.value = "GetId"(D.condition.reference.value)
					and FHIRHelpers.ToInteger(D.rank) = 2)

define ServiceCondition:
	"EncounterDiagnosis"("ServiceEncounter")

define ServiceDiagnosis:
	First("ServiceCondition" S
			where (First(S.code.coding) in "Chronic Pain" 
			or First(S.code.coding) in "Ulceration"
			or First(S.code.coding) in "Edema"
			or First(S.code.coding) in "Bleeding"
			or First(S.code.coding) in "Saphenous Reflux"
			or First(S.code.coding) in "Superficial varicosity"
			or First(S.code.coding) in "Superficial phlebitis"
			or First(S.code.coding) in "Stasis dermatitis"
			or First(S.code.coding) in "Dependent edema"
			or First(S.code.coding) in "Perforator reflux"
			or First(S.code.coding) in "Deep venous thromboembolism"
			or First(S.code.coding) in "Hereditary hemorrhagic telangiectasia"
			or First(S.code.coding) in "Phlebitis and thrombophlebitis"
			or First(S.code.coding) in "Varicose veins of bilateral lower extremities with pain"
			or First(S.code.coding) in "Congenital venous abnormalities"
			or First(S.code.coding) in "Pregnancy equivalent diagnoses"))

define RelevantDiagnosis:
	"ServiceDiagnosis".code.coding[0].display.value

define CT:
	VeinAblationCommon."CT"

define MedicationUsed:
	VeinAblationCommon."MedicationUsed"
	
define ExercisePlan:
	VeinAblationCommon."ExercisePlan"	

define PeriodicLegElevation:
	VeinAblationCommon."PeriodicLegElevation"
				
define VenousStasis:
	VeinAblationCommon."VenousStasis"
			
define SaphenousReflux:
	VeinAblationCommon."SaphenousReflux"
	
define SuperficialVaricosity:
	VeinAblationCommon."SuperficialVaricosity"

define SuperficialPhlebitis:
	VeinAblationCommon."SuperficialPhlebitis"
			
define StasisDermatitis:
	VeinAblationCommon."StasisDermatitis"
	
define RefractoryEdema:
	VeinAblationCommon."RefractoryEdema"
			
define PerforatorReflux:
	VeinAblationCommon."PerforatorReflux"
		
define VeinStripping:
	VeinAblationCommon."VeinStripping"
		
define SuperficialVeinTreatment:
	VeinAblationCommon."SuperficialVeinTreatment"
		 
define DeepVenousThromboembolism:
	VeinAblationCommon."DeepVenousThromboembolism"
			
define DuplexStudy:
	VeinAblationCommon."DuplexStudy"
		
define KTSyndrome:
	VeinAblationCommon."KTSyndrome"

define Pregnancy:
	VeinAblationCommon."Pregnancy"

define Telangiectasis:
	VeinAblationCommon."Telangiectasis"
			
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
	  
define function "LengthInDays"(Value Interval<DateTime>):
	difference in days between start of Value and end of Value