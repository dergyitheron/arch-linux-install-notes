## pacman
```bash
## currently using yay for pkg management
-S  #is for Synchronization
-Q  #is for Query
-R  #is for Remove

-Syu  #update+upgrade
-Ss   #search for a package in the repos
-Qs   #search for an installed package
-Rns  #clean uninstall (removes all files linked to the package, including config files)
```
## commands

```shell
du -sh folder/  #size of folder summed up and human readable
sudo !!  #run last command executed with as superuser
echo "ls -l" | at midnight  #run command at specific time
ssh-keygen -t rsa -b 4096   #basic rsa key generation
```
```shell
sudo groupadd $group
sudo adduser $user
sudo usermod -aG $group $user
```

## hotkeys

```
Ctrl + A  Go to the beginning of the line you are currently typing on
Ctrl + E  Go to the end of the line you are currently typing on
Ctrl + L  Clears the Screen, similar to the clear command
Ctrl + U  Clears the line before the cursor position. If you are at the end of the line, clears the entire line.
Ctrl + K  Clears the line after the cursor
Ctrl + W  Delete the word before the cursor
Ctrl + H  #Same as backspace
Ctrl + R  #Let’s you search through previously used commands
Ctrl + C  #Kill whatever you are running
Ctrl + D  Exit the current shell
Ctrl + Z  Puts whatever you are running into a suspended background process. fg restores it.
Ctrl + T  Swap the last two characters before the cursor
Esc + T   Swap the last two words before the cursor
Alt + F   Move cursor forward one word on the current line
Alt + B   Move cursor backward one word on the current line
Tab       #Auto-complete files and folder names
```

## links

> https://wiki.manjaro.org/Linux_Security (manjaro permissions, users, firewall)</br> > https://wiki.archlinux.org/index.php/Security (arch advanced security)
