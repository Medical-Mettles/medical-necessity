library ChemoSDCEvaluate version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

parameter "questionnaireInput" Questionnaire
parameter "questionnaireResponseInput" QuestionnaireResponse

context Patient

define "LastResponseItem":
    questionnaireResponseInput.item[Length(questionnaireResponseInput.item)-1]

define "LastResponseItemLinkID":
    "LastResponseItem".linkId

define "QuestionnaireItem":
    IndexOf(questionnaireInput.item, Last(questionnaireInput.item QI where QI.linkId = "LastResponseItemLinkID"))

define "ResponseSubItem":
    "LastResponseItem".item subItem where subItem.linkId = 'PayerRecomendations'

define "ResponseAnswer":
    FHIRHelpers.ToCode("ResponseSubItem".answer[0].value).code

define "NextQuestionLinkId":
    questionnaireInput.item["QuestionnaireItem"+1].linkId

define "PresentQuestionLinkId":
    questionnaireInput.item["QuestionnaireItem"].linkId

define "next-question":
    if exists("ResponseSubItem") then "ResponseAnswer" 
        else 
            if (("PresentQuestionLinkId" = 'BCTreatmentOption1')
                    or ("PresentQuestionLinkId" = 'BCTreatmentOption2')
                    or ("PresentQuestionLinkId" = 'BCTreatmentOption3'))
                then '6'
                    else if (("NextQuestionLinkId" is not null )
                            and    (("PresentQuestionLinkId" != 'BCTreatmentOption1')
                                    or ("PresentQuestionLinkId" != 'BCTreatmentOption2')
                                    or ("PresentQuestionLinkId" != 'BCTreatmentOption3')))
                        then  "NextQuestionLinkId"
                            else ''
                        

