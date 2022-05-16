import os

import cv2
import numpy as np
from tensorflow.keras.models import load_model

class Country:
    def proc(self, data):     # self: 함수와 객체 연결
        print('소스 data:', data)   # data 형식: "0,0,0,5,1,0,0"
        data = np.array(data.split(','), dtype=float)
        print('변환된 data:', data)

        # ★ 표준화하여 학습한 모델임으로 데이터도 표준화해서 사용 ★
        # 표준화 값 Z = 데이터 - 평균 ÷ 표준 편차
        # 0행  m: 0.8  std: 1.0295630140987002
        # 1행  m: 0.39 std: 0.4877499359302879
        # 2행  m: 0.66 std: 0.4737087712930805
        # 3행  m: 7.32 std: 2.842111890830479
        # 4행  m: 0.92 std: 0.2712931993250107
        # 5행  m: 1.19 std: 1.2385071659057931
        data[0] = (data[0] - 0.8) / 1.0295630140987002
        data[1] = (data[1] - 0.39) / 0.4877499359302879
        data[2] = (data[2] - 0.66) / 0.473708771293080
        data[3] = (data[3] - 7.32) / 2.842111890830479
        data[4] = (data[4] - 0.92) / 0.2712931993250107
        data[5] = (data[5] - 1.19) / 1.2385071659057931

        # 2차원 배열로 변환
        x_data = np.array([
            data,
        ])

        # Tensorflow_model.py 스크립트 파일이 있는 곳의 절대경로
        path = os.path.dirname(os.path.abspath(__file__))
        print('path:', path);

        # model 이 있는 경로: C:/kd/ws_python/notebook/machine/dnn/country/country3.h5
        # model = load_model("C:/kd/ws_python/machine/ais/AI_models/country3.h5")
        model = load_model(os.path.join(path, 'Country3.h5'))

        # yp = model.predict(x_data[0:1])  # 모델 사용, 1건의 데이터
        yp = model.predict(x_data)  # 결과를 2차원 배열로 리턴

        result = yp[0][0] # 1건에 대한 값
        print('예측 결과: {0:.3f}%'.format(result * 100))

        return result * 100

class Wine:
    def proc(self, data):
        print('data:', data) # data 형식: "0,0,0,5,1,0,0"
        data = np.array(data.split(','), dtype=float)
        print('변환된 data:', data)

        # 2차원 배열로 변환
        x_data = np.array([
            data,
        ])

        # 절대 경로 사용
        path = os.path.dirname(os.path.abspath(__file__))  # 스크립트파일의 절대경로
        print('path:', path);

        # model 이 있는 경로: C:/kd/ws_python/notebook/machine/dnn/wine/Wine1.h5
        # model = load_model("C:/kd/ws_python/machine_django/ais/AI_models/Wine1.h5")
        model = load_model(os.path.join(path, 'Wine1.h5'))

        # yp = model.predict(x_data[0:1])  # 모델 사용, 1건의 데이터
        yp = model.predict(x_data)         # 1건의 데이터

        for i in range(len(x_data)):
            result = yp[i][0]  # 예측 결과는 2차원 배열로 리턴됨
            print('Red wine 확률: {0:.3f}%'.format(result * 100))

        return result * 100

