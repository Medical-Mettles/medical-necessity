library RepetitiveNonEmergentAmbulanceDecision version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include RepetitiveNonEmergentAmbulance version '1.0.0' called Ambulance

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Ambulance Services": '2.16.840.1.113883.3.6037.1001.23.93.410'

parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ServiceRequest" ServiceRequest

context Patient

define Request:
	"ServiceRequest"

define AmbulanceServices:
  "Request".code.coding C where C in "Ambulance Services"

define QT:
	"QuestionnaireResponse".item

define PurposeOfAmbulanceResponse:
  ("QT".item I
		where I.linkId.value = 'PurposeOfAmbulance')QR
		return First(QR.answer).value

define PurposeOfAmbulanceServReason:
  Ambulance."PurposeOfAmbulance"

define PurposeOfAmbulance:
  Coalesce(("PurposeOfAmbulanceResponse").code, "PurposeOfAmbulanceServReason")

define OtherPurposeResponse:
  ("QT".item I
		where I.linkId.value = 'OtherPurpose')QR
		return First(QR.answer).value

define OtherPurposeServPurpose:
  Ambulance."OtherPurpose"

define OtherPurpose:
  Coalesce(("OtherPurposeResponse"), "OtherPurposeServPurpose")

define PurposeDecision:
  if (("PurposeOfAmbulance" is not null
        and (First("PurposeOfAmbulance") != 'Other'))
          or ((First("PurposeOfAmbulance") = 'Other')
            and ("OtherPurpose" is not null)))
              then true
                else false

define AmbulanceConditionsResponse:
  ("QT".item I
		where I.linkId.value = 'AmbulanceConditions')QR
		return First(QR.answer).value

define AmbulanceConditionsCond:
  Ambulance."AmbulanceConditions"

define AmbulanceConditions:
    Coalesce(First("AmbulanceConditionsResponse").code, "AmbulanceConditionsCond")

define MobilityIssuesResponse:
  ("QT".item I
		where I.linkId.value = 'MobilityIssues')QR
		return First(QR.answer).value

define MobilityIssuesCond:
  Ambulance."MobilityIssues"

define MobilityIssues:
    Coalesce(First("MobilityIssuesResponse").code, "MobilityIssuesCond")

define BedConfinedConditionsResponse:
  ("QT".item I
		where I.linkId.value = 'BedConfinedConditions')QR
		return First(QR.answer).value

define BedConfinedConditionsCond:
  Ambulance."BedConfinedConditions"

define BedConfinedConditions:
    Coalesce(First("BedConfinedConditionsResponse").code, "BedConfinedConditionsCond")

define SpicaCastApplicationResponse:
  ("QT".item I
		where I.linkId.value = 'SpicaCastApplication')QR
		return First(QR.answer).value

define SpicaCastApplicationProc:
  Ambulance."SpicaCastApplication"

define SpicaCastApplication:
    Coalesce(First("SpicaCastApplicationResponse"), "SpicaCastApplicationProc")

define HipReplacementSurgeryResponse:
  ("QT".item I
		where I.linkId.value = 'HipReplacementSurgery')QR
		return First(QR.answer).value

define HipReplacementSurgeryProc:
  Ambulance."HipReplacementSurgery"

define HipReplacementSurgery:
    Coalesce(First("HipReplacementSurgeryResponse"), "HipReplacementSurgeryProc")

define LowerExtremityParalysisResponse:
  ("QT".item I
		where I.linkId.value = 'LowerExtremityParalysis')QR
		return First(QR.answer).value

define LowerExtremityParalysisCond:
  Ambulance."LowerExtremityParalysis"

define LowerExtremityParalysis:
    Coalesce(First("LowerExtremityParalysisResponse"), "LowerExtremityParalysisCond")

define LowerExtremityDecision:
  if ("AmbulanceConditions" = 'Mobility issues'
        and "MobilityIssues" = 'Bed confined'
          and "BedConfinedConditions" = 'Immobility of Lower Extremities'
            and ("SpicaCastApplication" = true
                    or "HipReplacementSurgery" = true
                      or "LowerExtremityParalysis" = true))
          then true
            else false

define BedConfinedDecision:
   if ("AmbulanceConditions" = 'Mobility issues'
          and "MobilityIssues" = 'Bed confined'
            and "BedConfinedConditions" is not null
              and "LowerExtremityDecision" = false)
                then true
                  else false

define NonBedConfinedImmobilityDecision:
  if ("AmbulanceConditions" = 'Mobility issues'
        and "MobilityIssues" is not null
          and "BedConfinedDecision" = false
            and "LowerExtremityDecision" = false)
              then true
                else false

