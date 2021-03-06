#!/bin/bash

# Load in the git branch prompt script.
source "$HOME/.git-prompt.sh" #source ~/.git-prompt.sh


#********************************************************************************
#
# HUMANIZE
#
#********************************************************************************
# COLORS
#********************************************************************************
# @usage: printf "${Bla}black ${Red}red ${NC} ...\n"
#********************************************************************************
# Regular         Bold               Underline          High Intensity     BoldHigh Intens..   Background         High Intensity Bgs
Yel='\e[0;33m';   BYel='\e[1;33m';   UYel='\e[4;33m';   IYel='\e[0;93m';   BIYel='\e[1;93m';   On_Yel='\e[43m';   On_IYel='\e[0;103m';
Pur='\e[0;35m';   BPur='\e[1;35m';   UPur='\e[4;35m';   IPur='\e[0;95m';   BIPur='\e[1;95m';   On_Pur='\e[45m';   On_IPur='\e[0;105m';
Bla='\e[0;30m';   BBla='\e[1;30m';   UBla='\e[4;30m';   IBla='\e[0;90m';   BIBla='\e[1;90m';   On_Bla='\e[40m';   On_IBla='\e[0;100m';
Gre='\e[0;32m';   BGre='\e[1;32m';   UGre='\e[4;32m';   IGre='\e[0;92m';   BIGre='\e[1;92m';   On_Gre='\e[42m';   On_IGre='\e[0;102m';
Whi='\e[0;37m';   BWhi='\e[1;37m';   UWhi='\e[4;37m';   IWhi='\e[0;97m';   BIWhi='\e[1;97m';   On_Whi='\e[47m';   On_IWhi='\e[0;107m';
Blu='\e[0;34m';   BBlu='\e[1;34m';   UBlu='\e[4;34m';   IBlu='\e[0;94m';   BIBlu='\e[1;94m';   On_Blu='\e[44m';   On_IBlu='\e[0;104m';
Cya='\e[0;36m';   BCya='\e[1;36m';   UCya='\e[4;36m';   ICya='\e[0;96m';   BICya='\e[1;96m';   On_Cya='\e[46m';   On_ICya='\e[0;106m';
Red='\e[0;31m';   BRed='\e[1;31m';   URed='\e[4;31m';   IRed='\e[0;91m';   BIRed='\e[1;91m';   On_Red='\e[41m';   On_IRed='\e[0;101m';

LS_COLORS='di=37;97;44:fi=1;32:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS

#********************************************************************************
#Back navigation folders
#********************************************************************************
b() {
	if [ "$1" -gt "10" ] # [-gt] is greater than
	then
		return;
	fi
	
	for ((i=0; i<$1 ; i++));
	do
	   	cd ..;
	   	total=$((i+1));
	done
	echo 'back' $total 'times...';
}

bitc() {
	
	username=$1;
	password=$2;
	repository_name=$3;
	dir_name=`basename $(pwd)`;

	if [ "$username" == "" ]; then
		echo "Enter with your username:";
		read -s username;
	fi

	if [ "$username" == "" ]; then
		echo "Exited! Your username is empty";
		return;
	fi

	if [ "$password" == "" ]; then
		echo "Enter with your password:";
		read -s password; # read -s to password
	fi

	if [ "$password" == "" ]; then
		echo "Exited! Your password is empty";
		return;
	fi

	if [ "$repository_name" = "" ]; then 
		echo "Repo name (hit enter to use '$dir_name')?";
		read repository_name;
	fi

	if [ "$repository_name" = "" ]; then 
		repository_name="$dir_name";
	fi

	exec_curl='curl --user '"$username"':'"$password"' https://api.bitbucket.org/1.0/repositories/ --data name='"$repository_name";
	exec_git_a='git init';
	exec_git_b='git remote add origin https://'"$username"'@bitbucket.org/'"$username"'/'"$repository_name"'.git';
	exec_sh_a='touch .gitconfig';
	
	echo `$exec_curl`;
	echo `$exec_git_a`;
	echo `$exec_git_b`;
	echo `$exec_sh_a`;
}


