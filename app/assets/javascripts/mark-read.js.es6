$(document).ready(function(){
  $('#links-list').on('click', 'button.mark-read', function(){
    var linkId = $(this).parents('.link').data('id');

    updateRead(linkId);
  })
})

function updateRead(linkId) {
  $.ajax({
    url: '/api/v1/links/' + linkId,
    method: 'PATCH',
    data: {toggle_read: true}
  })
  .done( function(link) {
    showReadStatus(link);
    if (link.read) {
      postHotRead(link);
    }
  });
}

function showReadStatus(link) {
  if (link.read === true) {
    $(`#link-${link.id}`).find('p.link_read').text('true')
    $(`#link-${link.id}`).find('button.mark-read').text('Mark as Unread')
    $(`#link-${link.id}`).addClass('read-link')
  } else if (link.read === false) {
    $(`#link-${link.id}`).find('p.link_read').text('false')
    $(`#link-${link.id}`).find('button.mark-read').text('Mark as Read')
    $(`#link-${link.id}`).removeClass('read-link')
  }
}

function postHotRead(link) {
  var hot_reads_url = 'https://calawayhotreads.herokuapp.com'

  $.ajax({
    url: `${hot_reads_url}/api/v1/reads`,
    method: 'POST',
    data: {url: link.url}
  })
}
