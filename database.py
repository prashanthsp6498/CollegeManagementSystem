import MySQLdb

def connection():
    conn = MySQLdb.connect(host="localhost",user="root",passwd="<sp>",db = "collegeManagementSystem")
    c = conn.cursor()
    return c, conn
