$(document).ready(function() {

    debug.info(document.location.pathname)
    basepath = document.location.pathname.substring(0, document.location.pathname.length-4)

    $("#card_entry").focus()

    $("span.delete_run").live("click", function(e){
        var rowId = $(e.target).parent().parent().attr("id")
        var runId = rowId.substring(3)
        debug.info("deleting run " + runId)
        var path = basepath + "runs/" + runId
        $.ajax({
            type: "DELETE",
            url: path,
            success: function(msg){
                debug.info("run " + runId + " was deleted")
                $("#" + rowId).remove()
            }
        });
        $("#card_entry").focus()
        e.stopImmediatePropagation()
    })

    //tab - 0
    //enter = 13
    $("#card_entry").keypress(function(e) {
        if (e.which == 13) {
            addCard()
        }
    })

    $("#add_card_button").click(function() {
        addCard()
    } )
});

var basepath = ""
var pendingTracker = 0

function addCard() {
    var entryText = $("#card_entry")[0].value
    parsed = parseInput(entryText)
    count = parsed.count
    name = parsed.name

    debug.info("Sending addition of " + count + " " + name)

    pendingTracker += 1
    pendingId = "pending" + pendingTracker

    createRow("#blank_pending_row", pendingId, count, name)

    url = basepath + "runs"
    $.post(
        url,
        {count: count, card_name: name},
        function(data) {
            onCardAdded(data, pendingId)
        },
        'json'
    )
    $("#card_entry").value = ""
    $("#card_entry")[0].value = ""
    $("#card_entry").focus()
} // End of addCard

function parseInput(entryText) {
    var countOut = 1
    var nameOut = entryText

    match = entryText.match(/^(\d+|x\d+|\d+x)\s+(\w+.*)$/)
    if (match) {
        countOut = match[1]
        nameOut = match[2]
    }
    return {count:countOut, name:nameOut}
} // End of parseInputs

function onCardAdded(data, pendingId) {
    $("#" + pendingId).remove()
    var runId = "#run" + data.run.id
    if ($(runId).length == 0) addNewRow(data)
    else appendRow(runId, data)
}

function addNewRow(data) {
    var run = data.run
    var cardtype = data.run.card.cardtype
    if (cardtype == null) cardtype = "unknown"
    debug.info("Card type: " + cardtype)

    var blankRowId = "#blank_" + cardtype + "_row"
    createRow(blankRowId,
        "row" + run.id, run.count, run.card.name,
        run.card.mtg_id, run.card.cc, run.card.cmc)
}

function appendRow(runId, data) {
    $(runId + " td.run_count").html( data.run.count )
}

function createRow(slotSelector, rowId, count, name, mtgId, cc, cmc) {
    if (arguments.length < 7 || cmc == null) cmc = ""
    if (arguments.length < 6) cc = ""

    var nameDisplay = name
    if (arguments.length < 5 || mtgId == null) {
        mtgId = ""
    } else {
        nameDisplay = "<a href=\"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=" +
            mtgId +
            "\">" +
            name +
            "</a>"
    }

    $(slotSelector).after(
        "<tr id=\"" + rowId + "\"><td>" +
        "</td><td>"+ count +
        "</td><td>"+ nameDisplay +
        "</td><td>"+ mtgId +
        "</td><td>"+ cc +
        "</td><td>"+ cmc +
        "<td><span class='delete_run' href=''>X</span></td></tr>"
        )
}

function createPendingRow(slotSelector, rowId, count, name) {
    $(slotSelector).after(
        "<tr id=\"" + rowId + "\"><td>" +
        "</td><td>"+ count +
        "</td><td>"+ name +
        "<td><span class='delete_run' href=''>X</span></td></tr>"
        )
}

function createUnknownRow(slotSelector, rowId, count, name) {
    $(slotSelector).after(
        "<tr id=\"" + rowId + "\"><td>" +
        "</td><td>"+ count +
        "</td><td>"+ name +
        "<td><span class='delete_run' href=''>X</span></td></tr>"
        )
}