# Environment
Some environment codes to start, after format computer.

## Linux/WSL Aliases:
Clone the project:

```
git clone git@github.com:lucaohost/environment.git
```

Set the aliases in the .bashrc:

```
echo "source $(pwd)/aliases.sh" >> ~/.bashrc
```
To see the available aliases, just type rma (Remember My Aliases):

```
rma
```
![image](https://github.com/lucaohost/environment/assets/31621714/6347cc90-4e5b-44e8-b5b1-9b57a4c0b7de)

## VS Code Key Bindings
In VsCode CTRL + Shift  + P > Open Keyboard Shortcuts (JSON) and paste the content of:

https://github.com/lucaohost/environment/blob/main/vscode-keybindings.json

This key bindings will override the defaults.

CTRL + Y now will open and minimize the terminal. Note that it will keep only one terminal open.

If you want to open more than one, you can use the default key binding CTRL + SHIFT + '.

## WSL Key Binding
To open the WSK terminal on Windows using CTRL+ALT+T like Ubuntu, you need to do this:

Download the file wsl.lnk and paste in your Desktop Area:

https://github.com/lucaohost/environment/blob/main/wsl.lnk

Press CTRL + ALT + T  to test it. If doesn't work, delete this file and do this:

1. First, you need to create a shortcut for the WSL terminal.

2. Right-click on an empty area of your desktop and choose 'New' > 'Shortcut'.

3. In the window that appears, type the following command:

```
wsl.exe
```

4. Click 'Next' and give a name to the shortcut, for example, 'WSL Terminal'. Click 'Finish' to create the shortcut.

5. Now, right-click on the shortcut you created and select 'Properties'.

6. In the 'Shortcut' tab, click on the 'Shortcut key' field and press Ctrl+Alt+T. Click 'OK' to save your changes.
   
Now, whenever you press Ctrl+Alt+T, the WSL terminal will be opened."

### Tips
1. It's kinda slow open the WSL terminal everytime, so I keep open the WSL terminal in second desktop area (not the second monitor).
   When I press the shortcut, Windows redirects me automatically to the WSL Terminal quickly. 
3. To paste in WSL terminal use the right click of the mouse and to copy Ctrl+Insert. 








