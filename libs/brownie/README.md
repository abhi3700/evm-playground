# Brownie
Smart Contract Development Framework using Python language

## Features
* Deployment
* Interaction
* Debugging
* Testing

### Deployment
* local, live or forked

### Interaction
* Interactive console

### Debugging
* Write your tests comprehensive results and summaries
* let brownie pick values and parse into the test functions

### Testing
* Provides results coverage GUI (Green to Red color display).

## Installation
### Dependencies
* Tools
	- `ganache-cli` [languages: node.js >= 6.11.5]: run test blockchains
	- `pipx` [languages: Python >= 3.6.0]: allow to run brownie 

### Steps
1. Check the node & npm versions
```console
$ node -v
$ npm -v
```
1. Install the Ganache CLI & check version
```console
$ npm install -g ganache-cli
$ ganache-cli --version
```
1. Install python3 (3.6+) & check version
```console
$ sudo apt install python3.8
$ nano ~/.bashrc
 add `alias python3=python3.8`
$ source ~/.bashrc
$ python3 -V
```
1. Install pipx [For Ubuntu]. 
```console
$ sudo apt install python3-pip
$ pip3 install pipx
$ python3 -m pip install --user pipx [OPTIONAL]
$ python3 -m pipx ensurepath

Restart the terminal
$ pipx --version
```
1. Install Brownie
```console
$ sudo apt-get install python3-venv
$ pipx install eth-brownie
```

> NOTE: Like `npx` for npm in Nodejs, `apt` in Ubuntu, `pipx` plays the role of running isolated environment for running applications 

> `pip` vs `pipx`: With pipx when you install things they go into isolated environments. With pip you're just installing things globally.


## References
* Brownie tutorial by Curve Finance - https://github.com/curvefi/brownie-tutorial
* Brownie playlist by Curve Finance - https://www.youtube.com/playlist?list=PLVOHzVzbg7bFUaOGwN0NOgkTItUAVyBBQ