library RepetitiveNonEmergentAmbulance version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Dialysis Services": '2.16.840.1.113883.3.464.1003.109.11.1028'
valueset "Wound Care SM CT": '2.16.840.1.113883.3.666.5.2196'
valueset "Imaging_Lumbar": '2.16.840.1.113762.1.4.1106.4'
valueset "Radiation Therapy II": '2.16.840.1.113883.3.526.2.1409'
valueset "Chemotherapy": '2.16.840.1.113762.1.4.1047.453'
valueset "Immobilization": '2.16.840.1.113883.17.4077.3.2006'
valueset "Unable to ambulate": '2.16.840.1.113883.3.6037.1001.23.98.84'
valueset "Unable to sit": '2.16.840.1.113883.3.6037.1001.23.98.88'
valueset "Unable to maintain erect position": '2.16.840.1.113883.3.6037.1001.23.98.89'
valueset "Risk of falling": '2.16.840.1.113883.3.6037.1001.23.98.90'
valueset "Muscular weakness": '2.16.840.1.113883.3.6037.1001.23.98.91'
valueset "Non-healed fractures": '2.16.840.1.113883.3.6037.1001.23.98.92'
valueset "Contractures": '2.16.840.1.113883.3.6037.1001.23.98.93'
valueset "Osteoarthritis": '2.16.840.1.113883.3.6037.1001.23.98.95'
valueset "Physical deconditioning": '2.16.840.1.113883.3.6037.1001.23.98.96'
valueset "Lack of physical exercise": '2.16.840.1.113883.3.6037.1001.23.98.97'
valueset "Orthopedic device required in transit": '2.16.840.1.113883.3.6037.1001.23.98.98'
valueset "Amputations": '2.16.840.1.113883.3.6037.1001.23.98.99'
valueset "Spinal Cord Injury – Paralysis": '2.16.840.1.113883.3.6037.1001.23.98.102'
valueset "Progressive demyelinating disease": '2.16.840.1.113883.3.6037.1001.23.98.103'
valueset "Pain on movement": '2.16.840.1.113883.3.6037.1001.23.98.104'
valueset "Fatigue/Weakness/Malaise (ICD10CM)": '2.16.840.1.113762.1.4.1146.862'
valueset "Vertigo Conditions": '2.16.840.1.113883.3.6037.1001.23.93.407'
valueset "Application of Spica Cast": '2.16.840.1.113883.3.6037.1001.23.93.408'
valueset "Hip Replacement Surgery SNOMED CT": '2.16.840.1.113883.3.117.1.7.1.319'
valueset "Paraplegia Conditions": '2.16.840.1.113883.3.6037.1001.23.93.409'
valueset "CVA with sequelae": '2.16.840.1.113883.3.6037.1001.23.98.100'
valueset "DVT requires elevation of lower extremity": '2.16.840.1.113883.3.6037.1001.23.98.101'
valueset "Grade II or greater decubitus ulcers on buttocks": '2.16.840.1.113883.3.6037.1001.23.98.105'
valueset "Chronic wound": '2.16.840.1.113883.3.6037.1001.23.98.106'
valueset "Morbid obesity": '2.16.840.1.113883.3.6037.1001.23.98.107'
valueset "Dependence on equipments": '2.16.840.1.113883.3.6037.1001.23.98.108'
valueset "Dental Pain": '2.16.840.1.113762.1.4.1200.18'
valueset "Danger to self or others": '2.16.840.1.113883.3.6037.1001.23.98.109'
valueset "Confused, combative, lethargic, comatose": '2.16.840.1.113883.3.6037.1001.23.98.110'
valueset "Impaired mobility": '2.16.840.1.113883.3.6037.1001.23.98.94'


parameter "ServiceRequest" ServiceRequest

context Patient

define "DialysisReason":
    ServiceRequest.reasonCode R where exists(R.coding c where c in "Dialysis Services")

define "WoundCareReason":
    ServiceRequest.reasonCode R where exists(R.coding c where c in "Wound Care SM CT")

define "RadiationTherapyReason":
    ServiceRequest.reasonCode R where exists(R.coding c where c in "Radiation Therapy II")

define "ChemotherapyReason":
    ServiceRequest.reasonCode R where exists(R.coding c where c in "Chemotherapy")

define "ImagingReason":
    ServiceRequest.reasonCode R where exists(R.coding c where c in "Imaging_Lumbar")

