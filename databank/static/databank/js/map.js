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

//add layers to baselayers
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

// get the path name from browser
var path = window.location.pathname;

// if the path is not pointing to download, the polygon button and with that the polygon drawing is possible 
if(path != "/databank/download/"){
    mymap.addControl(new polygonButton());
}