define MobilityIssuesDecision:
   if ("LowerExtremityDecision" = true
        or "BedConfinedDecision" = true
          or "NonBedConfinedImmobilityDecision" = true)
            then true
              else false

define MusculoskeletalIssuesResponse:
  ("QT".item I
		where I.linkId.value = 'MusculoskeletalIssues')QR
		return First(QR.answer).value

define MusculoskeletalIssuesCond:
  Ambulance."MusculoskeletalIssues"

define MusculoskeletalIssues:
    Coalesce(First("MusculoskeletalIssuesResponse").code, "MusculoskeletalIssuesCond")

define MusculoskeletalIssuesDecision:
  if ("AmbulanceConditions" = 'Musculoskeletal issues'
        and "MusculoskeletalIssues" is not null)
          then true
            else false

define NeurologicalIssuesResponse:
  ("QT".item I
		where I.linkId.value = 'NeurologicalIssues')QR
		return First(QR.answer).value

define NeurologicalIssuesCond:
  Ambulance."NeurologicalIssues"

define NeurologicalIssues:
    Coalesce(First("NeurologicalIssuesResponse").code, "NeurologicalIssuesCond")

define NeurologicalIssuesDecision:
  if ("AmbulanceConditions" = 'Neurological issues'
        and "NeurologicalIssues" is not null)
          then true
            else false

define CardiovascularIssuesResponse:
  ("QT".item I
		where I.linkId.value = 'CardiovascularIssues')QR
		return First(QR.answer).value

define CardiovascularIssuesCond:
  Ambulance."CardiovascularIssues"

define CardiovascularIssues:
    Coalesce(First("CardiovascularIssuesResponse").code, "CardiovascularIssuesCond")

define CardiovascularIssuesDecision:
  if ("AmbulanceConditions" = 'Cardiovascular issues'
        and "CardiovascularIssues" is not null)
          then true
            else false

define GradeIIUlcersResponse:
  ("QT".item I
		where I.linkId.value = 'GradeIIUlcers')QR
		return First(QR.answer).value

define GradeIIUlcersCond:
  Ambulance."GradeIIUlcers"

define GradeIIUlcers:
    Coalesce(First("GradeIIUlcersResponse"), "GradeIIUlcersCond")

define ChronicWoundsResponse:
  ("QT".item I
		where I.linkId.value = 'ChronicWounds')QR
		return First(QR.answer).value

define ChronicWoundsCond:
  Ambulance."ChronicWounds"

define ChronicWounds:
    Coalesce(First("ChronicWoundsResponse"), "ChronicWoundsCond")

define WoundsDecision:
  if ("AmbulanceConditions" = 'Wounds'
        and ("GradeIIUlcers" = true
              or "ChronicWounds" = true))
          then true
            else false

define MentalIssuesResponse:
  ("QT".item I
		where I.linkId.value = 'MentalIssues')QR
		return First(QR.answer).value

define MentalIssuesCond:
  Ambulance."MentalIssues"

define MentalIssues:
    Coalesce(First("MentalIssuesResponse").code, "MentalIssuesCond")

define MentalIssuesDecision:
  if ("AmbulanceConditions" = 'Mental issues'
        and "MentalIssues" is not null)
          then true
            else false

define RequireAttendantResponse:
  ("QT".item I
		where I.linkId.value = 'RequireAttendant')QR
		return First(QR.answer).value

define RequireAttendantCond:
  Ambulance."RequireAttendant"

define RequireAttendant:
    Coalesce(First("RequireAttendantResponse").code, "RequireAttendantCond")

define RequireAttendantDecision:
  if ("AmbulanceConditions" = 'Attendant required during transport'
        and "RequireAttendant" is not null)
          then true
            else false

define AmbulanceConditionsFinalDecision:
  if ("PurposeDecision" = true
        and ("MobilityIssuesDecision" = true
              or "MusculoskeletalIssuesDecision" = true
                or "NeurologicalIssuesDecision" = true
                  or "CardiovascularIssuesDecision" = true
                    or "WoundsDecision" = true
                      or "MentalIssuesDecision" = true
                        or "RequireAttendantDecision" = true))
          then true
            else false

define AnyOtherTransport:
  ("QT".item I
		where I.linkId.value = 'AnyOtherTransport')QR
		return First(QR.answer).value

define PatientSafeForOtherTransport:
  ("QT".item I
		where I.linkId.value = 'PatientSafeForOtherTransport')QR
		return First(QR.answer).value

