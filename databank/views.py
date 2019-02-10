from django.shortcuts import render
from django.views import generic

from django.shortcuts import render, HttpResponse, render_to_response, HttpResponseRedirect, reverse
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
import json

# Create your views here.
from .models import footprints




def index(request):
    """
    View function for home page (index.html) of site.
    """
    # Generate counts of the main obejcts (rows) in Position table/model
    # bounding_box = Position.objects.all()
    # num_visits=request.session.get('num_visits', 0)
    # request.session['num_visits'] = num_visits+1

    # Render the HTML template index.html with the data in the context variable
    return render(
        request,
        'index.html',
        context={'bounding_box': ['yay']},
    )


def get_layers(request):
    """
    View function that gets the input data from the bounding box via a GET request,
    and immideately inserts it in the table, with the username.
    """

    # if request.user.is_authenticated:
    #     username = request.user.username

    # If the request is not GET, 404; otherwise get the values from the front-end, and insert it in the Position table as a new row.
    # TODO:
    # - return 404
    if request.method == 'GET': HttpResponse('<h1>Page not found</h1>')


    print('bbbbbbbbbbbbbbbbbb', request)
    extent = {
        "min_y": float(request.GET['min_y']),
        "min_x": float(request.GET['min_x']),
        "max_y": float(request.GET['max_y']),
        "max_x": float(request.GET['max_x']),
        #'data_type': request.GET['fileType'],
    }
    return JsonResponse({
        'success': True,
        'url': 'download',
        'geometries': {
            'fp': [],
            'bb': extent,
        }
    })


def getdata(request):
    """
    View function that gets the input data from the bounding box via a GET request, 
    and immideately inserts it in the table, with the username.
    """

    # if request.user.is_authenticated:
    #     username = request.user.username

    # If the request is not GET, 404; otherwise get the values from the front-end, and insert it in the Position table as a new row.
    # TODO:
    # - return 404
    if request.method == 'GET': HttpResponse('<h1>Page not found</h1>')

    extent = {
        "min_y": float(request.GET['minY']),
        "min_x": float(request.GET['minX']),
        "max_y": float(request.GET['maxY']),
        "max_x": float(request.GET['maxX']),
        'data_type': request.GET['fileType'],
    }

    fp = footprints()
    paths = fp.get_files(extent)
    print('PATHS: ', paths)
    print('yay')
    request.session['res'] = paths
    data = {
        'extent': extent,
        'paths': paths,
    }
    print('PATHS: ', paths)

    return JsonResponse({
        'success': True,
        'url': 'get_layers',
        'data': extent,
    })

    # redirect = HttpResponseRedirect(reverse('download', args=(result_list[0])))
    # redirect['Location'] += '&'.join(['result={}'.format(x) for x in result_list])
    # return redirect

    # return redirect('../download/')
    # return HttpResponse(result_list)


def download(request, *args):
    req = request.session['res']
    print('beleleptem getdata', *args)
    return render(
        request,
        'download.html',
        context={'outPath': req},
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
