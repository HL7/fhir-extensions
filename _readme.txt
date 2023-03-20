This IG includes a custom template that allows certain pages to appear as though they were part of the core specification.  
Making this work requires that when the core specification changes, the content that controls the appearance changes as well.

Right now, the IG only handles rendering with a single version of core.  If/when there are multiple versions of core that 
interact with the same IG, we're going to have to refactor things a bit, possibly by publishing multiple snapshots of the 
IG, or alternatively publishing multiple copies of each of the pages (though that might make hyperlinking messy).

In any event, one of the steps is to figure out which are the 'next' sub-section numbers to use for the tabs representing 
the extension list and mapping list for each resource.  This is driven by a transform that operates against the table 
found in the core build table of contents.  Create an XML source file that *only* contains the <table>...</table> portion.  
Take a look at toc.xml in this folder as an example.  Then use an XSLT2 engine such as Saxon or XML Spy to execute the 
tocToModules.xslt transform.  Take the resulting JSON and use it to replace the "resources" property in 
core-dup-template/data/modules.json.  (Obviously if there are any new modules or are changes to the graphics used for 
modules, you'll need to update that portion of the modules page too.

The other step is to update the fragement-pagebegin information to align with the new version of the core specification, 
most specifially the menus.