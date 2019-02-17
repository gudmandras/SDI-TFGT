//Created by Levente Csőke(@tardigre) and András Gudmann(@gudmandras)

//Js part for whole webpage.
//Content sizing to browser size.
var browserWidth = $(window).width();
var browserHeight = $(window).height();
$('#logo').css('width', (browserWidth * 0.98));
$('#logo').css('height', (browserHeight * 0.2));
$('.col-9').css('width', browserWidth);
$('.col-9').css('height', (browserHeight * 0.775));
$('#mainContent').css('width', (browserWidth * 0.975));
$('#mainContent').css('height', (browserHeight * 0.775));

//Content resizing if the browser size changed.
$(window).resize(function () {
    browserWidth = $(window).width();
    browserHeight = $(window).height();
    $('#logo').css('width', (browserWidth * 0.98));
    $('#logo').css('height', (browserHeight * 0.2));
    $('.col-9').css('width', browserWidth);
    $('.col-9').css('height', (browserHeight * 0.775));
    $('#mainContent').css('width', (browserWidth * 0.975));
    $('#mainContent').css('height', (browserHeight * 0.775));
});

// function redirect(url, geometries=geometries){
//     if(geometries){
//
//         window.location.href='/databank/download';
//         console.log('AAAAAAAAAAAAAAAAA');
//         add_layers(geometries);
//
//     }
//     else{
//         window.location.replace('/databank/');
//     }
// }
let add_download_div = function (paths) {
    let nt = '';
    let divItem3 = document.querySelector(".item3");
    let divItem5 = document.querySelector(".item5");
    let divItem6 = document.querySelector(".item6");
    let divItem7 = document.querySelector(".item7");

    divItem3.innerHTML = "<div class='item3'></div>";
    divItem7.innerHTML = "<div class='item7'></div>";
    divItem6.innerHTML = "<div class='item6'><button onclick='getZippedData()'>ZIP</button></div>";

    for (let p in paths) {
        let path = paths[p];
        let name = path.split('\\')[1];
        divItem5.innerHTML += "<a href='http://127.0.0.1:8000/static/topo/" + name + "' download='" + name + "'>" + name + "</a>\n";
    }

};

let getZippedData =function () {
    $.ajax({
        url: 'get_zipped',
        type: 'GET',
        data: "",
        success: function (response) {
            downlaod_zip_div(response);
        }
    })
};

let downlaod_zip_div = function (response){
    let divItem7 = document.querySelector(".item7");
    divItem7.innerHTML += "<a href='http://127.0.0.1:8000/static/zips/images.zip' download='images.zip'>Download ZIP</a>";
};

/**
 *pssibilities
 *  function onMapClick(e) {
        alert("You clicked the map at " + e.latlng);
    }

 mymap.on('click', onMapClick);
 * https://stackoverflow.com/questions/43210937/add-new-marker-when-i-click-on-the-map-openstreetmap-leaflet-js
 * https://stackoverflow.com/questions/16927793/marker-in-leaflet-click-event
 * NOW THIS IS A DEBATE!
 * The above code snippet works really fine,
 * but it requires one click before it can make markers by clicking.
 * The below code doesn't require an extra click before start,
 * but triggers the "too much markers" message every time you move the mouse on the map.
 * A midfield solution is required.

 $("#myMap").mousemove(function(e){
    judger();
});

 function judger(){
    if($(".leaflet-control-container").is(":hover")!=true){
        boundingBoxer();
    }
};
 */
//------------------------------------------------------------------------
//Creating marker layer.
//function markerMaker(number){
//L.marker([Latitude,Longitude]/*, {draggable: 'true'}*/).addTo(markersLayer);
/*marker.on('dragend', function(event){
    var marker = event.target;
    var position = marker.getLatLng();

    marker.setLatLng(new L.LatLng(position.lat, position.lng),{draggable:'true'});
  });*/
//markersLayer.addTo(mymap);
//};
//---------------------------------------------------------------------------
//Known bugs.
/**
 * A rajz gombra kattintva(kikapcsolás) kiürülnek az array-ek,
 * de a tábla ott marad és nem frissül ha új gomblenyomások érkeznek
 *
 */

