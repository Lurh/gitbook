# Makefile for automating gh-pages update

# 定义常用变量
BRANCH_NAME = gh-pages

# 获取当前日期（格式：YYYY-MM-DD）
CURRENT_DATE := $(shell date +'%Y-%m-%d')

COMMIT_MSG = "文档更新: $(CURRENT_DATE)"

# 目标：默认目标会运行 `make all`
all: commit-and-update-gh-pages

new-gh-pages-branch:
	git checkout --orphan gh-pages

# 通过提交更新并构建新的文档，更新 GitHub Pages
commit-and-update-gh-pages: commit-changes build-book update-gh-pages

# 提交更改并推送到主分支
commit-changes:
	@echo "Committing changes with message: $(COMMIT_MSG)"
	git add .
	git commit -m '$(COMMIT_MSG)'
	git push -u origin main

update-gh-pages: build-book exec-gitbook-makefile

# 构建新的 GitBook 文档
build-book:
	@echo "Building the GitBook..."
	gitbook build

# 更新 GitHub Pages
exec-gitbook-makefile:
	@echo "Updating GitHub Pages..."
	$(MAKE) -C ../gitbook
