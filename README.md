# install
Install my env (packages, dotfiles management) on a fresh Unix install

## Plan

I'm used to wokring on MacOs. I wanna switch to Linux for my next laptop.

MacOs isn't perfect (and ofc, I don't love Apple, for many reasons), but the least I can say is: it's been stable. I never had an issue with my system breaking.
I never formatted or cleaned my system. I dare say I've been a poor maintainer. But my system never broke on me, I was always able to login and work as I intend. 

If I want my Linux machine to be the same I need a plan. Current plan :

* Main system: rolling release, arch based (candidates are Manjaro and EndeavousOs. Endeavour feels nicer but I will probably stick with Manjaro because of the ease of i3 install and the improved stability with the 2 weeks delay with arch repos)
    * As it is expected to break someday after an update, this MUST have a reliable snapshot mechanism. So => btrfs partitioning, timeshift setup to take weekly/daily snapshots + snaphots before updates. 
    * Won't enable AUR by default, chances are official repos will have all I need for my work environment.
    * Should take at least 50% of the disk, depending on size.
* Secondary system: in case of failure, a Fedora 
    * Doesn't need backup because is very unlikely to break. An ext4 partition should be good enough
    * Should take ~25% of disk, depending on size
* Leisure system: for leisure use, during trips etc, a Windows install 
    * Should take ~25% of disk, depending on size

## TODO

Those will be a starting point, because of course I will adjust config along the way with what I find convenient or not.

- [ ] i3 proper dual screen handling (external is main screen, worskpaces dispatching on hdmi plug)
- [ ] replace dmenu with rofi (opening windows and desktop apps + add a kickass theme)
- [ ] notification applet with "do not disturb" mode
- [ ] pretty status bar (look at polybar and polybar themes)
- [ ] fix tmux-powerline with a proper look (look at themes)
- [ ] selected tmux-pane is circled (instead of the ugly "pane\*")
- [ ] pretty terminal (pretty colors, a lil opacity ? Again... look at themes)
- [ ] Test zoom, meet, slack, all with screenshare
- [ ] vim improvements : fix git plugin (commands, +/- next to the line numbers...)
- [ ] check tmux still preserve history on ungraceful exit
- [ ] test: fresh install on manjaro i3 or minimal 
- [ ] test: fresh install on EndeavourOs (minimal edition ?)

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
