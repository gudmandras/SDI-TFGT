from django.shortcuts import render
from django.views import generic

# Create your views here.
from .models import footprints

from django.shortcuts import render, get_object_or_404, redirect, HttpResponse, render_to_response, HttpResponseRedirect, reverse
result_list = []

from django.contrib.auth import authenticate, login
import json

def index(request):
    """
    View function for home page (index.html) of site.
    """
    # Generate counts of the main obejcts (rows) in Position table/model
    # bounding_box = Position.objects.all()
    #num_visits=request.session.get('num_visits', 0)
    #request.session['num_visits'] = num_visits+1

    # Render the HTML template index.html with the data in the context variable
    return render(
        request,
        'index.html',
        context={'bounding_box':['yay']},
    )

def getdata(request):
    print('beleleptem download!!!!!!!!!!!!!', request.method)

    """
    View function that gets the input data from the bounding box via a GET request, 
    and immideately inserts it in the table, with the username.
    """
    if request.user.is_authenticated:
        username = request.user.username

    # If the request is GET, get the values from the front-end, and insert it in the Position table as a new row.
    if request.method == 'GET':

        print('itt probal downloadolni', request.GET)
        maxX = request.GET['max_x']
        minX = request.GET['min_x']
        maxY = request.GET['max_y']
        minY = request.GET['min_y']
        file_type = request.GET['file_type']

        extent = {
            "min_y": float(minY),
            "min_x": float(minX),
            "max_y": float(maxY),
            "max_x": float(maxX),
            'data_type': file_type
        }


        footprint = footprints()
        result_list = footprint.get_files(extent)
        print('sasddasdas',result_list)
        request.session['res'] = result_list

        # redirect = HttpResponseRedirect(reverse('paths:result_list'))
        # redirect['Location'] += '&'.join(['students={}'.format(x) for x in result_list])
        # return redirect

        # return redirect('../download/')
        return HttpResponse(result_list)

        # return render(
        #     request,
        #     'download.html',
        #     context={'outPath':result_list},
        # )
    else:
        return HttpResponse('<h1>Page not found</h1>')




def download(request):
    req = request.session['res']
    print('beleleptem getdata', req)
    return render(
        request,
        'download.html',
        context={'outPath':req},
    )


# #Output html for developer purposes.
# class PositionList(generic.ListView):
#     model = Position
#     #template_name = '*.html'

"""
    View function for the download sidebar.

    tableXmax = footprints.objects.raw('SELECT id,max_x FROM footprints')
    tableXmin = footprints.objects.raw('SELECT id,min_x FROM footprints')
    tableYmax = footprints.objects.raw('SELECT id,max_y FROM footprints')
    tableYmin = footprints.objects.raw('SELECT id,min_y FROM footprints')
    paths = footprints.objects.raw('SELECT id,path FROM footprints')

    # def judge():
    #     xMax = tableXmax
    #     xMin = tableXmin
    #     yMax = tableYmax
    #     yMin = tableYmin
    #     pList = paths
    #     szamlalo = len(list(xMin))
    #     lista = []
    #     for szam in szamlalo:
    #         if((xMin[szam] >= Position.min_x and yMin[szam] >= Position.min_y and xMax[szam] <= Position.max_x and yMax[szam] <= Position.max_y)):
    #             lista.append(pList[szam])
    #     return lista
    # 
    # outPath = judge()
    # 
    # 
"""
#
# outPath = footprints.judger()
#
# # Render the HTML template download.html.
# return render(
#     request,
#     'download.html',
#     context={'outPath':outPath},
# )