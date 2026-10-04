### Understanding Obligations

Obligations relate to application behaviour, not the content of the element itself in the resource instances that contain this element.

#### Obligations on Repeating Elements

If obligations appear on an element that is allowed to repeat, the default expectation is that the obligation applies to all repetitions allowed by the profile. I.e. if maxOccurs is "20" and there are obligations around display, storage, and data sharing, then the system would be expected to handle 20 for all of those purposes.

This default expectation can be overridden to establish a different "must support at least this many" on a per obligation basis using the `applicable-number` property.

If there is no upper cardinality specified (i.e. maxOccurs = "*"), the expectation is that the obligation applies to "as many as the system can technically manage", but there's an understanding that all systems will have a practical limit. E.g. not all systems will be able to allow data entry, persistence, display, etc. of "5000 patient given names". However, based on database design, some systems might have a practical limit of "3 patient given names". In the absence of an explicit cardinality or `applicable-number` value, there can be no confident assumption on the number that will be supported.

The technical limitations of a system will often vary based on the type of obligation. A system may be able to transmit more elements than they necessarily allow for capture, but in some cases (e.g. transmission via UPC code), the reverse might be true.

When constraining a profile element, `applicable-number` SHALL be less than or equal to maxOccurs, and SHALL be greater than or equal to the minimum of the current maxOccurs and the `applicable-number` of the element in the parent profile, if one is present.

##### Which Repetitions an Obligation Applies To

When an obligation applies to a repeating element, the repetitions it applies to are determined as follows:

* Obligations apply to only data that 'fits' the semantics of the element and the overall instance. For example, a Composition, List, or other grouper may inherently filter what instances are 'in scope' and, in some cases, might even indicate the included instances themselves should be subsetted (i.e. filtering out elements or certain element repetitions)
* Once the data that is semantically appropriate to share has been identified, it's subsequently filtered by 'what's allowed to be shared' based on regulation, consent, etc.
* Obligations might apply to only a subset of the remaining elements based on any specified obligation `filter`
* Of those, the `applicable-number` (if present) sets the minimum number of matching occurrences that the system must support. If more occurrences exist than the system supports, which occurrences are chosen is selected by the system adhering to the obligation

Note that the result of this on elements with repetitions is that a variable number of results will be included based on all of the above rules, which may be zero or more in any given instance.

#### Context Dependent Obligations

Whether an obligation applies, or how it applies, often depends on the context: clinical context, relevance to the purpose of the exchange, workflow, jurisdiction, and other business rules. For example, a system might only provide the most recent reaction on an allergy, or the general practitioner that is local to where the patient currently is.

There are several ways that this is handled:

* Context specific rules within an obligation are specified using the `usage` property of the extension, which links clinical, workflow, or implementation context to the obligation - e.g. that the obligation applies to female patients, or in a particular jurisdiction (see [UsageContext]({{site.data.fhir.path}}metadatatypes.html#UsageContext)) <!-- placeholder: link to the core specification page on using UsageContext, once it exists -->
* Similar rules can be described at a higher level through the slicing mechanism (e.g. requiring a slice with given properties), or at the profile level itself (e.g. restrictions on the context for when a profile is appropriate)
* Implementation context also applies (e.g. the jurisdictional rules where a system is implemented, or the specific instance of a request being made). This affects the results, but is not expected to be codified in the obligations

Note that an implementation guide cannot change the meaning of the obligation codes themselves to take context into account (e.g. by redefining `populate-if-known` as "populate if known and relevant"); context rules are expressed using the mechanisms above.
