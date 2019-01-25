
//Created by Levente Csőke(@tardigre) and András Gudmann(@gudmandras)

//Js part for whole webpage.
//Content sizing to browser size.
var browserWidth = $(window).width();
var browserHeight = $(window).height();
$('#logo').css('width',(browserWidth*0.98));
$('#logo').css('height',(browserHeight*0.2));
$('.col-9').css('width', browserWidth);
$('.col-9').css('height',(browserHeight*0.775));
$('#mainContent').css('width', (browserWidth*0.975));
$('#mainContent').css('height',(browserHeight*0.775));

//Content resizing if the browser size changed.
$(window).resize(function(){
    browserWidth = $(window).width();
    browserHeight = $(window).height();
    $('#logo').css('width',(browserWidth*0.98));
    $('#logo').css('height',(browserHeight*0.2));
    $('.col-9').css('width', browserWidth);
    $('.col-9').css('height',(browserHeight*0.775));
    $('#mainContent').css('width', (browserWidth*0.975));
    $('#mainContent').css('height',(browserHeight*0.775));
});

//Js part for map content.
//Define 3 layers.
var Esri_WorldTopoMap = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community'
});
var Esri_WorldImagery = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
});
var Esri_WorldShadedRelief = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Source: Esri',
	maxZoom: 13
});
var baseLayers = {
    "Topography": Esri_WorldTopoMap,
    "Satellite": Esri_WorldImagery,
    "Relief":Esri_WorldShadedRelief,
};

//Define map.
var mymap = L.map('myMap',{
    center:[46.252483,20.148284],
    zoom: 13,
    layers:[Esri_WorldTopoMap]
});
L.control.layers(baseLayers).addTo(mymap);

//Js for new menu button(polygon).
var polygonButton = L.Control.extend({
	options:{
		position: 'topleft'
	},
	onAdd: function(mymap){
        var container = L.DomUtil.create('div', 'leaflet-bar leaflet-control leaflet-control-custom');
        container.id = "polygon";
		container.style.backgroundColor = 'white';
		container.style.backgroundImage = "url(http://icons.iconarchive.com/icons/icons8/android/256/Maps-Polygon-icon.png)";
		container.style.backgroundSize = '100% 100%';
		container.style.width = '30px';
		container.style.height = '30px';
		return container;
	}
});

mymap.addControl(new polygonButton());

//Js part for bounding box generate.

//BoundingBox object has two arrays & contains all the coordinates.
var boundingBox={
    X:[],
    Y:[]
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

//What happen if the polygon control button clicked.
$("#polygon").click(function(){
    if(judge===false){
        judge=true;
        $("#polygon").css("background-color","green");
    }else if(judge===true){
        judge=false;
        disabler();
        $("#polygon").css("background-color","white");  
    }else{
        judge=true;
        $("#polygon").css("background-color","green");
    }
});


//Necesseary because to avoid new marker at the control button click.
$("#myMap").click(function(e){
    if($(".leaflet-control-container").is(":hover")!=true){
        boundingBoxer();
    }
});
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
};*/

//Functions for features creating on map.
function boundingBoxer(){
    
    if(judge===true){

        //Alert if there is more than X points.
        //Also manages the value of the bool variable, so onMapclick doesn't run multiple times.
        if(szamlalo > 4){
            alert("Legfeljebb 4 pontot rakhatsz le.");
            bool = true; 
        }else if (szamlalo > 3){
            bool = true; 
            szamlalo++;
        }else{
            bool = false;
        }
        
        //On click this takes the lats and lngs and puts them in an array.
        mymap.on('click', onMapClick);
        function onMapClick(e){
            if(!bool){   
                bool = true;       
                Latitude = e.latlng.lat;
                Longitude = e.latlng.lng;
                boundingBox.X[szamlalo] = Latitude.toFixed(4);
                boundingBox.Y[szamlalo] = Longitude.toFixed(4);     
                markerMaker(szamlalo);
                lineMaker(szamlalo);
                polygonMaker(szamlalo);
                populateTable(szamlalo);
                szamlalo++;
                
				//For debugging.
                console.log("szamlalo:" + szamlalo);
            }
       }       
    }
}

//Creating marker layer.
function markerMaker(number){
    L.marker([Latitude,Longitude]/*, {draggable: 'true'}*/).addTo(markersLayer); 
    /*marker.on('dragend', function(event){
        var marker = event.target;
        var position = marker.getLatLng();
        
        marker.setLatLng(new L.LatLng(position.lat, position.lng),{draggable:'true'});
      });*/
    markersLayer.addTo(mymap);
};

//Adding line layer, if there is just two markers.
function lineMaker(number){
    if(number==1){
    vonal[0] = [[boundingBox.X[(number-1)],boundingBox.Y[(number-1)]],[Latitude,Longitude]];
    polylineLayer = L.polyline(vonal,{color:'black'}).addTo(mymap);
    }
};

