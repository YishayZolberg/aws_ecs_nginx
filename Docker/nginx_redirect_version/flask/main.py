import pymysql
from flask import Flask
app = Flask(__name__)

#global vars for db access. TODO Change to env vars!!!!!!!!!!!!!!!
ENDPOINT = "*************************" #db host address
PORT = 3306
USER = "admin" 
PASSWORD = "*************************"
DBNAME = "***************************"

@app.route("/")
def sqlcon():
    try:
        conn = pymysql.connect(host=ENDPOINT, user=USER, passwd=PASSWORD, port=PORT, database=DBNAME)
        cur = conn.cursor()
        cur.execute("""SELECT now()""")
        query_results = cur.fetchall()
        print(query_results)
        return f"hello from mysqldb! {str(query_results)}"
    except Exception as e:
        return f"Database connection failed due to {format(e)}"

#add path to health check by ELB
@app.route('/health')
def health_check():
    return 'OK', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
