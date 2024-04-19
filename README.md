# Environment
Some environment codes, files and configs to start, after format or change computer.   
- You can follow the instalation steps below or see the instalation video: https://www.youtube.com/watch?v=bvv0vEM73UA
- Also you can see this another video, exploring the aliases: https://www.youtube.com/watch?v=bvv0vEM73UA

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
![image](https://github.com/lucaohost/environment/assets/31621714/b0e384df-02a1-4674-9b91-9d84c75ca4cc)   
or run this command to re-run the .bashrc and reflect the changes.
```
source ~/.bashrc
```
To see the available aliases, just type rma (Remember My Aliases):

```
rma
```
![image](https://github.com/lucaohost/environment/assets/31621714/ca2e752b-23ef-4caa-b676-7fcccae915ec)   


## VS Code Key Bindings
In VS Code CTRL+Shift+P > Open Keyboard Shortcuts (JSON) and paste the content of:

https://github.com/lucaohost/environment/blob/main/vscode-keybindings.txt

* These key bindings will override the defaults.
* CTRL+1 now will open and minimize the terminal. Note that it will keep only one terminal open.
* If you want to open more than one, you can use the default key binding CTRL+SHIFT+'.

## WSL Shortcut
To open the WSL Terminal usign Ctrl+Alt+T like Ubuntu, follow the Bishwas Bhandari's tutorial:
* https://bishwas.medium.com/use-the-ctrl-alt-t-shortcut-to-open-the-terminal-in-windows-11-bbbfeac9cb85
* In case the article doesn't exists anymore, you can access in: https://github.com/lucaohost/environment/blob/main/wsl-shortcut-tutorial.pdf
* Dont' forget to click on "More Pages" to see the full tutorial:
  
  ![image](https://github.com/lucaohost/environment/assets/31621714/990dbe57-8021-4064-b800-0e4d1d910938)

## Windows 11 Night Light   
Until my last researches, there no way to create a shortcut or alias, to turn on the Windows Night Light.   
The fastest way is Windows Key + A and click in the Night Light icon.   

![image](https://github.com/lucaohost/environment/assets/31621714/e2893bc1-61c1-4922-8442-1d83a9a2e6fc)   

## Switch Snipping Tool to Lightshot   
[Windows 11 Disable Snipping Tool and switch to Lightshot.pdf](https://github.com/lucaohost/environment/files/15030381/Windows.11.Disable.Snipping.Tool.and.switch.to.Lightshot.pdf)











