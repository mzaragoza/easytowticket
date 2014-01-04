$(document).ready(function() {
  loadMessages = function() {
    $('#messages_box').load('/users/dashboard/_messages_box', function() {
      setTimeout(loadMessages, 10000);
    });
  };

  loadMessages();
});
