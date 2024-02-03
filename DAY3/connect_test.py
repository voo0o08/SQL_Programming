
import pymysql
import pandas as pd

conn = pymysql.connect(host="localhost", user="root",password="1234", db="sakila", charset="utf8")

cur = conn.cursor() # -> cursor 객체 생성
cur.execute("select * from language")
rows = cur.fetchall() # 모든 데이터를 가져옴
print(rows)

language_df = pd.DataFrame(rows)
print(language_df)

cur.close()
conn.close()
