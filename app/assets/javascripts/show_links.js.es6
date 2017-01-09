$(document).ready(function(){
  addLinks();
})

function addLinks() {
  $.getJSON("/api/v1/links")
  .then(function(allLinks) {
    allLinks.forEach( renderLink );
  })
  .fail( displayFailure )
}
