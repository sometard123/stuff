MYREPO = https://github.com/sometard123/BMC-Reborn.git
#make push to push your local repository to your remote repository
#make pull to update your local repository
push: addremote
	git push origin master
pull: remove
	git remote add origin $(MYREPO)
	git pull origin master
addremote: commit
	git remote add origin $(MYREPO)
commit: add
	git commit
add: remove
	git add .
remove:
	git remote remove origin

