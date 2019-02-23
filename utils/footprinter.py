#script to create footprints from .jpg + .jgw files
#created by Andrew Gudmann(@gudmandras), University of Szeged, Department of Physical Geography and Geoinformatics, 2019.

import os,glob,ntpath,osr
import gdal
from gdal import ogr
print("Script to create shapefile from .jpg + .jgw files!")
filePath = input("Give the absolute path of the .jpg files:\n")
if(os.path.isdir(filePath) != False):
    jpgFiles = glob.glob(filePath + "/*.jpg")

    #creating shapefile
    driver = ogr.GetDriverByName("ESRI Shapefile")
    data_source = driver.CreateDataSource(filePath + "/footprints.shp")
    multipolygon = ogr.Geometry(ogr.wkbMultiPolygon)
    srs = osr.SpatialReference()
    srs.ImportFromEPSG(4326)
    layer = data_source.CreateLayer("footprints", srs,  ogr.wkbPolygon)

    #define attribute table
    field_name = ogr.FieldDefn("Name", ogr.OFTString)
    field_name.SetWidth(40)
    field_path = ogr.FieldDefn("Path", ogr.OFTString)
    field_path.SetWidth(100)
    layer.CreateField(field_name)
    layer.CreateField(field_path)
    layer.CreateField(ogr.FieldDefn("xmin", ogr.OFTReal))
    layer.CreateField(ogr.FieldDefn("ymin", ogr.OFTReal))
    layer.CreateField(ogr.FieldDefn("xmax", ogr.OFTReal))
    layer.CreateField(ogr.FieldDefn("ymax", ogr.OFTReal))

    for jpg in jpgFiles:

        #get absolute coordinates(minx,miny,maxx,maxy), and file name
        data = gdal.Open(jpg)
        geotrans = data.GetGeoTransform()
        minX = geotrans[0]
        maxX = minX + (geotrans[1] * data.RasterXSize)
        maxY = geotrans[3]
        minY = maxY + (geotrans[5] * data.RasterYSize)
        name = ntpath.basename(jpg)

        #define variables
        feature = ogr.Feature(layer.GetLayerDefn())
        rectangle = ogr.Geometry(ogr.wkbLinearRing)
        polygon = ogr.Geometry(ogr.wkbPolygon)

        #set polygon
        Eov = osr.SpatialReference()
        Eov.ImportFromEPSG(23700)
        Wgs = osr.SpatialReference()
        Wgs.ImportFromEPSG(4326)
        transform = osr.CoordinateTransformation(Eov,Wgs)
        minx, miny = transform.TransformPoint(minX,minY)[:2]
        rectangle.AddPoint(minx,miny)
        minx, maxy = transform.TransformPoint(minX,maxY)[:2]
        rectangle.AddPoint(minx,maxy)
        maxx, maxy = transform.TransformPoint(maxX,maxY)[:2]
        rectangle.AddPoint(maxx,maxy)
        maxx, miny = transform.TransformPoint(maxX,minY)[:2]
        rectangle.AddPoint(maxx,miny)
        minx, miny = transform.TransformPoint(minX,minY)[:2]
        rectangle.AddPoint(minx,miny)
        polygon.AddGeometry(rectangle)
        feature.SetGeometry(polygon)

        #Set attributes
        feature.SetField("Name", name)
        feature.SetField("Path", os.path.abspath(name))
        feature.SetField("xmin", minx)
        feature.SetField("ymin", miny)
        feature.SetField("xmax", maxx)
        feature.SetField("ymax", maxy)

        layer.CreateFeature(feature)
        data = None
        feature = None
    data_source = None
else:
    print("The path is incorrect!")