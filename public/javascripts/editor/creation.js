var pendingTracker = 0

function addCard() {
    var entryText = $("#card_entry")[0].value
    var parsed = parseInput(entryText)
    var count = parsed.count
    var name = parsed.name

    debug.info("Sending addition of " + count + " " + name)

    pendingTracker += 1
    var pendingId = "pending" + pendingTracker

    createPendingRow("#blank_pending_row", pendingId, count, name)

    var url = basepath + "runs"
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
}

function createPendingRow(slotSelector, rowId, count, name) {
    $(slotSelector).after(
        "<tr id=\"" + rowId + "\"><td>" +
        "</td><td>"+ count +
        "</td><td>"+ name +
        "<td></td></tr>"
        )
}

function parseInput(entryText) {
    var countOut = 1
    var nameOut = entryText
    
    var match = entryText.match(/^(\d+|x\d+|\d+x)\s+(\w+.*)$/)
    if (match) {
        countOut = match[1]
        nameOut = match[2]
    }
    return {count:countOut, name:nameOut}
}

function onCardAdded(data, pendingId) {
    $("#" + pendingId).remove()
    var runId = "run" + data.run.id
    if (rowExists(runId)) {
        appendRow(runId, data)
    } else {
        addNewRow(data)
    }
    onCardsChanged()
}

function rowExists(rowId) {
    debug.info("checking existance of row " + rowId)
    if ($("tr#" + rowId).size() > 0) {
        return true
    } else if ($(".dynamic").filter(function() { return ($(this)[0].id == rowId); }).size() > 0) {
        return true
    } else {
        return false
    }
}

function appendRow(runId, data) {
    $("tr#" + runId + " td.run_count").html( data.run.count )
}

function addNewRow(data) {
    var run = data.run
    var cardtype = data.run.card.cardtype
    if (cardtype == null) cardtype = "unknown"
    debug.info("Card type: " + cardtype)
    
    var blankRowId = "#blank_" + cardtype + "_row"
    createRow(blankRowId, "run" + run.id, run.count, cardtype, run.card)
}

function createRow(slotSelector, rowId, count, cardtype, card) {
    if (cardtype == "unknown") createUnknownRow(slotSelector, rowId, count, card)
    else createMaindeckRow(slotSelector, rowId, count, card)
}

function createMaindeckRow(slotSelector, rowId, count, card) {
    var nameDisplay = "<a href=\"http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=" +
            card.mtgId +
            "\">" +
            card.name +
            "</a>"
    
    $(slotSelector).after(
        "<tr id=\"" + rowId + "\" class=\"dynamic\"><td>" +
        "</td><td>"+ count +
        "</td><td>"+ nameDisplay +
        "</td><td>"+ card.cc +
        "</td><td>"+ card.cmc +
        "<td><span class='delete_run' href=''>X</span></td></tr>"
        )
}

function createUnknownRow(slotSelector, rowId, count, card) {
    $(slotSelector).after(
        "<tr id=\"" + rowId + "\" class=\"unknown dynamic\">" +
        "<td class=\"run_count\">"+ count + "</td><td>"+ card.name +
        "</td><td><span class='delete_run' href=''>X</span></td></tr>"
        )
}