When reporting the results of this custom validation rule via an OperationOutcome (issue), the following property mappings should be considered:

|Issue property|Constraint property|Comments|
|----|----|----|
|severity|severity | |
|code|'Invariant'|Fixed code value from issue-type CodeSystem |
|details.coding.system|`Questionnaire.url`|Canonical URL of Questionnaire that contains this constraint|
|details.coding.code|`key`|
|details.coding.display|`human`|This is the human readable error message |
details.text|`human`|This value can also be displayed to a user (instead of the coding.display above) and is often useful to also prefix the {}human{} value with the display text from the item(s)|
|diagnostics|`expression`|The validation fhirpath expression (helps diagnose issues with validation rules)|
|expression|evaluate `location`|The location expression should be evaluated on the QuestionnaireResponse (or item) to provide the location(s) of the error to permit a User Interface to show the error associated with the specific field(s) that caused the error/warning|

The `location` component is a FHIRPath expression that should be executed on the target resource (or item that the constraint is associated with) to locate the path of the property(s) that should be flagged to the user when the constraint is violated.

When the `location` property is missing, it is assumed that the path of the answer being validated should be reported in the issue, and the path to the item in the target resource being validated should be used in the `issue.expression` field

e.g. A Questionnaire that has a group (g1) with 2 items (acc-date and review-date).

A validation rule will be added on the g1 item:
``` json
"url":"http://example.org/Questionnaire/abc",
...
"linkId":"q1",
"text": "Question 1",
{ 
    "key": "seq-dt", 
    "severity": "error", 
    "expression" : "item.where(linkId='acc-date').answer.first().trace('acc-date') < %resource.authored.trace('authored')", 
    "human": "The accident date must be before the completion date of the form", 
    "location": "item.where(linkId='acc-date').answer.first()" 
}
```

Example issue created from the above invariant example
``` json
{
  "severity": "error",
  "code": "Invariant",
  "details": {
    "coding": [{
      "system": "http://example.org/Questionnaire/abc", 
      "code" : "seq-dt", 
      "display": "The accident date must be before the review date"
    }],
    "text":"Question 1: The accident date must be before the completion date"
  },
  "diagnostics": "item.where(linkId='acc-date').answer.first().trace('acc-date') <  %resource.authored.trace('authored') acc-date: 2024-03-17; authored: 2024-02-01",
  "expression": ["QuestionnaireResponse.item[0].item[1].answer[0].value[0]"]
}
```