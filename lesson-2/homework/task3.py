import pyodbc

con_str = 'DRIVER={SQL SERVER};SERVER=DESKTOP-AGJD8N8;DATABASE=CLASS2;Trusted_Connection=yes;'
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM photos;
    """
)

row = cursor.fetchone()
img_id, photo = row
with open('sunflower.png', 'wb') as f:
    f.write(photo)