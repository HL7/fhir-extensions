Alert detection activation state is whether the device is set to annunciate when a [DeviceAlert](http://hl7.org/fhir/StructureDefinition/DeviceAlert) condition occurs. This extension describes the reported alert detection activation state for the indicated combination of alert code(s) and priority (priorities) at the indicated point in time. The extension may be used on a [Device](http://hl7.org/fhir/StructureDefinition/Device), or on the specific [DeviceMetric](http://hl7.org/fhir/StructureDefinition/DeviceMetric) that could detect the condition or annunciate the alert. This extension may repeat, describing the activation states of different alerts (and priorities). 

This extension is used to report, not set, alert detection activation state.

If more than one occurrence of this extension could describe the same alert and priority combination, the more specific occurrence should apply. For example, if this extension is used twice on a Device, once without an alertCode value, and once with; then, the activation state described in the occurrence with an alertCode applies to that alert, while the activation state of the occurrence without a code applies to other alerts. Broadly, "more specific" means:

* A specific alert code, over an absent alert code (which implies "all alerts");
* A specific priority, over an absent priority (which implies "all priorities");
* A current effective date, over a historical or absent effective date;
* An occurrence of this extension on a DeviceMetric instance, over an occurrence on mid-leve Device, over an occurrence on a top-level Device.

Note:
  There is potential for contradictory interpretation of "more specific" (such as whether an "all priorities" activation state specified at the DeviceMetric level is more specific than a particular priority activation state specified at the Device level); feedback is requested on whether additional guidance is needed when multiple occurrences could apply.