hubc() {
	
	username=$1;
	repository_name=$2;

	if [ "$username" == "" ]; then
		echo "Enter with your username:";
		read -s username;
	fi

	if [ "$username" == "" ]; then
		echo "Exited! Your username is empty";
		return;
	fi
	
	dir_name=`basename $(pwd)`
	
	if [ "$repository_name" = "" ]; then 
		echo "Repo name (hit enter to use '$dir_name')?"
		read repository_name
	fi

	if [ "$repository_name" = "" ]; then 
		repository_name="$dir_name"
	fi

	
	#curl -u '"$username"' https://api.github.com/user/repos?page=0
 	#curl -u '"$username"' https://api.github.com/user/repos -d {"name": "teste", "description": "This is your first repository","homepage": "https://github.com","private": false,"has_issues": true,"has_wik i": true,"has_downloads": true}
 	#curl -u '"$username"' https://api.github.com/user/repos -d '{"name":"teste"}'
	
	exec_curl='curl -u '"$username"' https://api.github.com/user/repos -d {"name":"'"$repository_name"'"}'
 	echo `$exec_curl`;
}


#************************************************************************
# No Color
#************************************************************************
NC='\e[0m'

#************************************************************************
# Status
#************************************************************************
function __git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*";
}

function upsearch () {
    test / == "$PWD" && return || test -e "$1" && echo "found: " "$PWD" && return || cd .. && upsearch "$1"
}

#************************************************************************
#Desktop
#************************************************************************
alias desk='cd $HOME/Desktop';
alias docs='cd $HOME/Documents';
alias pics='cd $HOME/Pictures';
alias downloads='cd $HOME/Downloads';


#************************************************************************
alias ls='ls -F --color=auto --show-control-chars'
alias lsd='ls -Ghpla --color=auto'
alias l='ls -CF'
alias ll='ls -l'
alias reload='source ~/.bashrc'
 
alias home='cd ~/'
alias apt-get='aptget'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
 
alias vi='vim'
alias profile='vi ~/.bash_aliases'
 
alias o='start explorer .'
alias np='start "" "C:\Program Files (x86)\Notepad++\notepad++.exe" '
alias subl='start "" "C:\Program Files\Sublime Text 3\sublime_text.exe" '
alias c='start "" "%USERPROFILE%\AppData\Local\Google\Chrome\Application\chrome.exe" '
alias profile='np ~/.bash_profile'
alias s='subl .'
alias ab='start "" //B //WAIT "C:\Program Files (x86)\Apache Software Foundation\Apache2.2\bin\ab.exe" '
alias fdt='"/c/DEV/FDT-64/FDT.exe"'
alias ecli='"/c/DEV/eclipse/eclipse.exe"'

#************************************************************************
#Open files to edit
#************************************************************************
alias sb='s  -a ~/.bashrc' 
alias sho='s -a /c/windows/System32/drivers/etc/hosts' 
alias svh='s -a /c/wamp/bin/apache/Apache2.4.4/conf/extra/httpd-vhosts.conf'

#************************************************************************
#Vms do vagrant
#************************************************************************
alias vag='cd /c/VMS/'

#************************************************************************
#Alias para os comandos git
#************************************************************************
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias got='git '
alias get='git '
alias ggr='git graph'
alias hism='git reset --hard origin/master'
alias calc='calc &'

#************************************************************************
#Jenkins commands
#************************************************************************
alias jstop='cd /c/CASIFILES/DEV/jenkins/; java -jar jenkins.war;'
alias jstart='cd /c/CASIFILES/DEV/jenkins/; java -jar jenkins.war --httpPort=9090 &'
alias jrestart='cd /c/CASIFILES/DEV/jenkins/; java -jar jenkins.war'
alias djenkins='cd /c/CASIFILES/DEV/jenkins/; java -jar jenkins.war;'

#************************************************************************
# PS1 colored with username, machine name, count, timestamp, branch name and git status
#************************************************************************

#********************************************************************************
PS1='$(__git_ps1 "[${Yel}%s${NC}${Red}$(__git_dirty)${NC}] ")'"${Cya}\w${NC}"' \n\$ '
#PS1="\[$Yel\]\t\[$Red\]-\[$Blue\]\u\[$Yellow\]\[$Yellow\]\w\[\033[m\]\[$Magenta\]\$(__git_ps1)\[$White\]\$ "
