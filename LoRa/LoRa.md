---
tags:
  - Communication
  - EmbeddedSystem
---
### LoRa 통신이란?

**LoRa (Long Range)**는 저전력으로 장거리 통신을 가능하게 하는 **무선 통신 기술**입니다. 주로 IoT(사물인터넷) 네트워크에서 사용되며, LoRa는 낮은 대역폭을 사용해 매우 먼 거리까지 데이터를 전송할 수 있도록 설계되었습니다. LoRa는 물리적 계층에서의 기술로, 데이터 링크 계층에서 동작하는 LoRaWAN 프로토콜과 함께 주로 사용됩니다.

### LoRa의 주요 특징

1. **장거리 통신**: LoRa는 최대 수십 킬로미터까지 통신이 가능하며, 특히 도시 지역에서는 2~5km, 농촌이나 개방된 지역에서는 최대 15km 이상까지 도달할 수 있습니다.
   
2. **저전력**: LoRa는 저전력 설계로, 배터리로 장기간(몇 년 이상) 구동할 수 있습니다. 이는 배터리 교체가 어려운 IoT 기기에서 매우 유용합니다.

3. **저속 데이터 전송**: LoRa는 대용량 데이터 전송에는 적합하지 않지만, 작은 양의 데이터를 간헐적으로 전송하는 IoT 디바이스에 최적화되어 있습니다. 데이터 속도는 대략 0.3 kbps에서 50 kbps 정도입니다.

4. **면허 불필요 대역**: LoRa는 ISM(Industrial, Scientific, Medical) 대역을 사용하므로, 사용자가 별도로 주파수 라이센스를 취득할 필요가 없습니다. 주파수 대역은 지역에 따라 다르지만, 주로 433MHz, 868MHz(유럽), 915MHz(북미) 대역을 사용합니다.

### LoRa의 장점

1. **경제성**: 면허가 필요 없는 주파수를 사용하고, 저전력으로 작동하기 때문에 통신 비용이 낮습니다.
   
2. **뛰어난 신호 범위**: 장거리 통신을 지원하므로, 넓은 영역에서 센서 데이터를 수집하거나 장치 간 연결이 가능합니다.

3. **내구성**: 건물이나 장애물이 많은 환경에서도 신호가 잘 전달됩니다. LoRa는 물리적 장벽이 많은 도시 환경에서도 높은 신뢰성의 통신을 제공합니다.

### LoRa의 단점

1. **낮은 데이터 전송률**: LoRa는 고속 데이터 전송을 지원하지 않으므로, 영상 스트리밍 같은 대역폭이 큰 애플리케이션에는 적합하지 않습니다.

2. **채널 혼잡**: 면허 불필요 대역을 사용하기 때문에, 사용자 증가 시 주파수 대역이 혼잡해질 수 있습니다.

### LoRa의 활용 분야

1. **스마트 시티**: 교통, 환경 모니터링, 공공시설 관리 등에서 LoRa 센서를 통해 데이터를 수집하고 제어합니다.
   
2. **스마트 농업**: LoRa 센서를 이용해 농작물의 상태를 모니터링하고, 원격으로 관리할 수 있습니다.

3. **스마트 미터링**: 전기, 가스, 수도 등의 사용량을 LoRa 통신을 통해 원격에서 확인하고 관리할 수 있습니다.

4. **산업용 IoT**: 공장 자동화, 원격 기기 관리, 상태 모니터링 등에서 LoRa 통신을 통해 데이터를 수집하고 처리할 수 있습니다.

### LoRa와 LoRaWAN

**LoRa**는 물리 계층 기술로, 신호를 변조해 데이터를 전송하는 방법을 정의합니다. **LoRaWAN**은 LoRa 기술을 기반으로 동작하는 **네트워크 프로토콜**로, 데이터 전송의 전반적인 관리와 IoT 기기 간의 통신을 처리합니다. LoRaWAN은 주로 게이트웨이를 통해 IoT 장치와 인터넷 기반 애플리케이션 서버 간의 통신을 중재합니다.

- **LoRa**는 하드웨어적 특성(장거리, 저전력)을 담당하고, **LoRaWAN**은 네트워크 계층에서 패킷 라우팅, 보안, 장치 간 통신을 관리합니다.

LoRa는 장거리 저전력 통신이 필요한 IoT 환경에서 매우 유용한 기술로, 특히 비용 효율적이고 넓은 범위를 커버할 수 있어 다양한 분야에서 채택되고 있습니다.