$(document).ready(
  function() {

    debug.info(document.location.pathname);
    basepath = document.location.pathname.substring(0, document.location.pathname.length-4);

    $("#card_entry").focus();

    $("span.delete_run").live(
      "click",
      function(e){
	var rowId = $(e.target).parent().parent().attr("id");
	var runId = rowId.substring(3);
	debug.info("deleting run " + runId);
	var path = basepath + "runs/" + runId;
	$.ajax({
		 type: "DELETE",
		 url: path,
		 success: function(msg){
		   debug.info("run " + runId + " was deleted");
		   $("#" + rowId).remove();
		   onCardsChanged();
		 }
	       });
	$("#card_entry").focus();
	e.stopImmediatePropagation();
      });

    //tab - 0
    //enter = 13
    $("#card_entry").keypress(
      function(e) {
	if (e.which == 13) {
	  addCard();
	}
      });

    $("#add_card_button").click(
      function() {
	addCard();
      });

    onCardsChanged();
  }
);

var basepath = "";
var pendingTracker = 0;

function onCardsChanged() {
  loadManaCurveChart();
  updateTotal();
  var visibility = ($(".unknown").size() > 0 ) ? "visible" : "hidden";
  debug.info("setting unknown header to " + visibility);
  $("#unknown_header").css("visibility", visibility);
}

function loadManaCurveChart() {
  $.getJSON(basepath + "mana_curve_chart", displayManaCurveChart);
}
function displayManaCurveChart(chartData) {
  $("#mana_curve").attr("src", chartData.src);
}

function updateTotal() {

}