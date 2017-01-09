var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-read', function(){
    var $this = $(this);
    var linkId = $this.parents('.link').data('id');
    var link_url = $(this).parent().siblings(".link-url").text()
    var hot_reads_url = 'https://calawayhotreads.herokuapp.com'
    // var hot_reads_url = 'http://0.0.0.0:3001'

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: true}
    });

    $.ajax({
      url: `${hot_reads_url}/api/v1/reads`,
      method: 'POST',
      data: {url: link_url}
    })
  })
})
