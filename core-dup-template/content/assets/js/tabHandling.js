try {
  var currentTabIndex = null;
  if (window.location.hash == '#tt-tree') {
    currentTabIndex = 0;
  } else if (window.location.hash == '#tt-uml') {
    currentTabIndex = 1;
  } else if (window.location.hash == '#tt-xml') {
    currentTabIndex = 2;
  } else if (window.location.hash == '#tt-json') {
    currentTabIndex = 3;
  } else if (window.location.hash == '#tt-ttl') {
    currentTabIndex = 4;
  } else if (window.location.hash == '#tt-all') {
    currentTabIndex = 5;
  } else {
    currentTabIndex = sessionStorage.getItem('fhir-resource-tab-index');
  }
} catch(exception) {
}

if (!currentTabIndex)
  currentTabIndex = '0';

$( '#tabs' ).tabs({
  active: currentTabIndex,
  activate: function( event, ui ) {
    var active = $('.selector').tabs('option', 'active');
    currentTabIndex = ui.newTab.index();
    document.activeElement.blur();
    try {
     sessionStorage.setItem('fhir-resource-tab-index', currentTabIndex);
    } catch(exception){
    }
  }
});
