# Obsidian tools - a Python package for analysing an Obsidian.md vault
# https://pythonrepo.com/repo/mfarragher-obsidiantools-python-general-utilities

import obsidiantools.api as otools

# 현재 작업 디렉토리에 있는 Obsidian vault를 로드합니다
path = "./"
vault = otools.Vault(path).connect()


# 모든 link를 출력합니다.
for mdLinks in vault.md_links_index:
    print(mdLinks) # 이름 출력
    print(vault.md_links_index[mdLinks]) # 링크 출력
    
