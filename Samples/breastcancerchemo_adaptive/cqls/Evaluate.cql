library Evaluate version '1.0.0'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers

parameter "questionnaireInput" Questionnaire
parameter "questionnaireResponseInput" QuestionnaireResponse
parameter "dummyQuestionnaireResponse" QuestionnaireResponse

define "LastResponseItem":
    if (questionnaireResponseInput.item is not null)
    then questionnaireResponseInput.item[Length(questionnaireResponseInput.item)-1]
    else First(dummyQuestionnaireResponse.item)

define "LastResponseItemLinkID":
    if ("LastResponseItem" is not null)
    then "LastResponseItem".linkId
    else ''

define "QuestionnaireItem":
    IndexOf(questionnaireInput.item, Last(questionnaireInput.item QI where QI.linkId = "LastResponseItemLinkID"))

define "ResponseSubItem":
    if ("LastResponseItem" is not null)
    then "LastResponseItem".item subItem where subItem.linkId = 'PayerRecomendations'
    else dummyQuestionnaireResponse.item

define "ResponseAnswer":
    if (Last("ResponseSubItem").linkId !='dummy')
    then (if Length("ResponseSubItem".answer)>0
        then FHIRHelpers.ToCode("ResponseSubItem".answer[0].value).code
        else '-1')
    else '-1'

define "NextQuestionLinkId":
    if ("QuestionnaireItem"!=-1)
    then questionnaireInput.item["QuestionnaireItem"+1].linkId
    else '-1'

define "next-question":
    if "ResponseAnswer" != '-1'
    then "ResponseAnswer" 
    else (if "NextQuestionLinkId"!= '-1'
        then "NextQuestionLinkId" 
        else '')

