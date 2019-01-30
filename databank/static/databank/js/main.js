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

function redirect(){
    window.location.replace('/databank/download');
}

function indexing(){
    window.location.replace('/databank/');
}


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

