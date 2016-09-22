var Accordion = (function () {
  return {
    setup: function (app) {
      app.ports.toggleAccordion.subscribe(function(data) {
        var [name, id, speed] = data;
        var accordionList = $("#" + name);
        var elem = accordionList.find("#" + id);

        jQuery(elem).parent().find('.submenu').slideToggle(speed);
      });
    }
  }
})();
