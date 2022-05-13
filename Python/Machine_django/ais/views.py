import json

from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
# http://127.0.0.1:8000 --> /ais/templates/index.html
from ais.AI_models.Tensorflow_model import Country, Wine, Iris


def index(request):
    return render(request, 'index.html')

def country_form(request):
    # 출력 페이지로 보낼 값을 {.....} 블럭에 선언
    # /ais/templates/country_form.html
    return render(request, 'country_form.html', {})

def country_proc(request):
    country = Country()
    drink = request.GET['drink']  # form get
    life = request.GET['life']
    cousin = request.GET['cousin']
    trip = request.GET['trip']
    house = request.GET['house']
    land = request.GET['land']
    data = drink + "," + life + "," + cousin + "," + trip + "," + house + "," + land
    # print('views.py', data)
    result = country.proc(data) # 모델 사용

    result = round(result, 0) # 정수자리까지 반올림

    content = {
                   'data': data,
                   'result': int(result),
                  }
    # 날짜등의 변한 선언: cls=DjangoJSONEncoder
    # return HttpResponse(json.dumps(content, cls=DjangoJSONEncoder), content_type="application/json")
    return HttpResponse(json.dumps(content), content_type="application/json")

def wine_form(request):
    # 출력 페이지로 보낼 값을 {.....} 블럭에 선언
    # /ais/templates/wine_form.html
    return render(request, 'wine_form.html', {})

def wine_proc(request):
    print('Wine Ajax 요청 받음')
    data = request.GET['data']

    wine = Wine()
    result = wine.proc(data)

    content = {
                  'data': data,
                  'result': float(result),
                  }
    # 날짜등의 변한 선언: cls=DjangoJSONEncoder
    # return HttpResponse(json.dumps(content, cls=DjangoJSONEncoder), content_type="application/json")
    return HttpResponse(json.dumps(content), content_type="application/json")

def iris_form2(request):
    # 출력 페이지로 보낼 값을 {.....} 블럭에 선언
    # /ais/templates/iris_form2.html
    # return render(request, 'iris_form2.html', {})
    return render(request, 'iris_form2.html', {})

def iris_proc2(request):
    print('Iris Ajax 요청 받음')
    sepal_length = float(request.GET['sepal_length'])
    sepal_width = float(request.GET['sepal_width'])
    petal_length = float(request.GET['petal_length'])
    petal_width = float(request.GET['petal_width'])

    iris = Iris()
    result = iris.proc2(sepal_length, sepal_width, petal_length, petal_width)

    content = {
        'sepal_length':sepal_length ,
        'sepal_width':sepal_width,
        'petal_length':petal_length,
        'petal_width':petal_width,
        'result': int(result),
    }

    # 날짜등의 변한 선언: cls=DjangoJSONEncoder
    # return HttpResponse(json.dumps(content, cls=DjangoJSONEncoder), content_type="application/json")
    return HttpResponse(json.dumps(content), content_type="application/json")

# -----------------------------------------------------------------------------------------------
# Actor
# -----------------------------------------------------------------------------------------------
# 이미지 인식을 통한 영화배우 정보 조회하기, Actor.h5 모델의 사용, Django jQuery, Aajx, Json 연동 개발
from ais.AI_models.Tensorflow_model import UploadFileForm
from ais.AI_models.Tensorflow_model import Actor
import os

# 업로드된 파일 저장 함수 정의
def handle_uploaded_file(f):  # media/actor 폴더에 파일 저장, 같은 파일명이 있으면 덮어씀.
    with open(os.path.join(os.getcwd(), "media/actor", f.name), 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)

