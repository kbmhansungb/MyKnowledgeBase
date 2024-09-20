api_Key = ""

# 개발자 빠른 시작
# https://platform.openai.com/docs/quickstart?language-preference=python

from openai import OpenAI
client = OpenAI(api_key=api_Key)

# completion = client.chat.completions.create(
#     model="gpt-3.5-turbo", # 테스트를 위해 FreeTier의 gpt-3.5-turbo 사용, https://platform.openai.com/docs/guides/rate-limits/usage-tiers?context=tier-free
#     messages=[
#         {
#             "role": "user",
#             "content": "Write a haiku about recursion in programming."
#         }
#     ]
# )

# print(completion.choices[0].message)