class Iris:
    def proc(self, data):
        print('data:', data) # data 형식: "0,0,0,5,1,0,0"
        data = np.array(data.split(','), dtype=float)
        print('변환된 data:', data)

        # 2차원 배열로 변환
        x_data = np.array([
            data,
        ])

        # 절대 경로 사용
        path = os.path.dirname(os.path.abspath(__file__))  # 스크립트파일의 절대경로
        print('path:', path);

        # model 이 있는 경로: C:/kd/ws_python/notebook/machine/dnn/iris/Iris.h5
        # model = load_model("C:/kd/ws_python/machine_django/ais/AI_models/Iris.h5")
        model = load_model(os.path.join(path, 'Iris.h5'))

        # yp = model.predict(x_data[0:1])  # 모델 사용, 1건의 데이터
        yp = model.predict(x_data)  # 1건의 데이터

        print(yp[0]) # 결과는 2차원 배열임으로 1행 출력
        index = np.argmax(yp[0]) # 다중 분류임으로 가장 큰값이 있는 index 검색
        # Iris-setosa       0
        # Iris-versicolor   1
        # Iris-virginica     2
        print('예측값:', yp[0], ' / index:', index)

        return index # 가장 큰 값이 있는 index 리턴

    def proc2(self, sepal_length, sepal_width, petal_length, petal_width):
        # print('data:', data) # data 형식: "0,0,0,5,1,0,0"
        # data = np.array(data.split(','), dtype=float)
        # print('변환된 data:', data)

        # 2차원 배열로 변환
        x_data = np.array([
            [sepal_length, sepal_width, petal_length, petal_width]
        ])
        print('-> ', x_data)

        # 절대 경로 사용
        path = os.path.dirname(os.path.abspath(__file__))  # 스크립트파일의 절대경로
        print('path:', path);

        # model 이 있는 경로: C:/kd/ws_python/notebook/machine/dnn/iris/Iris.h5
        # model = load_model("C:/kd/ws_python/machine_django/ais/AI_models/Iris.h5")
        model = load_model(os.path.join(path, 'Iris.h5'))

        # yp = model.predict(x_data[0:1])  # 모델 사용, 1건의 데이터
        yp = model.predict(x_data)  # 1건의 데이터

        print(yp[0]) # 결과는 2차원 배열임으로 1행 출력
        index = np.argmax(yp[0]) # 다중 분류임으로 가장 큰값이 있는 index 검색
        # Iris-setosa       0
        # Iris-versicolor   1
        # Iris-virginica     2
        print('예측값:', yp[0], ' / index:', index)

        return index # 가장 큰 값이 있는 index 리턴

# ----------------------------------------------------------------------
# Actor 관련
# ----------------------------------------------------------------------
from django import forms

# 폼 객체 선언 <form> 태그에 출력됨.
class UploadFileForm(forms.Form):
    # name = forms.CharField(max_length = 15)
    # files = forms.FileField()
    # 파일 선택 태그 출력, 'multiple': False: 하나의 파일만 선택 가능
    # file input 태그를 생성하며 업로드 파일이 존재하는지등 자동화된 기능 지원
    files = forms.FileField(widget=forms.ClearableFileInput(attrs={'multiple': False}))

