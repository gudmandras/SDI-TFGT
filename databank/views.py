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
    try:
        if request.user.is_authenticated:
            username = request.user.username

        bounding_box = {
            "min_y": float(request.GET['minY']),
            "min_x": float(request.GET['minX']),
            "max_y": float(request.GET['maxY']),
            "max_x": float(request.GET['maxX']),
            # 'data_type': request.GET['fileType'],
        }


        """
        I put the vounding box in the list as well. This is a workaround until postgis query works.
        ALSO THIS IS A MESS! CLEAR IT UP!
        """
        fp = footprints()
        paths, extents = fp.get_files(bounding_box)
        extents.insert(0, [bounding_box['min_y'], bounding_box['min_x'], bounding_box['max_y'], bounding_box['max_x']])

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
    except Exception as e:
        if not request.is_ajax() and request.method == "GET":
            print(e)
            status_code = 400
            message = "The request is not valid."
            explanation = "The server could not accept your request because it was not valid. " \
                          "Please try again and if the error keeps happening get in contact with us."
            return JsonResponse({'message': message, 'explanation': explanation}, status=status_code)
        else:
            print(e)
            status_code = 500
            message = "The server could not process your request."
            # You should log this error because this usually means your front end has a bug.
            # do you whant to explain anything?
            explanation = "Something went wrong on the server side. Contact your teacher."
            return JsonResponse({'message': message, 'explanation': explanation}, status=status_code)


def get_zipped(request):
    try:
        if request.user.is_authenticated:
            username = request.user.username

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
    except Exception as e:
        if not request.is_ajax() and request.method == "GET":
            print(e)
            status_code = 400
            message = "The request is not valid."
            explanation = "The server could not accept your request because it was not valid. " \
                          "Please try again and if the error keeps happening get in contact with us."
            return JsonResponse({'message': message, 'explanation': explanation}, status=status_code)
        else:
            print(e)
            status_code = 500
            message = "The server could not process your request."
            # You should log this error because this usually means your front end has a bug.
            # do you whant to explain anything?
            explanation = "Something went wrong on the server side. Contact your teacher."
            return JsonResponse({'message': message, 'explanation': explanation}, status=status_code)

    """
    Instead of creating zips on the server side, we should use a temp file, 
    that gets deleted by the garbage collector when it is not used anymore.
    
    """
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


# def download(request):
#     req = request.session['res']
#     print('beleleptem getdata')
#     return render(
#         request,
#         'download.html',
#         context={'outPath': req},
#     )


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
