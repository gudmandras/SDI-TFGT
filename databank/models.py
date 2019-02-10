from django.db import models
from django.urls import reverse


# Create your models here.

# class Position(models.Model):
#     """
#     Model representing the max and min coordinates of the bounding box and the username of the User.
#     """
#
#     max_x = models.DecimalField('Max X', max_digits=6, decimal_places=4, default=0, help_text="Max X coordinate")
#     min_x = models.DecimalField('Min X', max_digits=6, decimal_places=4, default=0, help_text="Min X coordinate")
#     max_y = models.DecimalField('Max Y', max_digits=6, decimal_places=4, default=0, help_text="Max Y coordinate")
#     min_y = models.DecimalField('Min Y', max_digits=6, decimal_places=4, default=0, help_text="Min Y coordinate")
#     filetype = models.CharField(max_length= 50, default="nincs")
#     username = models.CharField(max_length=50, default="guest")
#
#     def get_absolute_url(self):
#         """
#         Returns the url to access a particular coordinate instance.
#         """
#         return reverse('position-detail', args=[str(self.id)])
#
#     def __str__(self):
#         """
#         String for representing the Model object.
#         """
#         return '{0}, {1}, {2}, {3}, {4}, {5}'.format(self.id, self.max_x, self.min_x, self.max_y, self.min_y, self.filetype)
#
#     def lastInput():
#         from django.db import connection
#         with connection.cursor() as cursor:
#             cursor.execute('SELECT id, min_y, min_x, max_y, max_x, filetype, username FROM databank_position WHERE id=( SELECT max(id) FROM databank_position)')
#             tup = cursor.fetchone()
#             return tup


class footprints(models.Model):
    min_y = models.DecimalField('Min Y', max_digits=13, decimal_places=10, default=0, help_text="Min Y coordinate")
    min_x = models.DecimalField('Min X', max_digits=13, decimal_places=10, default=0, help_text="Min X coordinate")
    max_y = models.DecimalField('Max Y', max_digits=13, decimal_places=10, default=0, help_text="Max Y coordinate")
    max_x = models.DecimalField('Max X', max_digits=13, decimal_places=10, default=0, help_text="Max X coordinate")
    path = models.CharField('Path', max_length=33, default='default')

    # name = models.CharField('Name', max_length=10, default='default')

    def get_files(self, extent):
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM databank_footprints')
            result_list = []
            for row in cursor.fetchall():
                yMin = row[1]
                xMin = row[2]
                yMax = row[3]
                xMax = row[4]
                path = row[5]
                if (extent['data_type'] != "topo"): return

                if ((xMin >= extent['min_x'] and yMin >= extent['min_y'] and xMax <= extent['max_x'] and yMax <=
                     extent['max_y']) or (
                        xMin >= extent['min_x'] and xMin <= extent['max_x'] and yMin >= extent['min_y'] and yMin <=
                        extent['max_y']) or (
                        xMin >= extent['min_x'] and xMin <= extent['max_x'] and yMax >= extent['min_y'] and yMax <=
                        extent['max_y']) or (
                        xMax >= extent['min_x'] and xMax <= extent['max_x'] and yMax >= extent['min_y'] and yMax <=
                        extent['max_y']) or (
                        xMax >= extent['min_x'] and xMax <= extent['max_x'] and yMin >= extent['min_y'] and yMin <=
                        extent['max_y'])):
                    result_list.append(path)
                    raw_file = path[:-4]
                    jgw_file = path.replace('.jgw', '.jpg')
                    result_list.append(jgw_file)

        return result_list
    # return extent[0:6]


def __str__(self):
    """
    String for representing the Model object.
    """
    return '{0}, {1}, {2}, {3}, {4}, {5}'.format(self.id, self.max_x, self.min_x, self.max_y, self.min_y, self.path)


"""
((xMin[szam] >= Position.min_x and yMin[szam] >= Position.min_y and xMax[szam] <= Position.max_x and yMax[szam] <= Position.max_y) 
                or (xMin[szam] >= Position.min_x and xMin[szam] <= Position.max_x and yMin[szam] >= Position.min_y and yMin[szam] <= Position.max_y) 
                or (xMin[szam] >= Position.min_x and xMin[szam] <= Position.max_x and yMax[szam] >= Position.min_y and yMax[szam] <= Position.max_y) 
                or (xMax[szam] >= Position.min_x and xMax[szam] <= Position.max_x and yMax[szam] >= Position.min_y and yMax[szam] <= Position.max_y) 
                or (xMax[szam] >= Position.min_x and xMax[szam] <= Position.max_x and yMin[szam] >= Position.min_y and yMin[szam] <= Position.max_y)):
"""
