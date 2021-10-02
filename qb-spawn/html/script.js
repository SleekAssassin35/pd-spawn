$(document).ready(function() {

    $(".container").hide();
    $("#submit-spawn").hide()

    window.addEventListener('message', function(event) {
        var data = event.data;
        if (data.type === "ui") {
            if (data.status == true) {
                $(".container").fadeIn().css("display", "flex");
            } else {
                $(".container").fadeOut(250);
            }
        }

        if (data.action == "setupLocations") {
            setupLocations(data.locations, data.houses)
        }

    })
})

var currentLocation = null

$(document).on('click', '.location', function(evt){
    evt.preventDefault(); //dont do default anchor stuff
    var location = $(this).data('location'); //get the text
    var type = $(this).data('type'); //get the text
    var label = $(this).data('label'); //get the text
    if (type !== "lab") {
        $("#spawn-label").html("Oyna")
        $("#submit-spawn").attr("data-location", location);
        $("#submit-spawn").attr("data-type", type);
        $("#submit-spawn").fadeIn(100)
        $.post('https://qb-spawn/setCam', JSON.stringify({
            posname: location,
            type: type,
        }));
        if (currentLocation !== null) {
            $(currentLocation).removeClass('selected');
        }
        $(this).addClass('selected');
        currentLocation = this
    }
});

$(document).on('click', '#submit-spawn', function(evt){
    evt.preventDefault(); //dont do default anchor stuff
    var location = $(this).data('location');
    var spawnType = $(this).data('type');

    $(".container").addClass("hideContainer").fadeOut("9000");
    setTimeout(function(){
        $(".hideContainer").removeClass("hideContainer");
    }, 900);
    if (spawnType !== "appartment") {
        $.post('https://qb-spawn/spawnplayer', JSON.stringify({
            spawnloc: location,
            typeLoc: spawnType
        }));
    } else {
        $.post('https://qb-spawn/chooseAppa', JSON.stringify({
            appType: location,
        }));
    }
});

function setupLocations(locations, myHouses) {
    var parent = $('.spawn-locations')
    $(parent).html("");

    $(parent).append('<div class="loclabel" id="location" data-location="null" data-type="lab" data-label="Başlamak için bir konum seç"><p><span id="null">Başlamak için bir konum seç</span></p></div>')
    
    setTimeout(function(){
        $(parent).append('<div class="location" id="location" data-location="current" data-type="current" data-label="Son konum"><p><span id="current-location">Son konum</span></p></div>');
        
        $.each(locations, function(index, location){
            $(parent).append('<div class="location" id="location" data-location="'+location.location+'" data-type="normal" data-label="'+location.label+'"><p><span id="'+location.location+'">'+location.label+'</span></p></div>')
        });

        if (myHouses != undefined) {
            $.each(myHouses, function(index, house){
                $(parent).append('<div class="location" id="location" data-location="'+house.house+'" data-type="house" data-label="'+house.label+'"><p><span id="'+house.house+'">'+house.label+'</span></p></div>')
            });
        }

        $(parent).append('<div class="submit-spawn" id="submit-spawn"><p><span id="spawn-label"></span></p></div>');
        $('.submit-spawn').hide();
    }, 100)
}