$(document).ready(function(){
  if (window.location.pathname === "/links" || window.location.pathname === "/") {
    addLinks();
  }
})

function addLinks() {
  $.getJSON("/api/v1/links")
  .then(function(allLinks) {
    allLinks.forEach( renderLink );
  })
}
