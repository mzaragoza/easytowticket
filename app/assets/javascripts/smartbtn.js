function agents_available() {
  document.getElementById('smartbutton').innerHTML = "<a class = 'chat_btn' onClick=\"window.open('https://admin.instantservice.com/links/5672/22767','chat_client','width=500,height=409,scrollbars=0') \">QUESTIONS? Chat with a live agent</a>";
}
function agents_not_available() {
  document.getElementById('smartbutton').innerHTML = '';
  return true;
}
document.write('<img src="https://rs.instantservice.com/resources/smartbutton' + '/5672/22767/available.gif?' + Math.floor(Math.random()*10001) + '"style="width:0;height:0;visibility:hidden;position:absolute;"' + 'onLoad="agents_available()" onError="agents_not_available()">');

