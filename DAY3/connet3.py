import pymysql

def create_table(conn, cur):
    try:
        query = '''
            create table customer
            (name  varchar(10),
            category smallint,
            region varchar(10)
            )
            '''
        cur.execute(query)
        conn.commit()
        print("table 생성 완료")

    except Exception as e:
        print(e)

def main():
    conn = pymysql.connect(host="localhost", user="root",password="1234", db="sqlclass_db", charset="utf8")

    cur = conn.cursor()

    create_table(conn, cur)

    cur.close()
    conn.close()
    print("Database 연결종료")

main()