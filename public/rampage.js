var state = {};
$(function() {
  $("a").live("click", function() {
    history.pushState({}, "Know Your Rampage", this.href);
    onURLUpdate();
    return false;
  });
});
window.onpopstate = function(ev) {
  if (!arguments.callee.initialised) {
    arguments.callee.initialised = true;
    return;
  }
  onURLUpdate();
}
function onURLUpdate() {
  var matches;
  if (document.location.pathname=="/monsters") {
    $.getJSON("/monsters.json", function(monsters) {
      $("#main").fadeOut(function() {
        $(this).html(Mustache.to_html($("#monsters_template").html(), {monsters:monsters})).show();
      });
    });
  } else if (matches = document.location.pathname.match(/^\/monsters\/(.+)$/)) {
    var monsterID = matches[1];
    $.getJSON("/monsters/"+monsterID+".json", function(monster) {
      $("#main").fadeOut(function() {
        $(this).html(Mustache.to_html($("#monster_template").html(), {monster:monster})).show();
      });
    });
  } else { // can't handle it? Then we need to refresh.
    document.location = document.location;
  }
}