def actor_form(request):
    if request.method == 'POST': # 파일이 전송된 경우
        print(os.getcwd()) # 현재 경로 출력
        print("POST method 요청됨.")
        input_file = UploadFileForm(request.POST, request.FILES) # <form> file 태그 생성
        if input_file.is_valid():
            print("업로드할 파일 이 있습니다.")

            # -------------------------------------------------------------------
            # 기존에 등록된 파일 삭제, 여기서는 흐름상 하나의 테스트 이미지만 사용함.
            # -------------------------------------------------------------------
            # image_path = os.path.abspath('machine_django/') + '/actor'  # 경로: C:\ai\ws_python\machine_django\media
            image_path = os.path.abspath('../machine_django/media/actor/')
            print('기존에 등록된 파일 삭제:', image_path)

            for filename in os.listdir(image_path):
                print('삭제할 파일명:', filename)
                fname = image_path + '\\' + filename  # 절대 경로 생성
                if os.path.isfile(fname):
                    print("Deleting file:", fname)
                    os.remove(fname)
            # -------------------------------------------------------------------

            # files = forms.FileField(widget=forms.ClearableFileInput(attrs={'multiple': False}))
            # 설정에 따라 생성된 태그에서 파일 객체를 가져옴.
            for count, x in enumerate(request.FILES.getlist("files")):
                handle_uploaded_file(x)  # 업로드된 파일 저장
                print('업로드된 파일명: ', x.name)
                # os.remove("machine_django/"+str(x.name)) 삭제 테스트
                # print(str(x.name)+"삭제완료")

                # 업로드된 파일로 배우 판단 실행
                actor = Actor()
                result = actor.proc()

            # html form으로 보내는 json 데이터
            content = {'input_file': input_file, 'uploaded_file_name':x.name, 'result': result}
            # return HttpResponse(" File uploaded! ") # 파일 업로드후 문장이 화면에 출력됨.
            return render(request, 'actor_form.html', content)

    else:  # GET 방식 일경우
        input_file = UploadFileForm()

    # 'uploaded_file_name': '': 처음 실행시 업로된 파일이 없음으로 아무것도 값을 지정하지 않음.
    return render(request, 'actor_form.html', {'input_file': input_file, 'uploaded_file_name': ''})

# local_actor_finder 사용 함수
def actor_form2(request):
    if request.method == 'POST': # 파일이 전송된 경우
        print(os.getcwd()) # 현재 경로 출력
        print("-> local_actor_finder POST method 요청됨.")
        input_file = UploadFileForm(request.POST, request.FILES) # <form> file 태그 생성
        if input_file.is_valid():
            print("-> 업로드할 파일 이 있습니다.")

            # -------------------------------------------------------------------
            # 기존에 등록된 파일 삭제, 여기서는 흐름상 하나의 테스트 이미지만 사용함.
            # -------------------------------------------------------------------
            # image_path = os.path.abspath('machine_django/') + '/actor'  # 경로: C:\ai\ws_python\machine_django\media
            image_path = os.path.abspath('../machine_django/media/actor/')
            print('-> 기존에 등록된 파일 삭제:', image_path)

            for filename in os.listdir(image_path):
                print('-> 삭제할 파일명:', filename)
                fname = image_path + '\\' + filename  # 절대 경로 생성
                if os.path.isfile(fname):
                    print("-> Deleting file:", fname)
                    os.remove(fname)
            # -------------------------------------------------------------------

            # files = forms.FileField(widget=forms.ClearableFileInput(attrs={'multiple': False}))
            # 설정에 따라 생성된 태그에서 파일 객체를 가져옴.
            for count, x in enumerate(request.FILES.getlist("files")):
                handle_uploaded_file(x)  # 업로드된 파일 저장
                print('-> 업로드된 파일명: ', x.name)
                # os.remove("machine_django/"+str(x.name)) 삭제 테스트
                # print(str(x.name)+"삭제완료")

                # 업로드된 파일로 배우 판단 실행
                actor = Actor()
                result = actor.proc2() # local_actor_finder 기반

            # html form으로 보내는 json 데이터
            content = {'input_file': input_file, 'uploaded_file_name':x.name, 'result': result}
            # return HttpResponse(" File uploaded! ") # 파일 업로드후 문장이 화면에 출력됨.
            return render(request, 'actor_form2.html', content)

    else:  # GET 방식 일경우
        input_file = UploadFileForm()

    # 'uploaded_file_name': '': 처음 실행시 업로된 파일이 없음으로 아무것도 값을 지정하지 않음.
    return render(request, 'actor_form2.html', {'input_file': input_file, 'uploaded_file_name': ''})