//Adding a poligon if there is at least 3 markers.
function polygonMaker(number){
    if(number>=2){
        mymap.removeLayer(polylineLayer);
        mymap.removeLayer(polygonLayer);
        teglalap = [];
    };
    for(a=0;a<=number;a++){
        coordinates[a] = [boundingBox.X[a],boundingBox.Y[a]];
        teglalap.push(coordinates[a]);
    }
    polygonLayer = L.polygon(teglalap,{color:'green',opacity:0.6}).addTo(mymap);
    };

//Poulating the table on the sidebar.
function populateTable(number){

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
}
function edit(){

}
function delet(){

}

//Clicking on the "Elvetés" button clears the table on the sidebar and sets all variable to default.
function clearTable(){
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
    disabler();
}

//Disabling the feature creating and delete every feature on the map, set all variables to default.
function disabler(){
        markersLayer.clearLayers();
        mymap.removeLayer(polygonLayer);
        szamlalo = 0;
        vonal = [];
        teglalap = [];
        coordinates = [];
        boundingBox.X = [];
        boundingBox.Y = [];
        mymap.off("click",boundingBoxer());
}

function postData(){
	//Biggest and lowest values from the arrays.
	var maxX = Math.max(...boundingBox.X);
	var minX = Math.min(...boundingBox.X);
	var maxY = Math.max(...boundingBox.Y);
	var minY = Math.min(...boundingBox.Y);
	
	//AJAX request to getdata view with the four coorinates.
	$.ajax({
		url: "getdata/",
		type: "GET",
		data: {'max_x': maxX , 'min_x' : minX, 'max_y': maxY , 'min_y' : minY},
		success: function(){
			console.log("Success!");
		}
    });  

    return true;
}

function redirect(){
    window.location.replace('/databank/download');
}

function indexing(){
    window.location.replace('../');
}

//Known bugs.
/**
* A rajz gombra kattintva(kikapcsolás) kiürülnek az array-ek, 
* de a tábla ott marad és nem frissül ha új gomblenyomások érkeznek
* 
*/ 

//OLD CODES....
//--------------------------------------------------------------------------------------------------//
/** 
controlling the mouse move on the map
$("#myMap").mousemove(function(e){
    judger();
});

function judger(){
    if($(".leaflet-control-container").is(":hover")!=true){
        boundingBoxer();
    }
};

function modifier(number){
    if(boundingBox.X[number]==boundingBox.X[(number-1)]){
        boundingBox.X.splice((number-1),1);
    }
    if(boundingBox.Y[number]==boundingBox.Y[(number-1)]){
        boundingBox.Y.splice((number-1),1);
        if(number>0){
            szamlalo--;
        }
    }
}
//dinamikus ID meghatározás nem sikerült első körben
    var idSzam = number + 1;
    var crdId = '"' + "crd" + idSzam + '"';
    alert(crdId);
    for(var i = -1; i < number; i++){
        if(number - 1 == i ){
            document.getElementById("crd1").innerHTML = Latitude + ", " + Longitude;
        }else if(number > 7){
            alert("Legfeljebb 8 pontot adhatsz meg.");
        }else{
            alert("Oppá! Valami nincs rendben.");
        }
    }


function createButton(number){
    var edit = '<button id="editButton'+number+'" onclick="editMe()"><i class="fas fa-edit"></i></button>';
    var dlt = '<button id="deleteButton'+number+'" onclick="deleteMe()"><i class="fa fa-trash"></i></button>';
    if(number == 0){
        document.getElementById("crd1").innerHTML = Latitude + ", " + Longitude;
        createButton(number);
    }else if(number == 1){
        document.getElementById("crd2").innerHTML = Latitude + ", " + Longitude;
        createButton(number);
        
    }else if(number == 2){
        document.getElementById("crd3").innerHTML = Latitude + ", " + Longitude;
        createButton(number);
        
    }else if(number == 3){
        document.getElementById("crd4").innerHTML = Latitude + ", " + Longitude;
        createButton(number);
    }else{
        alert("Legfeljebb 4 pontot rakhatsz le.")
    }
    
    document.getElementById("edt1").innerHTML = edit;
    document.getElementById("dlt1").innerHTML = dlt;
    document.getElementById("edt2").innerHTML = edit;
    document.getElementById("dlt2").innerHTML = dlt;
    document.getElementById("edt3").innerHTML = edit;
    document.getElementById("dlt3").innerHTML = dlt;
    document.getElementById("edt4").innerHTML = edit;
    document.getElementById("dlt4").innerHTML = dlt;
    var btn = document.createElement("BUTTON");
    var t = document.createTextNode("CLICK ME");
    btn.appendChild(t);
    document.body.appendChild(btn);
}
*/

