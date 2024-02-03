# DB 이름 = shoppingmall
# TABLE 이름 = user_table
import pymysql

def create_user_table(conn, cur):
    try:
        query = '''
            create table user_table(
            userID char(8) not null primary key,
            userName varchar(10) not null,
            birthYear int not null,
            addr char(2) not null,
            mobile1 char(3),
            mobile2 char(8),
            height smallint,
            mDate date
            )
        '''
        cur.execute(query)
        query = '''
        insert into user_table (userID, userName, birthYear, addr, mobile1, mobile2, height, mDate)
         values
('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08')
'''
        cur.execute(query)

        conn.commit()
    except:
        conn.rollback()

def create_buy_table(conn, cur):
    try:
        query = '''
            create table buy_table(
            num INT auto_increment not null primary key,
            userID char(8) not null,
            prodName char(6) not null,
            groupName char(4),
            price INT not null,
            amount SMALLINT not null
            )
            '''
        cur.execute(query)
        sql = '''insert into buy_table values
        (1, 'KHD', '운동화', NULL, 30, 2),
(2, 'KHD', '노트북', '전자', 1000, 1),
(3, 'KYM', '모니터', '전자', 200, 1),
(4, 'PSH', '모니터', '전자', 200, 5),
(5, 'KHD', '청바지', '의류', 50, 3),
(6, 'PSH', '메모리', '전자', 80, 10),
(7, 'KJD', '책', '서적', 15, 5),
(8, 'LHJ', '책', '서적', 15, 2),
(9, 'LHJ', '청바지', '의류', 50, 1),
(10, 'PSH', '운동화', NULL, 30, 2),
(11, 'LHJ', '책', '서적', 15, 1),
(12, 'PSH', '운동화', NULL, 30, 2)
'''

        cur.execute(sql)
        conn.commit()
        print("table 생성 완료")

    except Exception as e:
        print(e)

def join_phone(cur):
    # =========== 2-1번 ===========
    sql = '''select
    userName, prodName, addr, concat(ut.mobile1, ut.mobile2) as 연락처
    from buy_table as bt
    inner
    join
    user_table
    ut
    on
    bt.userID = ut.userID'''
    print('''-------------------------------------------------	
userID	prodName	addr    연락처				
-------------------------------------------------''')
    cur.execute(sql)
    rows = cur.fetchall()  # 모든 데이터를 가져옴
    print_data(rows)

def user_KYM(cur):
    # =========== 2-2번 ===========
    sql = '''select u.userID, userName, prodName, addr, concat(u.mobile1,u.mobile2)
from buy_table as b
	inner join user_table u
	on b.userID = u.userID
where b.userID = "KYM"
'''
    print('''-------------------------------------------------	
userID	userName    prodName	addr    연락처				
-------------------------------------------------''')
    cur.execute(sql)
    rows = cur.fetchall()
    print_data(rows)

def user_buy_sort(cur):
    # =========== 2-3번 ===========
    sql = '''select u.userID, userName, prodName, addr, concat(u.mobile1,u.mobile2)as 연락
from buy_table as b
	inner join user_table u
	on b.userID = u.userID
order by u.userID 
    '''
    print('''-------------------------------------------------	
userID	userName	prodName    addr    연락처				
-------------------------------------------------''')
    cur.execute(sql)
    rows = cur.fetchall()
    print_data(rows)

def user_buy_distinct(cur):
    # =========== 2-4번 ===========
    sql = '''select distinct u.userID, userName, addr
from buy_table as b
	inner join user_table u
	on b.userID = u.userID 
        '''
    print('''-------------------------------------------------	
userID	userName	addr 			
-------------------------------------------------''')
    cur.execute(sql)
    rows = cur.fetchall()
    print_data(rows)

def user_addr(cur):
    # =========== 2-5번 ===========
    sql = '''select u.userID, userName, addr, concat(u.mobile1,u.mobile2)as 연락
from buy_table as b
	inner join user_table u
	on b.userID = u.userID
where u.addr in ("경북", "경남")
            '''
    print('''-------------------------------------------------	
userID	userName	addr    연락처				
-------------------------------------------------''')
    cur.execute(sql)
    rows = cur.fetchall()
    print_data(rows)


def print_data(rows):
    for row in rows:
        print(row)

def main():
    conn = pymysql.connect(host="localhost", user="root",password="1234", db="shoppingmall", charset="utf8")
    cur = conn.cursor()

    # 1. 테이블 생성
    create_user_table(conn, cur)
    create_buy_table(conn, cur)


    # 2. 두 테이블을 내부 조인
    # 2-1) 내부조인 결과에 '연락처' 컬럼 추가
    print("문제 1번")
    join_phone(cur)

    # 2-2) userID가 KYM인 사람이 구매한 물건과 회원 정보 출력
    print("\n문제 2번")
    user_KYM(cur)

    # 2-3) 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
    print("\n문제 3번")
    user_buy_sort(cur)

    # 2-4) 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력(distinct 사용)
    print("\n문제 4번")
    user_buy_distinct(cur)

    # 2-5) 쇼핑몰 회원 중에서 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력
    print("\n문제 5번")
    user_addr(cur)

    conn.commit()
    cur.close()
    conn.close()
    print("Database 연결종료")

main()
