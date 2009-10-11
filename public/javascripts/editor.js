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

function addCard() {
    var entryText = $("#card_entry")[0].value
    parsed = parseInput(entryText)
    count = parsed.count
    name = parsed.name

    debug.info("Sending addition of " + count + " " + name)
    var deckId = 1
    url = "/decks/" + deckId + "/runs"
    $.post(
        url,
        {deck_id: deckId, count: count, card_name: name},
        onCardAdded,
        'json'
    )
    
    $("#pending_header").after(
        "<tr><td></td><td>"+ count +
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

function onCardAdded(data) {
    debug.info("Card added, return was: " + data)
} // End of onCardAdded