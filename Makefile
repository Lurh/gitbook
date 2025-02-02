# Makefile for automating gh-pages update

# 定义常用变量
BRANCH_NAME = gh-pages

# 获取当前日期（格式：YYYY-MM-DD）
CURRENT_DATE := $(shell date +'%Y-%m-%d')

COMMIT_MSG = "文档更新: $(CURRENT_DATE)"

# 目标：默认目标会运行 `make all`
all: update-gh-pages

new-gh-pages-branch:
	git checkout --orphan gh-pages

# 目标：更新 gh-pages 分支
update-gh-pages:
	# 1. 创建并切换到孤立的 gh-pages 分支

	# 2. 创建 .gitignore 文件
	echo "*~" > .gitignore
	echo "_book" >> .gitignore
	echo "draft" >> .gitignore
	echo ".DS_Store" >> .gitignore
	echo "node_modules" >> .gitignore
	echo ".gitignore" >> .gitignore
	
	# 3. 删除所有缓存的文件，清理未追踪的文件并删除所有备份文件
	git rm --cached -r -q .
	git clean -df -q
	rm -rf *~

	# 4. 复制 _book 中的内容到当前目录
	cp -r ../gitbook_private/_book/* .
	cp ../gitbook_private/Makefile.gitbook Makefile
	echo "blog.runhao.life" >> CNAME # 如果需要替换个人域名，修改这里

	# 5. 添加更改到 git 并提交
	git add -A
	git commit -m 'gitbook更新: $(CURRENT_DATE)'

	# 6. 推送更改到远程的 gh-pages 分支
	git push -u origin $(BRANCH_NAME)
