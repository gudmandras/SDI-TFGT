//Js part for bounding box generate.

//BoundingBox object has two arrays & contains all the coordinates.
var boundingBox = {
    X: [],
    Y: []
};
var judge;
var Latitude;
var Longitude;
var szamlalo = 0;
var bool;
var vonal = [];
var teglalap = [];
var coordinates = [];
var markersLayer = L.layerGroup();
var polylineLayer;
var polygonLayer;

// //What happen if the polygon control button clicked.
// $("#polygon").click(function () {
//     if (judge === false) {
//         judge = true;
//         $("#polygon").css("background-color", "green");
//     } else if (judge === true) {
//         judge = false;
//         disabler();
//         $("#polygon").css("background-color", "white");
//     } else {
//         judge = true;
//         $("#polygon").css("background-color", "green");
//     }
// });


// //Necesseary because to avoid new marker at the control button click.
// $("#myMap").click(function (e) {
//     if ($(".leaflet-control-container").is(":hover") != true) {
//         boundingBoxer();
//     }
// });
//
// function boundingBoxer() {
//
//     if (judge === true) {
//
//         //Alert if there is more than X points.
//         //Also manages the value of the bool variable, so onMapclick doesn't run multiple times.
//         if (szamlalo > 4) {
//             alert("Legfeljebb 4 pontot rakhatsz le.");
//             bool = true;
//         } else if (szamlalo > 3) {
//             bool = true;
//             szamlalo++;
//         } else {
//             bool = false;
//         }
//
//         //On click this takes the lats and lngs and puts them in an array.
//         mymap.on('click', onMapClick);
//
//         function onMapClick(e) {
//             if (!bool) {
//                 bool = true;
//                 Latitude = e.latlng.lat;
//                 Longitude = e.latlng.lng;
//                 boundingBox.X[szamlalo] = Latitude.toFixed(4);
//                 boundingBox.Y[szamlalo] = Longitude.toFixed(4);
//                 markerMaker(szamlalo);
//                 //lineMaker(szamlalo);
//                 polygonMaker(szamlalo);
//                 //populateTable(szamlalo);
//                 szamlalo++;
//
//                 //For debugging.
//                 console.log("szamlalo:" + szamlalo);
//             }
//         }
//     }
// }

//Creating marker layer.
function markerMaker(number) {
    L.marker([Latitude, Longitude]).addTo(markersLayer);
    markersLayer.addTo(mymap);
};

//Adding line layer, if there is just two markers.
//function lineMaker(number){
//    if(number==1){
//    vonal[0] = [[boundingBox.X[(number-1)],boundingBox.Y[(number-1)]],[Latitude,Longitude]];
//    polylineLayer = L.polyline(vonal,{color:'black'}).addTo(mymap);
//    }
//};

//Adding a poligon if there is at least 3 markers.
function polygonMaker(number) {
    if (number > 2) {
        //mymap.removeLayer(polylineLayer);
        mymap.removeLayer(polygonLayer);
        teglalap = [];
    }
    ;
    for (a = 0; a <= number; a++) {
        coordinates[a] = [boundingBox.X[a], boundingBox.Y[a]];
        teglalap.push(coordinates[a]);
    }
    polygonLayer = L.polygon(teglalap, {color: 'green', opacity: 0.6}).addTo(mymap);
};

//Poulating the table on the sidebar.
/*function populateTable(number){

    var edit = '<button id="editButton'+number+'" onclick="edit()"><i class="fas fa-edit"></i></button>';
    var dlt = '<button id="deleteButton'+number+'" onclick="delet()"><i class="fa fa-trash"></i></button>';
    
    if(number == 0){
        document.getElementById("crd1").innerHTML = boundingBox.X[number] + ", " + boundingBox.Y[number];
        document.getElementById("edt1").innerHTML = edit;
        document.getElementById("dlt1").innerHTML = dlt;
    }else if(number == 1){
        document.getElementById("crd2").innerHTML = boundingBox.X[number] + ", " + boundingBox.Y[number];
        document.getElementById("edt2").innerHTML = edit;
        document.getElementById("dlt2").innerHTML = dlt;
    }else if(number == 2){
        document.getElementById("crd3").innerHTML = boundingBox.X[number] + ", " + boundingBox.Y[number];
        document.getElementById("edt3").innerHTML = edit;
        document.getElementById("dlt3").innerHTML = dlt;
    }else if(number == 3){
        document.getElementById("crd4").innerHTML = boundingBox.X[number] + ", " + boundingBox.Y[number];
        document.getElementById("edt4").innerHTML = edit;
        document.getElementById("dlt4").innerHTML = dlt;
    }else{
        
    }
}*/
/*function edit(){

}
function delet(){

}*/

//Clicking on the "Elvetés" button clears the table on the sidebar and sets all variable to default.
/*function clearTable(){
    document.getElementById("crd1").innerHTML = "";
    document.getElementById("edt1").innerHTML = "";
    document.getElementById("dlt1").innerHTML = "";
    document.getElementById("crd2").innerHTML = "";
    document.getElementById("edt2").innerHTML = "";
    document.getElementById("dlt2").innerHTML = "";
    document.getElementById("crd3").innerHTML = "";
    document.getElementById("edt3").innerHTML = "";
    document.getElementById("dlt3").innerHTML = "";
    document.getElementById("crd4").innerHTML = "";
    document.getElementById("edt4").innerHTML = "";
    document.getElementById("dlt4").innerHTML = "";
    cleaner();
}*/


//Disabling the feature creating and delete every feature on the map, set all variables to default.
function disabler() {
    /*markersLayer.clearLayers();
    mymap.removeLayer(markersLayer);
//        mymap.removeLayer(polylineLayer);
    mymap.removeLayer(polygonLayer);
    $('.leaflet-interactive').remove();
    szamlalo = 0;
    vonal = [];
    teglalap = [];
    coordinates = [];
    boundingBox.X = [];
    boundingBox.Y = [];*/
    mymap.off("click", boundingBoxer());
}

function cleaner() {
    markersLayer.clearLayers();
    mymap.removeLayer(markersLayer);
    mymap.removeLayer(polygonLayer);
    $('.leaflet-interactive').remove();
    szamlalo = 0;
    vonal = [];
    teglalap = [];
    coordinates = [];
    boundingBox.X = [];
    boundingBox.Y = [];
}

function postData() {
    let data = {
        //Biggest and lowest values from the arrays.
        maxX: 46.3699,//float(Math.max(...boundingBox.X)),
        minX: 46.2504,//float(Math.min(...boundingBox.X)),
        maxY: 20.1583,//float(Math.max(...boundingBox.Y)),
        minY: 20.1027,//float(Math.min(...boundingBox.Y)),
        fileType: 'topo',//document.getElementById("type").value
    };

    //AJAX request to getdata view with the four coorinates.
    sendRequest(data);

}

let sendRequest = function (data) {
    $.ajax({
        url: 'get_data',
        type: 'GET',
        data: data,
        success: function (response) {
            console.log("Success!", response);
            let paths = response.data.paths;
            let footprints = response.data.extents;
            // let bb = response.data.bb;

            add_layers(footprints);
            add_download_div(paths);
        }
    })
};


$("#trash").hover(function () {
    bool = true;
    $("#trash").click(function (e) {
        cleaner();
    });
    retrue();
});

function retrue() {
    judge = true;
}