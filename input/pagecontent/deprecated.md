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
