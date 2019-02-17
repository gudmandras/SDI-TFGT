from wsgiref.util import FileWrapper
from django.shortcuts import render
from django.views import generic
from zipfile import ZipFile
from django.shortcuts import render, HttpResponse, render_to_response, HttpResponseRedirect, reverse
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
import json
import os
from django.conf import settings
from django.contrib.staticfiles.templatetags.staticfiles import static
import io

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

def get_data(request):
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

    bounding_box = {
        "min_y": float(request.GET['minY']),
        "min_x": float(request.GET['minX']),
        "max_y": float(request.GET['maxY']),
        "max_x": float(request.GET['maxX']),
        # 'data_type': request.GET['fileType'],
    }

    fp = footprints()
    paths, extents = fp.get_files(bounding_box)
    extents.insert(0, [bounding_box['min_y'], bounding_box['min_x'], bounding_box['max_y'], bounding_box['max_x']])
    print('PATHS: ', paths)
    print('EXTENTS', extents)
    print('yay',static(paths[0]))

    footprnts = []
    for ext in extents:
        footprnts.append([
            [ext[1], ext[0]],
            [ext[3], ext[0]],
            [ext[3], ext[2]],
            [ext[1], ext[2]],
        ])
    # bounding_box = extents[0]
    # footprnts.pop(0)

    data = {
        # 'bb': bounding_box,
        'extents': footprnts,
        'paths': paths,
    }
    request.session['data'] = data

    return JsonResponse({
        'success': True,
        'data': data,
    })


def get_zipped(request):
    # if request.user.is_authenticated:
    #     username = request.user.username

    # If the request is not GET, 404; otherwise get the values from the front-end, and insert it in the Position table as a new row.
    # TODO:
    # - return 404
    if request.method == 'GET': HttpResponse('<h1>Page not found</h1>')
    paths = request.session['data']['paths']
    print('Following files will be zipped:')
    for file_name in paths:
        print(file_name)

    with ZipFile('databank/static/zips/images.zip', 'w') as zip:
        # writing each file one by one
        for file in paths:
            zip.write('D:\\SDI-TFGT\\databank\\static\\' + file)

    wrapper = FileWrapper(open('databank/static/zips/images.zip', 'rb'))
    content_type = 'application/zip'
    content_disposition = 'attachment; filename=export.zip'

    response = HttpResponse(wrapper, content_type=content_type)
    response['Content-Disposition'] = content_disposition
    return response

    # directory = './static/topo/'
    # file_paths = get_all_file_paths(directory, paths)
    #
    # writing files to a zipfile
    # zipp = io.BytesIO()
    # with ZipFile(zipp, 'w') as zip:
    #     # writing each file one by one
    #     for file in paths:
    #         zip.write('D:\\SDI-TFGT\\databank\\static\\' +file)
    #
    # content_type = 'application/zip'
    # content_disposition = 'attachment; filename=images.zip'
    #
    # response = HttpResponse(zipp.getvalue(), content_type=content_type)
    # response['Content-Disposition'] = content_disposition
    # return response


def get_all_file_paths(directory, paths):
    # initializing empty file paths list
    file_paths = []

    # crawling through directory and subdirectories
    for root, directories, files in os.walk(os.path.join(os.path.join(settings.BASE_DIR,'databank'),'static'),'topo'):
        for filename in files:
            # join the two strings in order to form the full filepath.
            filepath = os.path.join(root, filename)
            file_paths.append(filepath)

            # returning all file paths
    return file_paths






def download(request):
    req = request.session['res']
    print('beleleptem getdata')
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
