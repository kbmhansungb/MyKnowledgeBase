---
tags:
  - Unity
  - ImageTracking
  - ComputerVision
  - OpenCV
  - OpenCVForUnity
---
# Unity에서 OpenCV For Unity를 이용하여 이미지 트래킹
앱 설치 없이 웹으로 접속해 이미지 트래킹을 제공합니다.

## WebCam을 이용한 비디오 캡쳐
OpenCV.VideoCapture를 이용할 경우 WebGL에서 동작하지 않아 Unity에서 지원하는 WebCam을 이용합니다.

## Homography를 찾고 이를 바탕으로 월드 좌표 계산
마커 이미지 좌표에서 카메라 이미지 좌표로 변환하는 [Homography](../Homography/Homography.md)를 찾습니다. 이를 바탕으로 마커 이미지를 월드 좌표로 변환하는 행렬을 구합니다.

$$P_{2} = H P_{1}$$

$$P_{2} = K_{2}MK_{1}^{-1}P_{1}$$

$$K_{2}^{-1}P_{2} = K_{2}^{-1}K_{2}MK_{1}^{-1}P_{1}$$

$$P_{w} = MK_{1}^{-1}P_{1}$$

유니티의 경우 캔바스의 이미지 평면의 거리에 맞춰 캔바스 크기를 조절합니다. 이를 위해 월드 좌표값에 이미지 평면의 스케일을 적용합니다.

$$P_{c} = P_{w} {S}_{c}$$

## Unity 좌표로 계산
OpenCV 좌표를 Unity 좌표로 변환합니다.

```
x = x
y = -y
z = z
```

## 이미지 크기에 따른 거리 조절
도형의 닮음을 이용하여 이미지 크기가 일치하도록 이미지 평면의 거리를 계산합니다. 