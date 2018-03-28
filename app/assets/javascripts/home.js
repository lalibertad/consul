//= require jquery
//= require jquery_ujs
//= require foundation
//= require app
//= require dropdown
//= require olark

$(function(){
  App.Dropdown.initialize();
  $('.notice-container').css('z-index','10000');
  $('#menu_respon').click(function () {
    if ($('#responsive_menu').is(':visible')){
      $('.mbr-navbar__section').css('background','#004a83');
    } else {
      $('.mbr-navbar__section').css('background','');
    }
  });
  $('li').hover(
    function () {
      $('li').removeClass('active');
    },
    function () {
      $(this).addClass('active');
    }
  );
});

(jQuery),$.isMobile=function(t){var e=[],n={blackberry:"BlackBerry",android:"Android",windows:"IEMobile",opera:"Opera Mini",ios:"iPhone|iPad|iPod"};return t="undefined"==$.type(t)?"*":t.toLowerCase(),"*"==t?e=$.map(n,function(t){return t}):t in n&&e.push(n[t]),!(!e.length||!navigator.userAgent.match(new RegExp(e.join("|"),"i")))};$(function(){$("html").addClass($.isMobile()?"mobile":"desktop"),$(window).scroll(function(){$(".mbr-navbar--sticky").each(function(){var t=$(window).scrollTop()>10?"addClass":"removeClass";$(this)[t]("mbr-navbar--stuck").not(".mbr-navbar--open")[t]("mbr-navbar--short")})})});

