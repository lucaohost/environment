# Environment
Some environment codes and files to start, after format or change computer.

## Linux/WSL Aliases:
Clone the project:

```
git clone git@github.com:lucaohost/environment.git
```
Go to projects directory:
```
cd environment
```
Set the environemnt variable containing the project's path:
```
echo export "LUCAO_ENV='$(pwd)'" >> ~/.bashrc
```
Set the aliases in the .bashrc:
```
echo "source $(pwd)/aliases.sh" >> ~/.bashrc
```
To see the available aliases, just type rma (Remember My Aliases):

```
rma
```
![image](https://github.com/lucaohost/environment/assets/31621714/67b76767-f705-4bd8-b829-a21149d4770b)

## VS Code Key Bindings
In VS Code CTRL+Shift+P > Open Keyboard Shortcuts (JSON) and paste the content of:

https://github.com/lucaohost/environment/blob/main/vscode-keybindings.json

* These key bindings will override the defaults.
* CTRL+Y now will open and minimize the terminal. Note that it will keep only one terminal open.
* If you want to open more than one, you can use the default key binding CTRL + SHIFT + '.

## WSL Shortcut
To open the WSL terminal on Windows using CTRL+ALT+T like Ubuntu, you need to do this:

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
1. It's kinda slow open the WSL terminal everytime, so I keep open the WSL terminal and when I press the shortcut,
   Windows redirects me quickly to the WSL Terminal.
3. To paste in WSL terminal use the right click of the mouse and to copy Ctrl+Insert.








