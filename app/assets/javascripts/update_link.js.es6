$(document).ready(function(){
})

function attachEditEvents(link) {
  $(`#link-${link.id}`).find(".edit-link").on("click", updateLink);
}

function updateLink() {
  event.preventDefault();

  var linkData = {
    id:    $(this).closest(".link").data("id"),
    title: $(this).parent().siblings(".link-title").text(),
    url:   $(this).parent().siblings(".link-url").text()
  }

  $.ajax({
    method: "PUT",
    url: `/api/v1/links/${linkData.id}`,
    data: linkData
  })
  .fail( displayFailure )
}
