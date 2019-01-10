from django.db import models
from django.urls import reverse
from django.db import connection
import psycopg2
import sys

"""
https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Models
"""


# Create your models here.

class Query(models.Model):
    """
    Model representing the max and min coordinates of the bounding box and the username of the User.
    """

    max_x = models.DecimalField('Max X', max_digits=13, decimal_places=10, default=0, help_text="Max X coordinate")
    min_x = models.DecimalField('Min X', max_digits=13, decimal_places=10, default=0, help_text="Min X coordinate")
    max_y = models.DecimalField('Max Y', max_digits=13, decimal_places=10, default=0, help_text="Max Y coordinate")
    min_y = models.DecimalField('Min Y', max_digits=13, decimal_places=10, default=0, help_text="Min Y coordinate")
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

    def lastInput(self):
        """
        # Create a new record using the model's constructor.
        record = MyModelName(my_field_name="Instance #1")

        # Save the object into the database.
        record.save()
        """
        with connection.cursor() as cursor:
            cursor.execute(
                'SELECT id, min_y, min_x, max_y, max_x, username FROM databank_position WHERE id=( SELECT max(id) FROM databank_position)')
            tup = cursor.fetchone()
            return tup
    """
    def getObjects(self):
        all_books = Book.objects.all()
        wild_books = Book.objects.filter(title__contains='wild')
        number_wild_books = Book.objects.filter(title__contains='wild').count()
    """


class Footprints(models.Model):
    min_x = models.DecimalField('Min X', max_digits=13, decimal_places=10, default=0, help_text="Min X coordinate")
    min_y = models.DecimalField('Min Y', max_digits=13, decimal_places=10, default=0, help_text="Min Y coordinate")
    max_x = models.DecimalField('Max X', max_digits=13, decimal_places=10, default=0, help_text="Max X coordinate")
    max_y = models.DecimalField('Max Y', max_digits=13, decimal_places=10, default=0, help_text="Max Y coordinate")
    path = models.CharField('Path', max_length=50, default='difolt')

    """
    conn = psycopg2.connect("dbname='sdi_database' user='postgres' password='postgres'")
    cur = conn.cursor
    cur.execute("select * from information_schema.tables where table_name=%s", ('databank_footprints',))
    if(bool(cur.rowcount)):
        pass
    else:
        # specify what happens when the datatable is not created
        # import sqlmanager and run it
        pass
    """

    def judger(self):
        extent = [['dsada'],'dad']
        # print('extent')
        # print(extent)


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
                if ((xMin >= extent[2] and yMin >= extent[1] and xMax <= extent[4] and yMax <= extent[3]) or (
                        xMin >= extent[2] and xMin <= extent[4] and yMin >= extent[1] and yMin <= extent[3]) or (
                        xMin >= extent[2] and xMin <= extent[4] and yMax >= extent[1] and yMax <= extent[3]) or (
                        xMax >= extent[2] and xMax <= extent[4] and yMax >= extent[1] and yMax <= extent[3]) or (
                        xMax >= extent[2] and xMax <= extent[4] and yMin >= extent[1] and yMin <= extent[3])):
                    result_list.append(path)
            return result_list
            # return extent[0:6]

    def __str__(self):
        """
        String for representing the Model object.
        """
        return '{0}, {1}, {2}, {3}, {4}, {5}'.format(self.id, self.max_x, self.min_x, self.max_y, self.min_y, self.path)

    def get_absolute_url(self):
        """Returns the url to access a particular instance of the model."""
        return reverse('model-detail-view', args=[str(self.id)])
