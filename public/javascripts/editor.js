$(document).ready(function() {

    $("#land_entry_row input")[0].focus()

    //tab - 0
    //enter = 13
    $("input").keypress(function(e) {
        if (e.which == 13) {
            addCard( $(this).parent().parent()[0] )
        }
    })

    $("button.add_card_button").click(function() {
        addCard( $(this).parent().parent()[0] )
    } )
});

function addCard(row) {
    var count = $(row).find(".count_entry")[0].value
    var name = $(row).find(".name_entry")[0].value
    var type = row.id.split("_")[0]

    parsed = parseInputs(count, name)
    count = parsed.count
    name = parsed.name

    $(row).before("<tr><td></td><td>"+ count +"</td><td>"+ name +"</td><td></td><td>X</td></tr>")
    console.log("Sending addition of " + count + " " + name + ", which are type " + type)
    $(row).find(".count_entry")[0].value = ""
    $(row).find(".name_entry")[0].value = ""
    $(row).find("input")[0].focus()
} // End of addCard

function parseInputs(countIn, nameIn) {
    var countOut = countIn
    var nameOut = nameIn
    var match = countIn.match(/^(\d+|x\d+|\d+x)$/)
    if (match) {
        countOut = match[0]
    } else {
        match = countIn.match(/^(\d+|x\d+|\d+x)\s+(\w+.*)$/)
        countOut = match[1]
        nameOut = match[2]
    }
    return {count:countOut, name:nameOut}
} // End of parseInputs