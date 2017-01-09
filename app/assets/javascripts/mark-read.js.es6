var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-read', function(){
    var $this = $(this);
    var linkId = $this.parents('.link').data('id');
    var link_url = $(this).parent().siblings(".link-url").text()
    var hot_reads_url = 'https://calawayhotreads.herokuapp.com'
    // var hot_reads_url = 'http://0.0.0.0:3001'

    updateRead(linkId);

    $.ajax({
      url: `${hot_reads_url}/api/v1/reads`,
      method: 'POST',
      data: {url: link_url}
    })
  })
})

function updateRead(linkId) {
  $.ajax({
    url: '/api/v1/links/' + linkId,
    method: 'PATCH',
    data: {toggle_read: true}
  })
  .done( showReadStatus );
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
