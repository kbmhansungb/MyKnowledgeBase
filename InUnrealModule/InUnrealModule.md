[모듈화 프로그래밍](../ModularProgramming/ModularProgramming.md)에 따라 모듈은 언리얼 엔진 소프트웨어 아키텍처의 기본 빌딩 블록입니다. 이는 특정 편집기 도구, 런타임 기능, 라이브러리 또는 기타 기능을 독립 실행형 코드 단위로 캡슐화 합니다. 모든 프로젝트와 플러그인에는 기본적으로 자체 기본 모듈이 있지만, 코드를 구성하기 위해 이러한 모듈 외부에 다른 모듈을 정의할 수 있습니다.

언리얼 엔진은 특정 플랫폼에 종속적이지 않은 바이너리 제작을 위해 언리얼 빌드 툴을 사용해 빌드합니다. 언리얼 엔진의 모든 소스는 모듈이라는 단위로 구성되어 있으며 이 중에서 필요한 모듈을 타겟으로 묶어서 최종 빌드를 만들어 냅니다.

언리얼 엔진의 C++ 개발 환경은 하나의 게임 프로젝트에 하나의 모듈을 사용하는 것이 일반적입니다. 언리얼 엔진에서는 게임 제작에 사용되는 로직을 담은 기본 모듈을 주 게임 모듈이라고 합니다.

하지만 게임 프로젝트에서는 주 게임 모듈외에도 개발자가 모듈을 추가할 수 있습니다. 언리얼 에디터에서는 모듈을 추가하는 메뉴를 제공하지 않지만, 언리얼 빌드 시스템을 이해한다면 커멘드라인으로 모듈을 제작할 수 있습니다.

Unreal engine에서 플러그인은 대체 접근 방식이라기 보다는 단순히 모듈보다 더 높은 수준의 캡슐화 단위입니다. 프로젝트와 마찬가지로 플러그인은 그 안에 여러 코드 모듈을 포함할 수 있습니다. 선택적으로 콘텐츠를 포함할 수도 있습니다.

* INI(Initialization)파일 포맷은 설정 파일에 대한 사실상 표준입니다. INI파일은 단순 구조의 텍스트 파일로 이루어져 있습니다. 보통 마이크로소프트 윈도우와 연결되어 있지만 다른 운영 체제에서도 사용할 수 있습니다. "INI 파일"이라는 이름은, ".INI"라는 파일 확장자가 따라오지만, ".GFG", ".conf", ".TXT"등의 다른 확장자를 사용하기도 합니다.

