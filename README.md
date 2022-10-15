# install
Install my env (packages, dotfiles management) on a fresh Unix install

## TODO

Those will be a starting point, because of course I will adjust config along the way with what I find convenient or not.

[ ] - i3 proper dual screen handling (external is main screen, worskpaces dispatching on hdmi plug)
[ ] - replace dmenu with rofi (opening windows and desktop apps + add a kickass theme)
[ ] - notification applet with "do not disturb" mode
[ ] - pretty status bar (look at polybar and polybar themes)
[ ] - fix tmux-powerline with a proper look (look at themes)
[ ] - selected tmux-pane is circled (instead of the ugly "pane*")
[ ] - pretty terminal (pretty colors, a lil opacity ? Again... look at themes)
[ ] - Test zoom, meet, slack, all with screenshare
[ ] - vim improvements : fix git plugin (commands, +/- next to the line numbers...)
[ ] - check tmux still preserve history on ungraceful exit
[ ] - test: fresh install on manjaro i3 or minimal 
[ ] - test: fresh install on EndeavourOs (minimal edition ?)

## How to

### Pull the repo

- Setup ssh key for github (copy the generated key in Github account): 
```sh
ssh-keygen -t ed25519 -C "quentin.bonnet.work@gmail.com"
```
- Clone this wherever you'd like
```sh
git clone git@github.com:le-quentin/install.git
```

### Install
Run the relevant script, i.e. for arch distros:
```sh
./install-all.arch.sh
```
