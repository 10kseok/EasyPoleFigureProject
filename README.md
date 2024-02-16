# EasyPoleFigureProject
결정방위를 2차원에 투영시켰을 때에 찍히는 점들을 극점도라고 합니다.  
이 극점도를 처음 배울 때, 기본 결정방위에서 회전시 극점도가 어떻게 변화될 지 예측하는 것은 어렵습니다.
따라서, 이 프로젝트는 본인이 직접 원하는대로 특정 결정을 회전 시켜보고 쉽게 그 결과를 확인할 수 있는 iOS 프로젝트입니다.

## 기능
- 사용자의 입력 값에 따라 해당 방향의 극점들이 생성됩니다.
- X축, Y축, Z축의 변화에 따라 극점들도 그에 맞게 움직입니다.

1. 결정방위를 입력하지 않는 상태
<p align="center"><img src="https://github.com/10kseok/EasyPoleFigureProject/assets/76582376/b75b6f0a-e4b2-425c-a3e7-2a0685114617" width="50%" height="50%"></p>

2. cubic 기준으로 [110] 방향들의 극점이 찍힌 상태
<p align="center"><img src="https://github.com/10kseok/EasyPoleFigureProject/assets/76582376/5abd2f81-9c63-45cd-b8fe-3d27f98bee57" width="50%" height="50%"></p>

3. 시연 영상
<p align="center"><img src="https://github.com/10kseok/EasyPoleFigureProject/assets/76582376/f6147502-7e46-406b-b607-325671af7988" width="50%" height="50%"></p>

## 한계
- 현재 구현은 Cubic일 때만 적용됩니다. (다른 결정구조는 불가능)
- X, Y, Z축을 동시에 회전시킬 때의 결과가 명확하지 못하며 어떤 이유인지 찾지 못했습니다.
- 위와 같은 이유로 출시(배포)까지는 하지 못했습니다.

## 기술 스택
**simd** : 3차원 벡터값 계산을 위해 사용하였습니다.

**SceneKit** : 3D 객체 생성 및 점을 그려주기위해 사용하였습니다.
