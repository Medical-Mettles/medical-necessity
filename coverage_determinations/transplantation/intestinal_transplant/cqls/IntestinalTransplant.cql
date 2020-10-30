library IntestinalTransplant version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'
codesystem "LOINC": 'http://loinc.org'
codesystem "HCPCS": 'https://hcpcs.codes/'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "CPT": 'https://www.aapc.com/resources/medical-coding/cpt.aspx'

valueset "Total parenteral nutrition therapy": '2.16.840.1.113883.3.6037.1001.23.97.28'
valueset "Liver injury": '2.16.840.1.113883.3.6037.1001.23.97.29'
valueset "Liver failure": '2.16.840.1.113883.3.6037.1001.23.97.30'
valueset "Liver injury clinical manifestations": '2.16.840.1.113883.3.6037.1001.23.97.31'
valueset "Thrombosis of jugular, subclavian, and femoral veins": '2.16.840.1.113883.3.6037.1001.23.97.32'
valueset "Thrombolysis contraindication": '2.16.840.1.113883.3.6037.1001.23.97.33'
valueset "Sequelae of venous thrombosis": '2.16.840.1.113883.3.6037.1001.23.97.34'
valueset "Line infection or sepsis": '2.16.840.1.113883.3.6037.1001.23.97.35'
valueset "Other Sepsis Conditions": '2.16.840.1.113883.3.6037.1001.23.97.38'
valueset "Frequent episodes of severe dehydration": '2.16.840.1.113883.3.6037.1001.23.97.36'
valueset "Intestinal and Multi-Visceral Transplantation": '2.16.840.1.113883.3.6037.1001.23.97.37'
valueset "Procedure Unsuccessful": '2.16.840.1.113883.3.6037.1001.23.97.1'
valueset "Procedure for Medication Administration": '2.16.840.1.113883.3.6037.1001.23.96.12'

parameter "ServiceRequest" ServiceRequest
parameter "QuestionnaireResponse" QuestionnaireResponse
parameter "ClaimResponse" ClaimResponse

context Patient

define "MedicationAdministrationResources":
	[MedicationAdministration]M
	where M.subject.reference.value = 'Patient/'+ Patient.id.value
	and M.status.value = 'completed'
	and (First(((M.medication as CodeableConcept).coding) P where P in "Total parenteral nutrition therapy") is not null
		or First([Medication]med
							where (M.medication as Reference).reference.value = 'Medication/'+med.id.value
							and ((med.code.coding)C where C in "Total parenteral nutrition therapy") is not null
				) is not null
			) is not null

define "ProcedureResources":
	[Procedure]P where P.subject.reference.value = 'Patient/'+ Patient.id.value
 		and P.status.value = 'completed'
		and exists(P.code.coding C where C in "Procedure for Medication Administration")

define "TPNAdministration":
	"MedicationAdministrationResources" M
	with "ProcedureResources" P
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "TPNProcedure":
  "ProcedureResources" P
	with"MedicationAdministrationResources" M
	such that exists(P.partOf PO where PO.reference.value = 'MedicationAdministration/'+M.id.value)

define "LiverInjuryResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Liver injury")

define "LiverFailureManifestationsResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Liver injury clinical manifestations")

define "LiverFailureResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.verificationStatus.coding).code.value in {'provisional', 'confirmed'}
		and exists(C.code.coding C where C in "Liver failure")
    and exists(C.evidence E
              where First(E.code D
                          where exists(D.coding F where (F in "Liver injury clinical manifestations" or F in "Liver injury"))
                          ) is not null
                  or First(E.detail D
                            with ("LiverInjuryResource" union "LiverFailureManifestationsResource") L
                            such that D.reference.value = 'Condition/'+L.id.value) is not null
              )

define "LiverComplicationsDueToTPN":
  "TPNProcedure"P
  where exists(P.complication C where C in "Liver injury")
    or exists(P.complicationDetail D
              with "LiverInjuryResource" L
              such that D.reference.value = 'Condition/'+L.id.value)

define "ThrombosisResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Thrombosis of jugular, subclavian, and femoral veins")

define "SequelaeOfThrombosisResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Sequelae of venous thrombosis")
    and exists(C.evidence E
              where First(E.code D
                          where exists(D.coding F where F in "Thrombosis of jugular, subclavian, and femoral veins")
                          ) is not null
                  or First(E.detail D
                            with "ThrombosisResource" L
                            such that D.reference.value = 'Condition/'+L.id.value) is not null
              )

define "ThrombosisDueToTPN":
  "TPNProcedure"P
  where exists(P.complication C where C in "Thrombosis of jugular, subclavian, and femoral veins")
    or exists(P.complicationDetail D
              with "ThrombosisResource" L
              such that D.reference.value = 'Condition/'+L.id.value)
    or exists(P.statusReason.coding S where S in "Thrombolysis contraindication")

define "LineInfectionResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Line infection or sepsis")
    and FHIRHelpers.ToDateTime(C.recordedDate) during Interval[Today()-1 year, Today()]

define "OtherSepsisResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Other Sepsis Conditions")
    and FHIRHelpers.ToDateTime(C.recordedDate) during Interval[Today()-1 year, Today()]

define "SepsisDueToTPN":
  "TPNProcedure"P
  where exists(P.complication C where C in "Line infection or sepsis" or C in "Other Sepsis Conditions")
    or exists(P.complicationDetail D
              with ("LineInfectionResource" union "OtherSepsisResource") L
              such that D.reference.value = 'Condition/'+L.id.value
                and First(L.severity.coding).display.value = 'Severe')

define "DehydrationResource":
	[Condition]C
	where C.subject.reference.value = 'Patient/'+ Patient.id.value
 		and First(C.clinicalStatus.coding).code.value = 'active'
		and exists(C.code.coding C where C in "Frequent episodes of severe dehydration")

define "DehydrationDueToTPN":
  "TPNProcedure"P
  where exists(P.complication C where C in "Frequent episodes of severe dehydration")
    or exists(P.complicationDetail D
              with "DehydrationResource" L
              such that D.reference.value = 'Condition/'+L.id.value
                and First(L.severity.coding).display.value = 'Severe')

define "PrimaryDiagnosesCodes":
  ("LiverComplicationsDueToTPN"
  union "DehydrationDueToTPN"
  union "SepsisDueToTPN"
  union "ThrombosisDueToTPN")L
  return (L.complication
          union (("LiverInjuryResource"
                        union "ThrombosisResource"
                        union "LineInfectionResource"
                        union "OtherSepsisResource"
                        union "DehydrationResource") D
                with (L.complicationDetail) C
                such that C.reference.value = 'Condition/'+D.id.value)E return E.code)

define "PrimaryDiagnoses":
	("PrimaryDiagnosesCodes")P
	return (First(P.coding).display.value)+'\n'

define "RelevantDiagnoses":
  ("LiverFailureResource"
  union "SequelaeOfThrombosisResource")L
  return (First(L.code.coding).display.value)+'\n'

//define "ThromboticVesselsCount":
define "TPNPerformed":
	"TPNAdministration" P
	return (if (P.medication as CodeableConcept) is not null
					then ((P.medication as CodeableConcept).coding[0].display.value+'\n')
					else (First([Medication]med
							where (P.medication as Reference).reference.value = 'Medication/'+med.id.value).code.coding[0].display.value+'\n')
				)