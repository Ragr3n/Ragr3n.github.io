# Cheat Sheet

01 - SSH Keys
----------------
Create ssh keys for github and ssh
```bash
ssh-keygen -t ed25519 -C "{{ EMAIL@EXAMPLE.COM }}" -f ~/.ssh/ssh
ssh-keygen -t ed25519 -C "{{ EMAIL@EXAMPLE.COM }}" -f ~/.ssh/github
```
Edit ssh config and add below
```bash
nano .ssh/config
```
```bash
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/github

Host *
  IdentitiesOnly yes
  IdentityFile ~/.ssh/ssh
  User {{ USERNAME }}
```
02 - Github
----------------
Get github public key and add it to github account at https://github.com/settings/keys
```bash
cat .ssh/github.pub 
```
Configure git
```bash
git config --global user.name "{{ USERNAME }}"
git config --global user.email "{{ EMAIL@EXAMPLE.COM }}"
```
Clone git to current folder or specified folder
```bash
git clone {{ REPO_URL }} .
git clone {{ REPO_URL }} {{ FOLDER }}
```