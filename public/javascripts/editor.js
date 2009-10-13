$(document).ready(function() {

    $("#card_entry").focus()

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

var pendingTracker = 0

function addCard() {
    var entryText = $("#card_entry")[0].value
    parsed = parseInput(entryText)
    count = parsed.count
    name = parsed.name

    debug.info("Sending addition of " + count + " " + name)
    var deckId = 1

    pendingTracker += 1
    pendingId = "pending" + pendingTracker

    url = "/decks/" + deckId + "/runs"
    $.post(
        url,
        {deck_id: deckId, count: count, card_name: name},
        function(data) {
            onCardAdded(data, pendingId)
        },
        'json'
    )
    
    $("#pending_header").after(
        "<tr id=\"" + pendingId + "\"><td></td><td>"+ count +
        "</td><td>"+ name +
        "</td><td></td><td>X</td></tr>"
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
    debug.info("Card added, return was: " + data)
    $("#" + pendingId).remove()
    var runId = "#run" + data.run.id
    if ($(runId).length == 0) addNewRow(data)
    else appendRow(runId, data)
}
function addNewRow(data) {
    var cardtype = data.run.card.cardtype
    debug.info("Card type: " + cardtype)
}
function appendRow(runId, data) {
    $(runId + " td.run_count").html( data.run.count )
}