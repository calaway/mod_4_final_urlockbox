$(document).ready(function(){
  $('#filter-by-read').on('change', filterByRead)
})

function filterByRead() {
  var selectedReadSelection = $(this).val();
  $('.link').each(function(index, link) {
    var $link = $(link);
    var linkReadStatus = $(link).find('p.link_read').text();

    if (linkReadStatus === selectedReadSelection) {
      $link.show();
    } else {
      $link.hide();
    }
  })
}
