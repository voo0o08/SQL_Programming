# 딕셔너리 생성
dict = {"Seoul":["South Korea", "Asia", 9655000],
        "Tokyo":["Japan", "Asia", 14110000],
        "Beijing":["China", "Asia", 21540000],
        "London":["United Kingdom", "Europe", 14800000],
        "Berlin":["Germany", "Europe", 3426000],
        "Mexico City":["Mexico", "America", 21200000]}

def user_input():
    while True:
        print('''-----------------------------------------
1. 전체 데이터 출력
2. 수도 이름 오름차순 출력
3. 모든 도시의 인구수 내림차순 출력
4. 특정 도시의 정보 출력
5. 대륙별 인구수 계산 및 출력
6. 프로그램 종료
-----------------------------------------''')
        user = int(input("메뉴를 입력하세요: "))
        if user in range(1, 7):
            return user


# 1 전체 데이터 출력
def print_data():
    global dict
    for key, val in dict.items():
        print(f"Key: {key}, value: {val}")

# 2 수도 이름 오름차순 출력
def capital_sort():
    global dict
    cap_list = sorted(dict.keys())
    for key in cap_list:
        print(f"{key:12}: {dict[key][0]:15} {dict[key][1]:10} {dict[key][2]:>12,}")

# 3 모든 도시의 인구수 내림차순 출력
def pop_sort():
    global dict
    sort_list = sorted(dict.items(), key=lambda x: x[1][2], reverse=True)
    # print(sort_list)
    for key, val in sort_list:
        print(f"{key:12}:{val[2]:>12,}")

# 4 특정 도시의 정보 출력
def city_info():
    global dict
    city = input("출력할 도시 이름을 입력하세요:")
    if city not in dict.keys():
        print(f"도시이름: {city}은 Key에 없습니다.")
    else:
        print(f"도시:{city}")
        print(f"국가:{dict[city][0]}, 대륙:{dict[city][1]}, 인구수:{dict[city][2]:,}")

# 5 대륙별 인구수 계산 및 출력
def area_pop():
    global dict
    area = input("대륙 이름을 입력하세요(Asia, Europe, America):")
    sum = 0
    for key, val in dict.items():
        if val[1] == area:
            print(f"{key}: {val[2]:,}")
            sum += val[2]
    print(f"{area} 전체 인구수: {sum:,}")


while True:
    user = user_input()
    if user == 1:
        print_data()
    if user == 2:
        capital_sort()
    if user == 3:
        pop_sort()
    if user == 4:
        city_info()
    if user == 5:
        area_pop()
    elif user == 6:
        break