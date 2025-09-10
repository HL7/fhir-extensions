## Deprecation Information

Many of the extensions in this Extension Pack are deprecated. 
Deprecating an extension means two things for implementers:

* The extension should not be used, and implementers should be planning to migrate to a different approach - preferably what is specified in the deprecation notice
* In some future release, the extension will be removed from the extensions pack altogether

Extensions are deprecated in this Extensions for multiple reasons. THe most common reason is because many of the extensions were added very early in the process, and HL7 has tightened up it's review and management of the extensions, and many are being withdrawn
due to the increase in quality requirements. Others extensions have been deprecated because:

* They were poorly defined, and better extensions or alternative approaches with clearer definitions have been made available 
* The committee decided that there isn't any use case at all for the extension
* The extension has been 'elevated' into the specification in R5 or R6.

This last is actually a problem - such extensions are still valid and required in earlier versions, and should not be deprecated.
HL7 is reviewing the deprecated extensions as of the ballot for 5.3.0 and some of the extensions will be brought back to life, marked for use with the appropriate versions.

### Cross Version Extensions

It is possible that an extension defined for use in a particular FHIR release (e.g. R4) could be superseded by the introduction of that same functionality in a future version of FHIR (e.g. R5) and an automatic inter-version extension becoming available with the publication of that newer release.  There are some guidelines to follow in this situation:

1. There is no requirement that the previously valid R4 extension be deprecated.  (In fact, if the extension was published as part of the R4 specification, there's no practical mechanism to mark the extension as deprecated if we wanted to.)
2. R4 extensions published in an IG could be deprecated in a future version of the IG if the publishers of the IG decided it was advantageous for the community to move to the inter-version extension.   Switching from one extension to another would be a breaking change and would require justification.  For example:
   * the inter-version extension provides better support for inter-version compatibility
   * the inter-version extension provides additional functionality that is desirable in the newer version of the IG.
   
  Such an IG SHOULD allow both the old extension and the new inter-version extension to be transmitted for a period of time for compatibility reasons and to reduce the pain of the breaking change.
3. if you're supporting a multi-version IG (of which the extensions IG is the only current example), it is possible to mark an extension as being deprecated "as of" a particular FHIR release, meaning it ceases to be an appropriate extension for that release or higher.

### Editor's Notes

The following guidelines apply for managing extensions:

* Extensions should only be removed if (a) they should never have been defined and (b) the committee is satisfied that no one is using them (or preferably, no one can use them)
* Extensions should only be deprecated if the deprecation applies to FHIR releases R3 -> current. Unless..
* If the extension is badly defined, and something is added in R5/6/etc, then the extension can be deprecated in favour of using the cross-version extension. The committee can decide this, and needs to explain why this is required
* If extensions are deprecated, then the deprecation must include a notice explaining why, which is done like this:

````
  <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status">
    <valueCode value="deprecated">
      <extension url="http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status-reason">
        <valueMarkdown value="Replaced by [[[http://hl7.org/fhir/StructureDefinition/datatype-short-string]]]"/>
      </extension>
    </valueCode>
  </extension>
````

* If an extension is not to be used with a particular version, this is done using the http://hl7.org/fhir/StructureDefinition/version-specific-use extension, and marking each Context with and end version, and maybe a start version. For instance, here's 
the definition for an extension that was elevated to an element in R5:

````
  <context>
    <extension url="http://hl7.org/fhir/StructureDefinition/version-specific-use">
      <extension url="endFhirVersion">
        <valueCode value="4.3"/>
      </extension>
    </extension>
    <type value="element"/>
    <expression value="CodeSystem"/>
  </context>
````

### Summary of Deprecated Resources

{% include deprecated-list.xhtml %}
