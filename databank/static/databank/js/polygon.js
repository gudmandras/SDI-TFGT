//Js part for bounding box generate.

//BoundingBox object has two arrays & contains all the coordinates.
/**
 * latlng FORMÁTUM; ezt most nemváltoztatom mert később úgyis változni fog a postdatás lekérdezés
 * length: 4​<prototype>: Array
 * 0: Object { lat: 46.25024631490105, lng: 20.086762538893883 }​
 * 1: Object { lat: 46.274336791488096, lng: 20.086762538893883 }​
 * 2: Object { lat: 46.274336791488096, lng: 20.168319236915174 }​
 * 3: Object { lat: 46.25024631490105, lng: 20.168319236915174 }​
 */

mymap.on(L.Draw.Event.CREATED, function (e) {
    var type = e.layerType,
        layer = e.layer;
    console.log(e.layer.getLatLngs());
    let latlng=e.layer.getLatLngs()[0];
    console.log(latlng);

    if (type === 'marker') {
        layer.bindPopup('A popup!');
    }

    editableLayers.addLayer(layer);
});


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


//OLD_CODE
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

// //Creating marker layer.
// function markerMaker(number) {
//     L.marker([Latitude, Longitude]).addTo(markersLayer);
//     markersLayer.addTo(mymap);
// };

//Adding line layer, if there is just two markers.
//function lineMaker(number){
//    if(number==1){
//    vonal[0] = [[boundingBox.X[(number-1)],boundingBox.Y[(number-1)]],[Latitude,Longitude]];
//    polylineLayer = L.polyline(vonal,{color:'black'}).addTo(mymap);
//    }
//};

//Adding a poligon if there is at least 3 markers.
// function polygonMaker(number) {
//     if (number > 2) {
//         //mymap.removeLayer(polylineLayer);
//         mymap.removeLayer(polygonLayer);
//         teglalap = [];
//     }
//     ;
//     for (a = 0; a <= number; a++) {
//         coordinates[a] = [boundingBox.X[a], boundingBox.Y[a]];
//         teglalap.push(coordinates[a]);
//     }
//     polygonLayer = L.polygon(teglalap, {color: 'green', opacity: 0.6}).addTo(mymap);
// };

// //Disabling the feature creating and delete every feature on the map, set all variables to default.
// function disabler() {
//     /*markersLayer.clearLayers();
//     mymap.removeLayer(markersLayer);
// //        mymap.removeLayer(polylineLayer);
//     mymap.removeLayer(polygonLayer);
//     $('.leaflet-interactive').remove();
//     szamlalo = 0;
//     vonal = [];
//     teglalap = [];
//     coordinates = [];
//     boundingBox.X = [];
//     boundingBox.Y = [];*/
//     mymap.off("click", boundingBoxer());
// }
//
// function cleaner() {
//     markersLayer.clearLayers();
//     mymap.removeLayer(markersLayer);
//     mymap.removeLayer(polygonLayer);
//     $('.leaflet-interactive').remove();
//     szamlalo = 0;
//     vonal = [];
//     teglalap = [];
//     coordinates = [];
//     boundingBox.X = [];
//     boundingBox.Y = [];
// }
//
// $("#trash").hover(function () {
//     bool = true;
//     $("#trash").click(function (e) {
//         cleaner();
//     });
//     retrue();
// });
//
// function retrue() {
//     judge = true;
// }