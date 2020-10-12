#                                                                                                                                                                                                   
# ~/.bashrc                                                                                                                                                                                         
# 
# Requires exa and yay installed for some aliases and last part of package updates checker                                                                                                                                                                                        
#

# If not running interactively, don't do anything                                                                                                                                                   
[[ $- != *i* ]] && return                                                                                                                                                                           

#### some colouring ####                                                                                                                                                                            
use_color=true                                                                                                                                                                                      

if ${use_color} ; then                                                                                                                                                                              
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489                                                                                                                                   
        if type -P dircolors >/dev/null ; then                                                                                                                                                      
                if [[ -f ~/.dir_colors ]] ; then                                                                                                                                                    
                        eval $(dircolors -b ~/.dir_colors)                                                                                                                                          
                elif [[ -f /etc/DIR_COLORS ]] ; then                                                                                                                                                
                        eval $(dircolors -b /etc/DIR_COLORS)                                                                                                                                        
                fi                                                                                                                                                                                  
        fi                                                                                                                                                                                          

        alias ls='ls --color=auto'                                                                                                                                                                  
        alias grep='grep --colour=auto'                                                                                                                                                             
        alias egrep='egrep --colour=auto'                                                                                                                                                           
        alias fgrep='fgrep --colour=auto'                                                                                                                                                           
else                                                                                                                                                                                                
        if [[ ${EUID} == 0 ]] ; then                                                                                                                                                                
                # show root@ when we don't have colors                                                                                                                                              
                PS1='\u@\h \W \$ '                                                                                                                                                                  
        else                                                                                                                                                                                        
                PS1='\u@\h \w \$ '                                                                                                                                                                  
        fi                                                                                                                                                                                          
fi                                                                                                                                                                                                  

unset use_color safe_term match_lhs sh

#### aliases ####
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias ll='exa -alhgF'
alias buiser='npm run build && clear && serve -s dist/'
alias ssh-caj='ssh root@147.32.110.102'
alias ssh-derg='ssh root@derg.cz'
alias ls='ls --color=auto'
alias ll='exa -alhgF'

#### prompt formatting ####
txtcyn='\[\e[0;96m\]'
txtred='\[\e[31m\]'
txtyel='\[\e[0;33m\]'
txtwhi='\[\e[37m\]'
txtblu='\[\e[34m\]'

bold=$(tput bold)
normal=$(tput sgr0)

function gitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\n${txtyel}┌─⭘ ${bold}\u ${normal}${txtwhi}in ${txtcyn}\w ${txtwhi}at ${txtblu}\$(date +'%T') ${txtred}\$(gitBranch)${txtwhi}\n${txtyel}└─⭘ ${txtwhi}"

#### nvm scripts path ####
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### deno scripts path ####
export DENO_INSTALL="/home/derg/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

#### yay update checker ####
function getRelevantUpdates() {
  echo n | yay 1,2> /dev/null && yay -Qu | grep -o '^\S*' |  grep -f ~/.yay_pkgs
}

res=$(getRelevantUpdates)
echo -e "\e[39mRelevant package updates ($(echo ${res} | wc -w)): \e[92;1m$(echo ${res//[[:space:]]/, })"

unset res
