 document.querySelectorAll(".tradingview").forEach(function(row1){
   row1.addEventListener("click", function(){
    if (row1.parentNode.parentNode.children[1].style.display != "flex"){
     document.querySelectorAll(".tradingview").forEach(function(row){
       row.parentNode.parentNode.style.height = "10vh";
       row.parentNode.parentNode.children[0].style.height = "100%";
       row.parentNode.parentNode.children[1].style.display = "none";
     });
     row1.parentNode.parentNode.style.height = "63vh";
     row1.parentNode.parentNode.children[0].style.height = "30%";
     row1.parentNode.parentNode.children[1].style.display = "flex";
     const tradingviewid = row1.parentNode.parentNode.children[1].querySelector(".chart").id;
     new TradingView.widget(
     {
      "autosize": true,
      "symbol": "BINANCE:"+tradingviewid+"USD",
      "interval": "30",
      "timezone": "Etc/UTC",
      "theme": "Dark",
      "style": "1",
      "locale": "en",
      "toolbar_bg": "#f1f3f6",
      "enable_publishing": false,
      "allow_symbol_change": true,
      "no_referral_id": true,
      "container_id": tradingviewid
    }
    );
   }else {
    row1.parentNode.parentNode.style.height = "10vh";
    row1.parentNode.parentNode.children[0].style.height = "100%";
    row1.parentNode.parentNode.children[1].style.display = "none";
  }


})
 });

document.getElementById("search").addEventListener("keyup", function(){
  let search = document.getElementById("search").value.toUpperCase();
  document.querySelectorAll('.tablerow1').forEach(function(row){
    if(search == row.children[0].children[0].children[1].innerText){
      row.style.display = "flex";
    }else if(search == ""){
      row.style.display = "flex";
    }else {
      row.style.display = "none";
    }
  })
});

document.querySelector(".dropdown-toggle").addEventListener('click', function(){
  document.querySelector(".dropdown-toggle").parentNode.classList.add('open')
});
