// Remove existing files and create symbolic links to the configuration files
CONFIG_DIR=~/Documents/configurations
VSCODE_USER_DIR=~/Library/Application\ Support/Code/User

rm $VSCODE_USER_DIR/keybindings.json
ln -s  $CONFIG_DIR/vscode/keybindings.json $VSCODE_USER_DIR/keybindings.json

rm $VSCODE_USER_DIR/settings.json
ln -s  $CONFIG_DIR/vscode/settings.json $VSCODE_USER_DIR/settings.json

rm ~/.zshrc
ln -s $CONFIG_DIR/zshrc/.zshrc ~/.zshrc

rm ~/.ideavimrc
ln -s $CONFIG_DIR/rider/.ideavimrc ~/.ideavimrc