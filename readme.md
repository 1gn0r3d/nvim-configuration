# Guide for a fresh installation (on a windows machine)
## Install windows terminal
### Download and set up nerd font:
'Hurmit Nerd Font'
## Install scoop
~~~
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
~~~
## Install gcc and fzf
### Install CMake
~~~
scoop install cmake
~~~
### Install Make
~~~
scoop install make
~~~
### Install gcc
~~~
scoop install gcc
~~~
### Install fzf
~~~
scoop install fzf
~~~
### Install ripgrep
~~~
scoop install ripgrep
~~~
## Install python, venv
~~~
scoop install python
pip install venv
~~~
## Install neovim
~~~
scoop install neovim
~~~
## Navigate to neovim folder and get config from github
~~~
cd .\AppData\Local\nvim
git clone www.github.com/1gn0r3d/nvim-configurations
mv nvim-configurations nvim
~~~
## Potentially: run make on fzf folder:
~~~
cd .\Appdata\Local\nvim-data\lazy\telescope-fzf.nvim
make
~~~
