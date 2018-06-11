function homescroll() {
  $(window).scroll(function() {
  //Header
  if ($(window).scrollTop() >= 100) {
    $(".header").addClass("fixed-top");
  } else {
    $(".header").removeClass("fixed-top");
  }
  //Footer
  var navpanel = $(".bottom-nav");
  var panelHeight = navpanel.height() - 4;
  var footerHeight = $(".footer").height();
  if (
    $(document).height() - panelHeight - footerHeight <=
    $(window).scrollTop() + $(window).height()
  ) {
    navpanel.removeClass("fixed-bottom");
  } else {
    navpanel.addClass("fixed-bottom");
  }
})
};

export { homeScroll };