from tensorflow.keras.preprocessing.image import ImageDataGenerator
class Actor:
    def proc(self):
        # 절대 경로 사용
        # path = os.path.dirname(os.path.abspath(''))  # 경로: C:\kd\ws_python

        # 경로: C:\kd\ws_python\machine_django\media, Keras 문법상 마지막 폴더 'actor'는 정의 하지 않음 ★
        image_path = os.path.abspath('../machine_django/media/')

        print('예측할 이미지 경로 image_path:', image_path);

        width = 64
        height = 64
        # 테스트용 데이터 생성기
        test_datagen = ImageDataGenerator(rescale=1. / 255)

        test_generator = test_datagen.flow_from_directory(
            image_path,
            target_size=(width, height),
            batch_size=1,
            class_mode='categorical')

        # 절대 경로 사용
        path = os.path.dirname(os.path.abspath(__file__))  # 스크립트파일의 절대경로
        print('path:', path);

        # model 이 있는 경로: C:/kd/ws_python/notebook/machine/local_actor/Actor.h5
        # model = load_model("C:/kd/ws_python/machine_django/ais/AI_models/Actor.h5")
        model = load_model(os.path.join(path, 'Actor.h5'))

        yp = model.predict_generator(test_generator)
        print(yp)
        index = np.argmax(yp[0])  # 2차원 배열임으로 첫번째 행을 지정
        print('최대값 index:', index)
        label = ''  # 예측한 배우 이름
        if index == 0:
            label = 'Amanda Seyfried'
        elif index == 1:
            label = 'Andrew Lincoln'
        elif index == 2:
            label = 'Anne Hathaway'
        elif index == 3:
            label = 'Hugh Jackman'
        elif index == 4:
            label = 'Keira Christina Knightley'
        elif index == 5:
            label = 'Pierce Brosnan'
        elif index == 6:
            label = '조정석'

        print('예측된 label:', label)

        return label

    # local_actor_finder 기반
    def proc2(self):
        # 절대 경로 사용
        # path = os.path.dirname(os.path.abspath(''))  # 경로: C:\kd\ws_python

        # 이미지 인식시 opencv로 접근할 것임으로 전체 경로 명시 ★
        # 경로: C:\kd\ws_python\machine_django\media\actor
        image_path = os.path.abspath('../machine_django/media/actor/')
        print('-> 예측할 이미지 경로 image_path:', image_path);

        width = 64
        height = 64

        # Tensorflow model 사용시 이용할 절대 경로
        path = os.path.dirname(os.path.abspath(__file__))  # 스크립트파일의 절대경로
        print('-> model path:', path);

        # model 이 있는 경로: C:/kd/ws_python/notebook/machine/local_actor/Actor.h5
        # model = load_model("C:/kd/ws_python/machine_django/ais/AI_models/Actor.h5")
        model = load_model(os.path.join(path, 'Actor.h5'))
        print('-> 스크립트파일의 절대경로:' + os.path.abspath(__file__))
        print('-> 현재 폴더 [.] 의 절대경로:' + os.path.abspath('.')) # C:\kd\ws_python\machine_django
        # face_cascade = cv2.CascadeClassifier('./haarcascade_frontalface_default.xml')
        # C:\kd\ws_python\machine_django 기준이라 '.'을 찍으면 안됨 ★
        face_cascade = cv2.CascadeClassifier(os.path.join(path, 'haarcascade_frontalface_default.xml'))

        # C:\kd\ws_python\machine_django\media\actor 폴더에가서 이미지 파일을 찾아온다.
        file_list = os.listdir(image_path)
        file_list_img = [file for file in file_list if file.endswith(".jpg")]
        fname = file_list_img[0]
        print('-> fname:', fname)

        yp=999
        try:
            # print('-> os.path.exists:', os.path.exists('C:/kd/ws_python/machine_django/media/actor/' + fname))
            fname =  image_path + '\\' + fname
            print('-> fname:', fname)
            if os.path.exists(fname):
                print('-> 분석 파일 존재')
                # img = cv2.imread('C:/kd/ws_python/machine_django/media/actor/a1.jpg', cv2.IMREAD_COLOR)
                img = cv2.imread(fname, cv2.IMREAD_COLOR)
                #         img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
                gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                print('-> 이미지 읽기')
                # 이미지 배열, 지정한 형태를 찾을 정밀도(기본값: 1.1, 숫자가 낮을수록 정밀함), 이미지간의 간격(너무 낮으면 중복 검출됨(기본값: 3))7
                faces = face_cascade.detectMultiScale(gray, 1.1, 3)
                print('-> 이미지인식')
                count = 0
                for (x, y, w, h) in faces:
                    #     cropped = img[y - int(h / 2.5):y + h + int(h / 4), x - int(w / 4):x + w + int(w / 4)]
                    cropped = img[y - int(h / 3.5):y + h + int(h / 4), x - int(w / 4):x + w + int(w / 4)]

                    shp = cropped.shape
                    print('->', shp)
                    print('->', type(cropped))

                    resize_cropped = cv2.resize(cropped, (64, 64))
                    shp = resize_cropped.shape
                    print('->', shp)

                    resize_cropped = resize_cropped.reshape((1,) + resize_cropped.shape)
                    shp = resize_cropped.shape
                    print('->', shp)

                    resize_cropped = resize_cropped / 255.0

                    yp = model.predict(resize_cropped, batch_size=1)
                    #         print(yp.shape)
                    #         print(yp)
            else:
                print('-> 입력된 파일명의 이미지가 없어요.')
        except Exception as e:
                print('-> Exception 발생')
                print(e)
            # pass

        print(yp)
        index = np.argmax(yp[0])  # 2차원 배열임으로 첫번째 행을 지정
        print('최대값 index:', index)
        label = ''  # 예측한 배우 이름
        if index == 0:
            label = 'Amanda Seyfried'
        elif index == 1:
            label = 'Andrew Lincoln'
        elif index == 2:
            label = 'Anne Hathaway'
        elif index == 3:
            label = 'Hugh Jackman'
        elif index == 4:
            label = 'Keira Christina Knightley'
        elif index == 5:
            label = 'Pierce Brosnan'
        elif index == 6:
            label = '조정석'
        else:
            label = 'none'

        print('예측된 label:', label)

        return label
