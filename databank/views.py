from django.shortcuts import render
from django.views import generic

# Create your views here.
from .models import Query, Footprints
from django.shortcuts import render, get_object_or_404, redirect, HttpResponse, render_to_response, HttpResponseRedirect

from django.contrib.auth import authenticate, login


def index(request):
    """
    View function for home page (index.html) of site. 
    """
    # Generate counts of the main obejcts (rows) in Position table/model
    #bounding_box = Query.objects.all()
    bounding_box = Query.objects.last()

    num_visits = request.session.get('num_visits', 0)
    request.session['num_visits'] = num_visits + 1

    # Render the HTML template index.html with the data in the context variable
    return render(
        request,
        'index.html',
        context={'bounding_box': bounding_box},
    )


def download(request):
    """
    View function for the download sidebar.
    
    tableXmax = footprints.objects.raw('SELECT id,max_x FROM footprints')
    tableXmin = footprints.objects.raw('SELECT id,min_x FROM footprints')
    tableYmax = footprints.objects.raw('SELECT id,max_y FROM footprints')
    tableYmin = footprints.objects.raw('SELECT id,min_y FROM footprints')
    paths = footprints.objects.raw('SELECT id,path FROM footprints')

    def judge():
        xMax = tableXmax
        xMin = tableXmin
        yMax = tableYmax
        yMin = tableYmin
        pList = paths
        szamlalo = len(list(xMin))
        lista = []
        for szam in szamlalo:
            if((xMin[szam] >= Position.min_x and yMin[szam] >= Position.min_y and xMax[szam] <= Position.max_x and yMax[szam] <= Position.max_y)):
                lista.append(pList[szam])
        return lista

    outPath = judge()

    """

    last_query = Query.objects.last()
    extents = {
        'max_x': last_query.max_x,
        'min_x': last_query.min_x,
        'max_y': last_query.max_y,
        'min_y': last_query.min_y,
    }

    # Render the HTML template download.html.

    return render(
        request,
        'output.html',
        context=extents,
    )


# import json

def getdata(request):

    """
    View function that gets the input data from the bounding box via a GET request,
    and immideately inserts it in the table, with the username.
    """
    if request.user.is_authenticated:
        username = request.user.username

    # If the request is GET, get the values from the front-end, and insert it in the Position table as a new row.
    if request.method == 'GET':
        try:
            maxX = request.GET['max_x']
            minX = request.GET['min_x']
            maxY = request.GET['max_y']
            minY = request.GET['min_y']
            extents = {
                'max_x': maxX,
                'min_x': minX,
                'max_y': maxY,
                'min_y': minY,
            }

            query = Query(max_x=maxX, min_x=minX, max_y=maxY, min_y=minY, username=username)
            query.save()
            return HttpResponse(extents)
        except Exception as e:
            print(e)
    else:
        return HttpResponse("Request method is not a GET")
    # res1 = "<html><b> you sent a get request </b> <br> returned data: %s</html>" % maxX
    # res2 = "<html><b> you sent a get request </b> <br> returned data: %s</html>" % minX
    # res3 = "<html><b> you sent a get request </b> <br> returned data: %s</html>" % maxY
    # res4 = "<html><b> you sent a get request </b> <br> returned data: %s</html>" % minY

def printdata(request):
    """
    figyu,
    elküldöd az extenteket a kliensről,
    megkapod itt,
    lekérdezed az adatbázist,
    és rendereled a kimenő download paget a downlaod htmlből és a kapott query eredmény fájl elérési utakkal
    """
    extents = Query.objects.last()

    """
    View function that gets the input data from the bounding box via a GET request,
    and immideately inserts it in the table, with the username.
    """
    return render(
        request,
        'output.html',
        context=extents,
    )


#
#
# # Output html for developer purposes.
# class QueryList(generic.ListView):
#     model = Query
#     # template_name = '*.html'