define OtherTransportDecision:
  if (First("AnyOtherTransport") = true
        and First("PatientSafeForOtherTransport") = true)
          then true
            else false

define ServiceAtPointOfOrigin:
  ("QT".item I
		where I.linkId.value = 'ServiceAtPointOfOrigin')QR
		return First(QR.answer).value

define NumofTransportsResponse:
  ("QT".item I
		where I.linkId.value = 'NumofTransports')QR
		return First(QR.answer).value

define NumofTransportsServ:
  Ambulance."NumofTransports"

define NumofTransports:
    Coalesce(First("NumofTransportsResponse"), "NumofTransportsServ")

define AmbulanceSupplierNameResponse:
  ("QT".item I
		where I.linkId.value = 'AmbulanceSupplierName')QR
		return First(QR.answer).value

define AmbulanceSupplierNameServ:
  Ambulance."AmbulanceSupplierName"

define AmbulanceSupplierName:
    Coalesce(First("AmbulanceSupplierNameResponse"), "AmbulanceSupplierNameServ")

define AmbulanceSupplierNPIResponse:
  ("QT".item I
		where I.linkId.value = 'AmbulanceSupplierName')QR
		return First(QR.answer).value

define AmbulanceSupplierNPIServ:
  Ambulance."AmbulanceSupplierName"

define AmbulanceSupplierNPI:
    Coalesce(First("AmbulanceSupplierNPIResponse"), "AmbulanceSupplierNPIServ")

define SupplierAddressLineResponse:
  ("QT".item I
		where I.linkId.value = 'SupplierAddressLine')QR
		return First(QR.answer).value

define SupplierAddressLineServ:
  Ambulance."SupplierAddressLine"

define SupplierAddressLine:
    Coalesce(First("SupplierAddressLineResponse"), "SupplierAddressLineServ")

define SupplierAddressCityResponse:
  ("QT".item I
		where I.linkId.value = 'SupplierAddressCity')QR
		return First(QR.answer).value

define SupplierAddressCityServ:
  Ambulance."SupplierAddressCity"

define SupplierAddressCity:
    Coalesce(First("SupplierAddressCityResponse"), "SupplierAddressCityServ")

define SupplierAddressStateResponse:
  ("QT".item I
		where I.linkId.value = 'SupplierAddressState')QR
		return First(QR.answer).value

define SupplierAddressStateServ:
  Ambulance."SupplierAddressState"

define SupplierAddressState:
    Coalesce(First("SupplierAddressStateResponse"), "SupplierAddressStateServ")

define SupplierAddressPostalCodeResponse:
  ("QT".item I
		where I.linkId.value = 'SupplierAddressPostalCode')QR
		return First(QR.answer).value

define SupplierAddressPostalCodeServ:
  Ambulance."SupplierAddressPostalCode"

define SupplierAddressPostalCode:
    Coalesce(First("SupplierAddressPostalCodeResponse"), "SupplierAddressPostalCodeServ")

define TransportToResponse:
  ("QT".item I
		where I.linkId.value = 'TransportTo')QR
		return First(QR.answer).value

define TransportToServ:
  Ambulance."TransportTo"

define TransportTo:
    Coalesce(First("TransportToResponse"), "TransportToServ")

define StartDateResponse:
  ("QT".item I
		where I.linkId.value = 'StartDate')QR
		return First(QR.answer).value

define StartDateServ:
  Ambulance."StartDate"

define StartDate:
    Coalesce(First("StartDateResponse"), "StartDateServ")

define StartDateDecision:
      if ("StartDate" after (Today() -60 days))
        then true
          else false

define TypeOfRequest:
  ("QT".item I
		where I.linkId.value = 'TypeOfRequest')QR
		return First(QR.answer).value

define AmbulanceSchedulingDecision:
  if ("OtherTransportDecision" = false
        and First("ServiceAtPointOfOrigin") = false
          and "StartDateDecision" = true
            and "TypeOfRequest" is not null)
              then true
                else false

define IntermediateDecision:
  if ("AmbulanceSchedulingDecision" = true
         and exists("AmbulanceServices")
          and "AmbulanceConditionsFinalDecision" = true)
            then 'YES FOR AMBULANCE SERVICES'
              else 'HUMAN REVIEW NEEDED'

define FinalDecision:
  if ("IntermediateDecision" = 'YES FOR AMBULANCE SERVICES')
              then 'YES, Ambulance Services can be approved'
                else 'HUMAN REVIEW NEEDED'
