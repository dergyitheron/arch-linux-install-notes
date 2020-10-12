Pacman
```bash
-S  #is for Synchronization
-Q  #is for Query
-R  #is for Remove

-Syu  #update+upgrade
-Ss   #search for a package in the repos
-Qs   #search for an installed package
-Rns  #clean uninstall (removes all files linked to the package, including config files)
```

Yay updates checker with relevant packages. `~/.yay_pkgs` is just list of keywords to match separated by newlines.
```bash
#yay update checker
function getRelevantUpdates() {
  echo n | yay 1,2> /dev/null && yay -Qu | grep -o '^\S*' |  grep -f ~/.yay_pkgs
}

res=$(getRelevantUpdates)
echo -e "\e[39mRelevant package updates ($(echo ${res} | wc -w)): \e[92;1m$(echo ${res//[[:space:]]/, })"
unset res
```
