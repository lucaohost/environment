# Environment
Some environment codes to start, after format or change computer.

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
In VS Code CTRL+Shift+P > Open Keyboard Shortcuts (JSON) and paste the content of:

https://github.com/lucaohost/environment/blob/main/vscode-keybindings.json

* These key bindings will override the defaults.
* CTRL+Y now will open and minimize the terminal. Note that it will keep only one terminal open.
* If you want to open more than one, you can use the default key binding CTRL + SHIFT + '.

## WSL Shortcut
To open the WSK terminal on Windows using CTRL+ALT+T like Ubuntu, you need to do this:

Download the file wsl.lnk and paste in your Desktop Area:

https://github.com/lucaohost/environment/blob/main/wsl.lnk

Press CTRL + ALT + T  to test it. If doesn't work, delete this file and follow these steps:

1. Right-click on an empty area of your desktop and choose 'New' > 'Shortcut'.
2. In the window that appears, type the following command:

```
wsl.exe
```

3. Click 'Next' and give a name to the shortcut, for example, 'WSL Terminal'. Click 'Finish' to create the shortcut.
4. Now, right-click on the shortcut you created and select 'Properties'.
5. In the 'Shortcut' tab, click on the 'Shortcut key' field and press Ctrl+Alt+T. Click 'OK' to save your changes.
   
Now, whenever you press Ctrl+Alt+T, the WSL terminal will be opened."

### Tips
1. It's kinda slow open the WSL terminal everytime, so I keep open the WSL terminal in second desktop area (not the second monitor).
   When I press the shortcut, Windows redirects me quickly to the WSL Terminal.
2. To paste in WSL terminal use the right click of the mouse and to copy Ctrl+Insert.








