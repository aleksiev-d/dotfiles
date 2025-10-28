CONFIG_DIR=~/Documents/configurations
# MacOs Vs_Code path
# VSCODE_USER_DIR=~/Library/Application\ Support/Code/User

# Linux Vs_Code path
VSCODE_USER_DIR=~/.config/Code/User

echo "Setting up VS Code keybindings..."
rm $VSCODE_USER_DIR/keybindings.json
ln -s $CONFIG_DIR/vscode/keybindings.json $VSCODE_USER_DIR/keybindings.json

echo "Setting up VS Code settings..."
rm $VSCODE_USER_DIR/settings.json
ln -s $CONFIG_DIR/vscode/settings.json $VSCODE_USER_DIR/settings.json

echo "Setting up zsh configuration..."
rm ~/.zshrc
ln -s $CONFIG_DIR/zshrc/.zshrc ~/.zshrc

echo "Setting up IdeaVim configuration..."
rm ~/.ideavimrc
ln -s $CONFIG_DIR/rider/.ideavimrc ~/.ideavimrc

echo "Installing VS Code extensions..."
while IFS= read -r extension || [ -n "$extension" ]; do
  if [ -n "$extension" ]; then
    echo "Installing $extension..."
    code --install-extension "$extension"
  fi
done <"$CONFIG_DIR/vscode/extensions.txt"
echo "VS Code extensions installation complete!"
