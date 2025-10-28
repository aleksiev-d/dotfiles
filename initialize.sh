// Remove existing files and create symbolic links to the configuration files
rm ~/Library/Application\ Support/Code/User/keybindings.json
ln -s  ~/Documents/configurations/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

rm ~/Library/Application\ Support/Code/User/settings.json
ln -s  ~/Documents/configurations/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

rm ~/.zshrc
ln -s ~/Documents/configurations/zshrc/.zshrc ~/.zshrc

rm ~/.ideavimrc
ln -s ~/Documents/configurations/rider/.ideavimrc ~/.ideavimrc