참고자료:
* [.INI](https://ko.wikipedia.org/wiki/INI_%ED%8C%8C%EC%9D%BC) 
* [Plugins](http://kantandev.com/articles/ue4-plugins)
* [Module](https://docs.unrealengine.com/5.0/ko/unreal-engine-modules/)
* [Gameplay module](https://docs.unrealengine.com/4.27/en-US/ProgrammingAndScripting/GameplayArchitecture/Gameplay/)

## 모듈 사용의 이점
모듈에 대한 모범 사례를 준수하면 프로젝트의 코드를 모두 단일 모듈에 넣을 때보다 프로젝트 코드가 더 잘 구성되고 더 효율적으로 컴파일되며 재사용이 가능합니다.

* 캡슐화
	* 모듈은 기능을 캡슐화하고 코드의 내부 부분을 숨길 수 있는 수단을 제공하여 좋은 코드 분리를 시행합니다.   
* 컴파일 시간 향상   
	* 모듈은 별도의 컴파일 단위로 컴파일됩니다. 즉, 변경된 모듈만 컴파일하면 되며 대규모 프로젝트의 빌드 시간이 훨씬 빨라집니다.   
* Include What You Use 표준에 따름      
	* 모듈은 종속성 그래프에서 함께 연결되며 IWYU(Include What You Use)표준에 따라 실제로 사용되는 코드에 대한 헤더 포함을 제한합니다. 즉, 프로젝트에서 사용되지 않는 모듈은 컴파일에서 안전하게 제외됩니다.   
* 모듈 로드, 언로드 제어   
	* 런타임에 특정 모듈이 로드 및 언로드되는 시기를 제어할 수 있습니다. 이는 사용 가능하고 활성화된 시스템을 관리하여 프로젝트 성능을 최적화하는 방법을 제공합니다.   
* 구성별 코드   
	* 사용자 정의 클래스 및 게임 시스템을 위한 편집기 확장 코드를 작성하려면 전용 편집기 모듈에 넣어야 합니다. 경우에 따라 전처리기 정의를 사용할 수 있지만, 편집기 관련 코드의 사소한 양은 편집기 모듈에 들어가야 합니다. 개발 전용 모듈을 생성하는 것도 가능하므로 예를 들어 shipping(배송이라 번역되네) 빌드에서 자동으로 컴파일되는 디버깅 코드를 가질 수 있습니다. 서버/클라이언트 전용 코드도 마찬가지 입니다.   
* 플랫폼별 코드   
	* 프로젝트가 컴파일되는 플랫폼과 같은 특정 조건에 따라 프로젝트에서 모듈을 포함하거나 제외할 수 있습니다. 각각 자체 모듈에서 플랫폼별 프로젝트 구성 요소 구현을 제공하고 대상을 기반으로 선택적으로 빌드 및 패키지할 수 있습니다.     
* 코드 재사용   
	* 모듈은 여러 프로젝트에서 재사용하기 위한 자연스러운 코드 단위입니다. 코드 수준에서 논리적으로 별개의 시스템을 분리하면 처음에는 원래 작성한 프로젝트 외부에서 유용할 것이라고 생각하지 않은 경우에도 무언가를 재사용하기가 더 쉽습니다. 
	* git을 사용하는 경우 한 가지 효과적인 접근 방식은 재사용 가능한 모듈 자체를 git 리포지토리에 넣은 다음 이를 git 하위 모듈로 모든 프로젝트 리포지토리에 통합하는 것 입니다.    

## 고려사항
* 게임 DLL 모듈성에 대한 철학적 선택
	* 게임 DLL 모듈성에 대해서는 철학적 선택이 있습니다. 게임을 다수의 DLL 파일로 나누는 것은 그 이득보다 문제가 많을 수가 있지만, 이것은 각 팀의 요구와 원칙에 따라 결정해야 합니다.
* 게임플레이속도 저하
	* 다중 게임플레이 모듈을 사용하면 링크 시간이나 코드 반복처리 사긴이 빨라지겠지만, DLL익스포트 또는 인터페이스 클래스를 처리해야 하는 모듈 수가 늘어나게 됩니다. 이러한 상충 관계는 엔진이나 에디터 코드에 대해서는 올바른 것이나, 게임플레이에 대해서는 미심쩍은 것입니다.
* 교차 의존하는 모듈
	* 교차 의존하는 모듈(익스포트와 임포트 함수 양쪽, 그리고 그 서로에서의 데이터, 예로 Engine과 UnrealEd모듈) 생성을 지원은 하나, 컴파일 시간 측면에서 이상적이지는 않습니다. 변수의 정적인 초기화(init)에 가끔 문제를 일으킬 수 있습니다. 게임플레이 모듈을 교차 의존적이지 않게  디자인하고 유지하기란 어려운 일이지만, 코드는 더욱 깔끔해 질 것 입니다.

### 모듈 만들기
엔진 자체가 모듈 모음으로 구성된 것과 같이, 각 게임은 하나 이상의 게임플레이 모듈로 구성됩니다. 관련 클래스 모음을 위한 컨테이너라는 점에서 이전 버전의 엔진 패키지와 유사합니다.

게임을 많은 DLL파일로 분할하는 것은 링크 시간이 더 빨라지겠지만, DLL내보내기 및/또는 인터페이스 클래스를 더 자주 처리해야합니다.

* DLL(Dynamic Link Library)란 소프트웨어 개발에서 자주 쓰고 기초적인 함수들을 중복 개발하는 것을 피하기 위해 표준화된 함수 및 데이터 타입을 만들어서 모아 놓은 것을 의미합니다.
    - 라이브러리를 한번 구축해 놓기만 하면 다시 만들 필요없이 불러서 사용할 수 있으므로 개발 속도도 빨라지고 신뢰성도 확보할 수 있습니다.
    - 이런 라이브러리는 언제 메인 프로그램에 연결하느냐에 따라서 Static Link와 Dynamic Link로 나뉘며, DLL은 후자를 의미합니다.
    - 정적 링크와는 다르게 컴파일 시점에 실행 파일에 함수를 복사하지 않고, 함수의 위치정보만 갖고 그 함수를 호출할 수 있게 한다.

하나 이상의 모듈은 IMPLEMENT_**PRIMARY**_GAME_MODULE로 선언해야 하며, 나머지 모듈은 IMPLEMENT_GAME_MODULE매크로를 사용해야 합니다. UBT(언리얼 빌드 툴)은 자동으로 모듈을 검색하고 추가 게임 DLL을 컴파일 합니다.

* 상호 의존적인 모듈 생성을 지원하지만, 이는 컴파일 시간에 이상적이지 않습니다. 또한 변수의 정적 초기화에 문제를 일으킬 수 있습니다. 상호 의존적이지 않은 게임 플레이 모듈은 설계 및 유지 관리가 더 어렵지만 코드는 더 깨끗할 수 있습니다.
* [Kantan Code Examples](https://github.com/kamrann/KantanCodeExamples), [KantanCharts](https://github.com/kamrann/KantanCharts)참고.

# 보조 모듈 만들기
1. SubModule폴더를 만듭니다. (한곳에 몰아넣어도 됩니다.)
2. SubModule.Build.cs를 추가합니다.
    ```c#
    using UnrealBuildTool;

    public class SubModule : ModuleRules
    {
	    public SubModule(ReadOnlyTargetRules Target) : base(Target)
	    {
		    PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

	    	PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "HeadMountedDisplay" });
	    }
    }
    ```
3. SubModule.h, .cpp를 추가합니다.
    SubModule.h
    ```cpp
    #pragma once

    #include "CoreMinimal.h"
    ```
    SubModule.cpp
    ```cpp
    #include "SubModule.h"
    #include "Modules/ModuleManager.h"

    IMPLEMENT_GAME_MODULE(FDefaultGameModuleImpl, SubModule, "SubModule" );
    ```
# 모듈 빌드에 추가하기
1. 빌드 Target과 EditorTarget에 다음을 추가해 줍니다.
	```c#
		ExtraModuleNames.Add("..", "SubModule"); //현재 작동안함. 찾아봐야 할지 고민중.
	```
	
	또는
	
	```c#
		ExtraModuleNames.Add("SubModule");
    ```
    
# 에디터에 모듈 추가하기
1. .uproject에 모듈을 추가해 줍니다.
    ```
    	"Modules": [
    		{
				...
    		},
    		{
    			"Name": "SubModule",
    			"Type": "Runtime"
    		}
    	],
    ```

이제 에디터에서 c++파일을 추가할 때 SubModule에 추가할 수 있습니다. 

[ModuleRules](https://docs.unrealengine.com/4.26/en-US/ProductionPipelines/BuildTools/UnrealBuildTool/ModuleFiles/), [Targets](https://docs.unrealengine.com/4.26/en-US/ProductionPipelines/BuildTools/UnrealBuildTool/TargetFiles/), .uproject는 [plugins](https://docs.unrealengine.com/4.27/en-US/ProductionPipelines/Plugins/)와 \Engine\Source\Runtime\Projects\Public\ProjectDescriptor.h 그리고 \Engine\Source\Runtime\Projects\Public\ModuleDescriptor.h을 참고할 수 있습니다.