define "PurposeOfAmbulance":
    {
    (if Last("DialysisReason") is not null then 'Dialysis' else null),
    (if Last("WoundCareReason") is not null then 'Wound care' else null),
    (if Last("RadiationTherapyReason") is not null then 'Radiation therapy' else null),
    (if Last("ChemotherapyReason") is not null then 'Chemotherapy' else null),
    (if Last("ImagingReason") is not null then 'Imaging' else null),
    (if (Last("DialysisReason") is null and Last("WoundCareReason") is null and Last("RadiationTherapyReason") is null and Last("ChemotherapyReason") is null and Last("ImagingReason") is null) then 'Other' else null)
    }
    except {null}

define "OtherPurpose":
    ServiceRequest.reasonCode R
      return (First(R.coding).display.value)+'\n'

define BedConfined:
  [Condition]C
    where exists(C.code.coding C where C in "Immobilization")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define FallingRisk:
	[Condition]P
    where exists(P.code.coding C where C in "Risk of falling")
		  and First(P.clinicalStatus.coding).code.value = 'active'
        and First(P.verificationStatus.coding).code.value = 'confirmed'

define MuscleWeakIssue:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Muscular weakness")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define ErectPositionIssue:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Unable to maintain erect position")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define ErectPositionEvidence:
  "ErectPositionIssue" D
    where First(D.evidence evid
      where First(evid.code c
              where First(c.coding co where co in "Muscular weakness") is not null) is not null
          or First(evid.detail c with ("MuscleWeakIssue") R
              such that c.reference.value = 'Condition/'+R.id.value) is not null) is not null

define MobilityIssuesCondition:
                if (exists("BedConfined")
                or (Last("ErectPositionEvidence") is not null)
                or exists("FallingRisk"))
                          then true
                            else false

define Fractures:
	[Condition]P
		  where exists(P.code.coding C where C in "Non-healed fractures")
		    and First(P.clinicalStatus.coding).code.value = 'active'
            and First(P.verificationStatus.coding).code.value = 'confirmed'

define OsteoarthritisCondition:
	[Condition]P
    where exists(P.code.coding C where C in "Osteoarthritis")
		    and First(P.clinicalStatus.coding).code.value = 'active'
            and First(P.verificationStatus.coding).code.value = 'confirmed'

define DeconditioningResource:
	[Condition]P
    where exists(P.code.coding C where C in "Physical deconditioning")
		  and First(P.clinicalStatus.coding).code.value = 'active'
        and P.severity.coding[0].display.value='Severe'
          and First(P.verificationStatus.coding).code.value = 'confirmed'

define LackOfExercise:
	[Condition]P
		where exists(P.code.coding C where C in "Lack of physical exercise")
		  and First(P.clinicalStatus.coding).code.value = 'active'
        and First(P.verificationStatus.coding).code.value = 'confirmed'

define LackOfExerciseEvidence:
    "LackOfExercise" D
      where First(D.evidence evid
        where First(evid.code c where First(c.coding co where co in "Physical deconditioning") is not null) is not null
          or First(evid.detail c with ("DeconditioningResource") R
            such that c.reference.value = 'Condition/'+R.id.value) is not null) is not null

define OrthopedicDeviceRequired:
	[Condition]P
		where exists(P.code.coding C where C in "Orthopedic device required in transit")
      and First(P.clinicalStatus.coding).code.value = 'active'
        and First(P.verificationStatus.coding).code.value = 'confirmed'

define AmputationsCondition:
	[Condition]P
		where exists(P.code.coding C where C in "Amputations")
		  and First(P.clinicalStatus.coding).code.value = 'active'
        and First(P.verificationStatus.coding).code.value = 'confirmed'

define MusculoskeletalIssuesCondition:
    if (exists("Fractures")
          or exists("OsteoarthritisCondition")
            or (Last("LackOfExerciseEvidence") is not null)
              or exists("OrthopedicDeviceRequired")
                or exists("AmputationsCondition"))
                  then true
                    else false

define ParalysisCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Spinal Cord Injury – Paralysis")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define DemyelinatingCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Progressive demyelinating disease")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define MovementPainCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Pain on movement")
		and P.severity.coding[0].display.value in {'Severe', 'Moderate'}

define NeurologicalIssuesCondition:
    if (exists("ParalysisCondition")
          or exists("DemyelinatingCondition")
            or exists("MovementPainCondition"))
              then true
                else false

define SequelaeCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "CVA with sequelae")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define ImpairedMobilityCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Impaired mobility")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define SequelaeEvidence:
    "SequelaeCondition" D
        where First(D.evidence evid
          where First(evid.code c where First(c.coding co where co in "Impaired mobility") is not null) is not null
        or First(evid.detail c with ("ImpairedMobilityCondition") R
            such that c.reference.value = 'Condition/'+R.id.value) is not null) is not null

define DVTCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "DVT requires elevation of lower extremity")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define CardiovascularIssuesCondition:
  if ((Last("SequelaeEvidence") is not null)
        or exists("DVTCondition"))
          then true
            else false

define GradeIIUlcersCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Grade II or greater decubitus ulcers on buttocks")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define ChronicWoundCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Chronic wound")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define WoundsCondition:
    if ((exists("GradeIIUlcersCondition") and exists("SittingIssue")
        or exists("ChronicWoundCondition")))
          then true
            else false

define DentalIssues:
	[Condition]P
		where exists(P.code.coding C where C in "Dental Pain")
		  and First(P.clinicalStatus.coding).code.value = 'active'
        and First(P.verificationStatus.coding).code.value = 'confirmed'

define DangerCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Danger to self or others")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define MentalConditions:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Confused, combative, lethargic, comatose")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define MentalIssuesCondition:
    if (exists("DangerCondition")
          or exists("MentalConditions"))
            then true
              else false

define ObesityCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Morbid obesity")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define DependenceCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Dependence on equipments")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define DependenceConditionEvidence:
    "DependenceCondition" D
      where First(D.evidence evid
                    where First(evid.code c where First(c.coding co where co in "Morbid obesity") is not null) is not null
          or First(evid.detail c with ("ObesityCondition") R
                such that c.reference.value = 'Condition/'+R.id.value) is not null) is not null

define RequireAttendantCondition:
    if Last("DependenceConditionEvidence") is not null
    then true
    else false

define AmbulanceConditions:
  if "MobilityIssuesCondition" = true then 'Mobility issues'
      else if "MusculoskeletalIssuesCondition" = true then 'Musculoskeletal issues'
          else if "NeurologicalIssuesCondition" = true then 'Neurological issues'
              else if "CardiovascularIssuesCondition" = true then 'Cardiovascular issues'
                  else if "WoundsCondition" = true then 'Wounds'
                      else if exists("DentalIssues") then 'Dental issues'
                          else if "MentalIssuesCondition" = true then 'Mental issues'
                              else if "RequireAttendantCondition" = true then 'Attendant required during transport'
                                  else null

define MobilityIssues:
  if exists("BedConfined") then 'Bed confined'
    else if (Last("ErectPositionEvidence") is not null) then 'Unable to maintain erect sitting position in a chair for time needed to transport, due to moderate muscular weakness and de-conditioning'
      else if exists("FallingRisk") then 'Risk of falling off wheelchair or stretcher while in motion'
        else null

define AmbulationIssue:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Unable to ambulate")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define SittingIssue:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Unable to sit")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define ContracturesCondition:
	[Condition]P
		where P.subject.reference.value = 'Patient/'+ Patient.id.value
		and First(P.clinicalStatus.coding).code.value = 'active'
		and exists(P.code.coding C where C in "Contractures")
    and First(P.verificationStatus.coding).code.value = 'confirmed'

define ContracturesEvidence:
  "ContracturesCondition" D
    where First(D.evidence evid
            where First(evid.code c where First(c.coding co where co in "Unable to ambulate") is not null) is not null
      or First(evid.detail c with ("AmbulationIssue") R
          such that c.reference.value = 'Condition/'+R.id.value) is not null) is not null

define SevereWeakness:
  [Condition]C
    where exists(C.code.coding C where C in "Fatigue/Weakness/Malaise (ICD10CM)")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
          and First(C.severity.coding).display.value = 'Severe'

define SevereVertigo:
   [Condition]C
    where exists(C.code.coding C where C in "Vertigo Conditions")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'
          and First(C.severity.coding).display.value = 'Severe'

define SpicaCastApplicationProcedure:
   [Procedure]P
		  where exists(P.code.coding P where P in "Application of Spica Cast")
			  and P.status.value ='completed'

define HipReplacementSurgeryProcedure:
  [Procedure]P
		  where exists(P.code.coding P where P in "Hip Replacement Surgery SNOMED CT")
			  and P.status.value ='completed'

define LowerExtremityParalysisCondition:
  [Condition]C
    where exists(C.code.coding C where C in "Paraplegia Conditions")
      and First(C.clinicalStatus.coding).code.value = 'active'
        and First(C.verificationStatus.coding).code.value = 'confirmed'

