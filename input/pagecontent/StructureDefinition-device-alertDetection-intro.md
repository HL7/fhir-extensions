Multiple repetitions of this extension may be applied to the target [[[Device]]] or [[[DeviceMetric]]], each describing the activation state of different alerts (and priorities).

This extension is used to report&#8212;not set&#8212;alert detection activation state.

If more than one occurrence of this extension could describe the same alert and priority combination, the more specific occurrence should apply. For example, if this extension is used twice on a Device, once without an alertCode value, and once with; then, the activation state described in the occurrence with an alertCode applies to that alert, while the activation state of the occurrence without a code applies to other alerts. Broadly, &#8220;more specific&#8221; means:

* A specific alert code, over an absent alert code (which implies &#8220;all alerts&#8221;);
* A specific priority, over an absent priority (which implies &#8220;all priorities&#8221;);
* A current effective date, over a historical or absent effective date;
* An occurrence of this extension on a DeviceMetric instance, over an occurrence on mid-level Device, over an occurrence on a top-level Device.

Notes:

* There is potential for contradictory interpretation of &#8220;more specific&#8221; (such as whether an &#8220;all priorities&#8221; activation state specified at the DeviceMetric level is more specific than a particular priority activation state specified at the Device level); feedback is requested on whether additional guidance is needed when multiple occurrences could apply.
* Due to potential for confusion, &#8220;duplicate&#8221; extensions, e.g. having the same alert code and priority, should be avoided.
