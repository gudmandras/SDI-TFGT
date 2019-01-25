from django.db import models
from django.urls import reverse

# Create your models here.

class Position(models.Model):
    """
    Model representing the max and min coordinates of the bounding box and the username of the User.
    """
   
    max_x = models.DecimalField('Max X', max_digits=6, decimal_places=4, default=0, help_text="Max X coordinate")
    min_x = models.DecimalField('Min X', max_digits=6, decimal_places=4, default=0, help_text="Min X coordinate")
    max_y = models.DecimalField('Max Y', max_digits=6, decimal_places=4, default=0, help_text="Max Y coordinate")
    min_y = models.DecimalField('Min Y', max_digits=6, decimal_places=4, default=0, help_text="Min Y coordinate")
    username = models.CharField(max_length=50, default="guest")

    def get_absolute_url(self):
        """
        Returns the url to access a particular coordinate instance.
        """
        return reverse('position-detail', args=[str(self.id)])

    def __str__(self):
        """
        String for representing the Model object.
        """
        return '{0}, {1}, {2}, {3}, {4}'.format(self.id, self.max_x, self.min_x, self.max_y, self.min_y)

    def lastInput():
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute('SELECT id, min_y, min_x, max_y, max_x, username FROM databank_position WHERE id=( SELECT max(id) FROM databank_position)')
            tup = cursor.fetchone()
            return tup



class footprints(models.Model):
    min_y = models.DecimalField('Min Y', max_digits=13, decimal_places=10, default=0, help_text="Min Y coordinate")
    min_x = models.DecimalField('Min X', max_digits=13, decimal_places=10, default=0, help_text="Min X coordinate")
    max_y = models.DecimalField('Max Y', max_digits=13, decimal_places=10, default=0, help_text="Max Y coordinate")
    max_x = models.DecimalField('Max X', max_digits=13, decimal_places=10, default=0, help_text="Max X coordinate")
    path = models.CharField('Path', max_length=33, default='difolt')
    name = models.CharField('Name', max_length=10, default='difolt')

    def judger():
        extent = Position.lastInput()

        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM footprints')
            result_list = []
            for row in cursor.fetchall():
                yMin = row[1]
                xMin = row[2]
                yMax = row[3]
                xMax = row[4]
                path = row[5]
                if((xMin >= extent[2] and yMin >= extent[1] and xMax <= extent[4] and yMax <= extent[3]) or (xMin >= extent[2] and xMin <= extent[4] and yMin >= extent[1] and yMin <= extent[3]) or (xMin >= extent[2] and xMin <= extent[4] and yMax >= extent[1] and yMax <= extent[3]) or (xMax >= extent[2] and xMax <= extent[4] and yMax >= extent[1] and yMax <= extent[3]) or (xMax >= extent[2] and xMax <= extent[4] and yMin >= extent[1] and yMin <= extent[3])):
                    result_list.append(path)
                    rawFile = path[:-4]
                    jgwFiles = rawFile + ".jgw"
                    result_list.append(jgwFiles)
            return result_list
            #return extent[0:6]

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