define BedConfinedConditions:
  if ((Last("ContracturesEvidence") is not null) and exists("SittingIssue"))
    then 'Contractures creating non-ambulatory status and the beneficiary cannot sit'
      else if exists("SevereWeakness")
        then 'Severe Weakness'
          else if exists ("SevereVertigo")
            then 'Severe Vertigo'
              else if (exists("SpicaCastApplicationProcedure")
                        or exists("HipReplacementSurgeryProcedure")
                          or exists("LowerExtremityParalysisCondition"))
                then 'Immobility of Lower Extremities'
                  else null

define SpicaCastApplication:
  exists("SpicaCastApplicationProcedure")

define HipReplacementSurgery:
  exists("HipReplacementSurgeryProcedure")

define LowerExtremityParalysis:
  exists("LowerExtremityParalysisCondition")

define MusculoskeletalIssues:
    if exists("Fractures") then 'Non-healed fractures requiring ambulance'
      else if exists("OsteoarthritisCondition") then 'Incapacitating Osteoarthritis'
        else if (Last("LackOfExerciseEvidence") is not null) then 'Severe muscular weakness and de-conditioned state precludes any significant physical activity'
          else if exists("OrthopedicDeviceRequired") then 'Orthopedic device required in transit'
            else if exists("AmputationsCondition") then 'Amputation(s)'
              else null

define NeurologicalIssues:
    if exists("ParalysisCondition") then 'Spinal Cord Injury – Paralysis'
      else if exists("DemyelinatingCondition") then 'Progressive demyelinating disease'
        else if exists("MovementPainCondition") then 'Moderate to severe pain on movement'
          else null

define CardiovascularIssues:
  if (Last("SequelaeEvidence") is not null) then 'CVA with sequelae (late effect of CVA) that impair mobility and result in bed confinement'
    else if exists("DVTCondition") then 'DVT requires elevation of lower extremity'
      else null

define GradeIIUlcers:
  if (exists("GradeIIUlcersCondition") and exists("SittingIssue"))
    then true
      else false

define ChronicWounds:
  if exists("ChronicWoundCondition")
    then true
      else false

define MentalIssues:
    if exists("DangerCondition") then 'Danger to self or others'
        else if exists("MentalConditions") then 'Confused, combative, lethargic, comatose'
            else null

define RequireAttendant:
    if (Last("DependenceConditionEvidence") is not null) then 'Morbid obesity requires additional personnel/equipment to handle'
      else null

define AmbulanceSupplier:
	First([Organization] org
        with (ServiceRequest.performer) P
        such that P.reference.value = ('Organization/' + org.id.value))

define "AmbulanceSupplierName":
	"AmbulanceSupplier".name.value

define "AmbulanceSupplierNPI":
    First("AmbulanceSupplier".identifier).value.value

define "AmbulanceSupplierAddressObject":
	First("AmbulanceSupplier".address)

define "SupplierAddressLine":
  if exists(AmbulanceSupplierAddressObject.line)
	then (if Length(AmbulanceSupplierAddressObject.line)>1
				then (AmbulanceSupplierAddressObject.line[0].value+', '+AmbulanceSupplierAddressObject.line[1].value)
				else AmbulanceSupplierAddressObject.line[0].value)
	else ''

define "SupplierAddressCity":
	AmbulanceSupplierAddressObject.city.value

define "SupplierAddressState":
	AmbulanceSupplierAddressObject.state.value

define "SupplierAddressPostalCode":
	AmbulanceSupplierAddressObject.postalCode.value

define "NumofTransports":
    (ServiceRequest.quantity as Quantity).value.value

define "StartDate":
    start of "Normalize Interval"(ServiceRequest.occurrence)

define "EncounterResource":
    Last([Encounter])

define "LocationFromObject":
	First([Location] L
	where 'Location/' + L.id.value = "EncounterResource".hospitalization.origin.reference.value)

define "TransportFrom":
    "LocationFromObject".address.line[0].value +', ' +"LocationFromObject".address.city.value +', ' +"LocationFromObject".address.state.value+', ' +"LocationFromObject".address.postalCode.value

define "LocationToObject":
	First([Location] L
	with "EncounterResource".location S
	such that ('Location/' + L.id.value) = S.location.reference.value)

define "TransportTo":
    "LocationToObject".address.line[0].value +', ' +"LocationToObject".address.city.value +', ' +"LocationToObject".address.state.value+', ' +"LocationToObject".address.postalCode.value

define function "Normalize Interval"(choice Choice<FHIR.dateTime, FHIR.Period>):
    if choice is FHIR.dateTime then
        Interval[FHIRHelpers.ToDateTime(choice as FHIR.dateTime), FHIRHelpers.ToDateTime(choice as FHIR.dateTime)]
    else if choice is FHIR.Period then
        FHIRHelpers.ToInterval(choice as FHIR.Period)
    else null

