---
tags:
  - Unreal
---
[TDD(Test Driven Development, 테스트 주도 개발)](../TestDrivenDevelopment/TestDrivenDevelopment.md)는 **테스트 케이스를 먼저 작성하고, 이를 통과하는 코드를 구현하는 반복적인 소프트웨어 개발 방법론**입니다. 이 방식은 코드를 개발하는 과정에서 피드백을 빠르게 받을 수 있게 하며, **프로그래머의 과도한 구현을 방지**하고 **코드의 품질을 높이는 효과**를 기대할 수 있습니다. 또한, 테스트 코드 작성 과정에서 과거 의사결정을 추적할 수 있는 **히스토리가 남아** 유지 보수에 유리합니다.

"테스트 케이스를 만들다 보면, 보이지 않았던 것들이 보인다."는 말처럼, **TDD는 코드의 불안정성**이나 **미처 예상하지 못했던 문제점**을 더 명확하게 드러내는 중요한 역할을 합니다.

## Unreal Automation Test

[자동화 시스템 개요](https://docs.unrealengine.com/4.27/ko/TestingAndOptimization/Automation/)를 참고하면 언리얼의 **자동화 시스템은 Functional Testing Framework (펑셔널 테스팅 프레임워크) 기반으로 만들어졌으며, 하나 이상의 자동화 테스트를 수행하는 식으로 이루어지는 게임플레이 레벨 테스트를 위해 디자인된 것**입니다. 작성되는 대부분의 테스트는 펑셔널 테스트, 로우 레벨 코어 또는 에디터 테스트로, 자동화 프레임워크 시스템을 사용하여 작성해야 합니다.

- 테스트 유형을 참고할 수 있습니다. 단 테스트 유형과 `ex) SmokeFilter`, `ex) ApplicationContextMask`는 다르게 되어 있습니다.

### 테스트 디자인 지침
게임 또는 프로젝트를 테스트할 때, 에픽의 자동화 테스트 기준으로 삼는 몇 가지 일반적인 지침은 다음과 같습니다:

1. 게임 또는 에디터 상태를 가정하지 않습니다. 테스트는 순서 없이 또는 여러 머신에 걸쳐 병렬 실행될 수 있습니다.
2. 디스크의 파일은 찾은 상태 그대로 놔둡니다. 테스트에서 파일을 생성한 경우, 그 테스트가 완료되면 삭제합니다. (앞으로 이러한 유형의 생성 파일을 자동 삭제하도록 하는 옵션이 추가될 수 있습니다).
3. 테스트는 지난 번 실행된 이후 나쁜 상태에 있었다 가정합니다. 테스트 시작 전 생성 파일을 삭제하는 습관을 들이는 것이 좋습니다.

### 테스트 만들기
[자동화 테크니컬 가이드](https://docs.unrealengine.com/4.27/ko/TestingAndOptimization/Automation/TechnicalGuide/)를 참고하여 가장 간단하다고 생각되는 테스트 구현 예시로 다음이 있습니다.

```c
IMPLEMENT_SIMPLE_AUTOMATION_TEST(TClass, PrettyName, TFlags)
```

- Flags는 어디서 테스트를 하는 것이 적합한지를 나타냅니다. 정의부를 보면 설명이 나와있습니다.

`IMPLEMENT_SIMPLE_AUTOMATION_TEST`를 사용하는 예시는 다음과 같습니다.

```c
#include "Misc/AutomationTest.h"
#include "Tests/AutomationEditorCommon.h"

IMPLEMENT_SIMPLE_AUTOMATION_TEST(FTestClassName, "Sample.AutomationSectionClasses", EAutomationTestFlags::ApplicationContextMask | EAutomationTestFlags::SmokeFilter)

bool FTestClassName::RunTest(const FString& parameters)
{
}
```

아래는 월드를 생성해서 테스트 하는 방법입니다. 하지만... 월드를 생성하는 만큼 느립니다.

```c
// Test with world
IMPLEMENT_SIMPLE_AUTOMATION_TEST(FTestClassName, "Sample.AutomationSectionClasses", EAutomationTestFlags::EditorContext	 | EAutomationTestFlags::ProductFilter)

bool FTestClassName::RunTest(const FString& parameters)
{
    UWorld* world = FAutomationEditorCommonUtils::CreateNewMap();
    {
        ATheFestivalCharacter* hero = world->...
    }
}
```

- `EAutomationTestFlags::ApplicationContextMask`가 없을 경우,
    - error C2338: AutomationTest has no application flag. It shouldn't run. See AutomationTest.h.
- `..._LATENT_AUTOMATION_COMMAND`은 여러 프레임에 걸쳐 실행되야 하는 경우, 사용하는 잠복명령 입니다. 자동화 테크니컬 가이드를 참고하세요.

### 테스트 코드 분리하기
테스트 코드를 분리하기 위한 방법들은 다음과 같습니다.

1. 플러그인을 이용하는 방법
2. 매크로를 이용하는 방법이 있습니다.

플러그인을 이용하는 방법으로는 Editor전용 플러그인을 만들어서 사용합니다.

```json
	"Modules": [
		{
			"Name": "HorrorCoreEditor",
			"Type": "Editor",
			"LoadingPhase": "Default"
		}
	]
```

매크로를 이용하는 방법으로는 다음과 같이 감싸, 에디터가 아닐 경우 번역 단위에서 제외합니다.

```c
#if WITH_EDITOR
...
#endif
```

### 테스트 케이스 CSSV로 관리하기
1. 데이터 테이블형 구조체를 만듭니다.
2. 구조체를 이용하여 데이터 테이블을 만듭니다.
3. 데이터 테이블을 읽고 처리하는 테스트를 만듭니다.
4. 테스트를 돌릴 수 있습니다.

- 행을 Index로 순환한다고 하면, 행의 번호를 CaseID로 이용할 수 있습니다.

```c
#include "Engine/DataTable.h"
...

USTRUCT(BlueprintType)
struct FInventory2DInsertTest : public FTableRowBase
{
	GENERATED_BODY()
    ...
```

다음과 같이 Asset을 읽어 옵니다.

```c
	UDataTable* TestDataTable = LoadObject<UDataTable>(nullptr, TEXT("DataTable'/HorrorCoreEditor/Horror2DInventoryTest/Horror2DInventoryTestDataTable.Horror2DInventoryTestDataTable'"));
	TestNotNull("TestDataTable is not valid.", TestDataTable);
	if (!TestDataTable)
	{
		return false;
	}
```

테스트 케이스를 입력하고, 테스트를 돌리면, 테스트 결과를 얻을 수 있습니다.

### Blueprint Functional Test
[Functional Testing](https://docs.unrealengine.com/4.27/en-US/TestingAndOptimization/Automation/FunctionalTesting/)를 참고하여 언리얼 엔진의 기능 테스트는 아래와 같은 순서로 구현합니다.

1. Level의 게임모드를 Functional Test Gamemode로 만듭니다.
2. Level에 Functional Test 액터를 배치합니다.
3. Test가 끝났다면, Functional Test 액터의 Finish Test를 호출 합니다.