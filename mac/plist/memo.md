### [backupZshHistory.plist](backupZshHistory.plist)

```shell
# build backup_zsh_history
cd ~/.dotfiles/mac/scripts
gcc -Wall -o backup_zsh_history backupZshHistory.c

# copy plist file to ~/Library/LaunchAgents
cd ~/.dotfiles/mac/plist
cp backupZshHistory.plist ~/Library/LaunchAgents

# load plist file
launchctl load ~/Library/LaunchAgents/backupZshHistory.plist
```
