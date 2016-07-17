$(document).on('turbolinks:load', function() {
  submitNewMessage();
  $('#btn_test').on('click', function() {
    App.messages.perform('speak', {message: 'fixed message', user: 'fixed_user_name'});
  });
});

function submitNewMessage(){
  $('textarea#message_content').keydown(function(event) {
    if (event.keyCode == 13) {
        $('[data-send="message"]').click();
        $('[data-textarea="message"]').val(" ")
        return false;
     }
  });
}
