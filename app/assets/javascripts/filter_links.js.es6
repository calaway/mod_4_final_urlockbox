$(document).ready(function(){
  $('#filter-by-read').on('change', filterByRead)
  $('#filter-by-text').on('keyup', filterByText)
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

function filterByText() {
  var userInput = $(this).val();
  $('.link').each(function(index, link) {
    var $link = $(link);
    var title = $link.find('p.link-title').text();
    var url = $link.find('p.link-url').text();

    if (title.indexOf(userInput) !== -1 || url.indexOf(userInput) !== -1) {
      $link.show();
    } else {
      $link.hide();
    }
  })
}
