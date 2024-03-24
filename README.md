# install
Install my env (packages, dotfiles management) on a fresh Unix install, using Ansible

## How to

Right now, this is supposing a host with Ansible installed, since the playbook runs locally.

When and if I find a convenient way to ssh into my VMs out of the box (probably some QEMU setup, maybe Packer or Vagrant..?), I might change this to remote install.

### Pull the repo

- Setup ssh key for github (copy the generated key in Github account): 
```sh
ssh-keygen -t ed25519 -C "quentin@bonnet.software"
```
- Clone this wherever you'd like
```sh
git clone git@github.com:le-quentin/install.git
```

### Install Ansible

This should be seamless on most distros. Also, this should pull a lot of helpful dependencies.

i.e., for debian:
```sh
sudo apt install ansible
```

### Run the playbook

```sh
ansible-playbook -i hosts.yaml install-all.yaml -K
```

If caps2esc needs to be installed (transform caps lock into escape/ctrl):

```sh
ansible-playbook -i hosts.yaml caps2esc.yaml -K
```

If you're on a btrfs filesystem:

```sh
ansible-playbook -i hosts.yaml btrfs.yaml -K
```

If you're on a Dell Precision laptop:

```sh
ansible-playbook -i dell-precision.yaml -K
```

Indeed, by default Dell laptops don't seem to have working dynamic fan speed in linux... Ideally I shoudl find a way to enable fan sensors so I can control the fans dynamically... [This seems to be the way](https://www.reddit.com/r/Dell/comments/9pdgid/configuring_the_xps_to_play_nice_with_linux/) (and then install fancontrol_gui or something similar), but I couldn't make it work so far.

Until I find the best (dynamic) solution, this sets the fans to a better mode, which seems to mitigate the issue a *lot*.

### Manual setup after install

First, reboot.

Install the drivers for external wifi card. i.e. on arch:
- Install linux headers for compilation (i.e on Arch `yay -Syu linux61-headers` for 6.1 LTS kernel)
- Install the drivers (i.e on Arch `yay -Syu rtl88x2bu-dkms-git`)

## History 

### Plan

I'm used to wokring on MacOs. I wanna switch to Linux for my next laptop.

MacOs isn't perfect (and ofc, I don't love Apple, for many reasons), but the least I can say is: it's been stable. I never had an issue with my system breaking.
I never formatted or cleaned my system. I dare say I've been a poor maintainer. But my system never broke on me, I was always able to login and work as I intend. 

If I want my Linux machine to be the same I need a plan. Current plan :

* Main system: rolling release, arch based (candidates are Manjaro and EndeavousOs. Endeavour feels nicer but I will probably stick with Manjaro because of the ease of i3 install and the improved stability with the 2 weeks delay with arch repos)
    * As it is expected to break someday after an update, this MUST have a reliable snapshot mechanism. So => btrfs partitioning, timeshift setup to take weekly/daily snapshots + snaphots before updates. 
    * Should take at least 50% of the disk, depending on size.
    * After 6 months of use, Manjaro has definitely provent to be stable, and timeshift snapshots/rollbacks work great in case of trouble. I just had my first big problem, and it was related to btrfs getting full without warning (because of the weird way it works). Added some maintenance tools to the install to try and fix that.
* Secondary system: in case of failure, a Fedora. 
    * Doesn't need backup because is very unlikely to break. An ext4 partition should be good enough
    * Should take ~25% of disk, depending on size
    * This will be helpful just in case my system breaks critically on a weekday and I need to work before having time to fix things.
* Leisure system: for leisure use, during trips etc, a Windows install 
    * Should take ~25% of disk, depending on size

## TODO

Those will be a starting point, because of course I will adjust config along the way with what I find convenient or not.

- [ ] Show btrfs unallocated space in polybar (this is the btrfs concept that is closest to "free space", this should never get too low)
- [ ] Configure backups on another partion, or even better another disk. Good tool: https://github.com/digint/btrbk
- [ ] When I have a decent NAS, automatically backup there (btrbk seems to handle it just fine as well)
- [ ] global ctrl+h/j/k/l send left/up/down/right with udevmon? 
- [ ] rework theme scripts into a proper "omnitheme" project (Python? Rust? Go?), because this is becoming bigger than expected
- [x] pick better colours for tmux-powerline and experiment with a few themes
- [x] themes parametered with primary/secondary colors? Look into design good practices
- [ ] separate parameters for the bar so that it sticks out more? 
- [ ] Add gtk2/gtk3 exports to the "omnitheme" project
- [ ] IntelliJ exports? 
- [ ] replace various git pulls with zipped sources so I get a reliable version of deps
- [ ] clean up to keep only what I need 
- [x] i3 proper dual screen handling (external is main screen, worskpaces dispatching on hdmi plug) => 1-5 on external, 6-8 on laptop screen
- [x] replace dmenu with rofi (opening windows and desktop apps + add a kickass theme)
- [x] notification applet with "do not disturb" mode => did it with a custom module, display left of the system tray
- [x] pretty status bar (look at polybar and polybar themes)
- [ ] polybar (or whole i3?) reloads on hdmi plug/unplug
- [x] fix tmux-powerline with a proper look (look at themes)
- [x] fix tmux-powerline separators to the center section having the wrong colour (center front instead of current segment back)
- [x] selected tmux-pane is circled (instead of the ugly "pane\*")
- [x] pretty terminal (pretty colors, a lil opacity ? Again... look at themes)
- [ ] Fix conky: adapt to screen size, get rid of irrelevant help (or replace with personal stickies?)
- [x] Test zoom, meet, slack, all with screenshare
- [x] vim improvements : fix git plugin (commands, +/- next to the line numbers...)
- [x] vim improvements : better airline theme (match with terminal palette)
- [ ] vim ide : java LSP setup
- [x] Try nvim ?
- [ ] Keep customizing nvim as an IDE: Plugin for files and classes fuzzy search
- [ ] Keep customizing nvim as an IDE: TreeSitter for better syntax highlighting? Check how it works with omnitheme
- [ ] Keep customizing nvim as an IDE: complete java functionnality on CocoBot and Disney project
- [ ] Keep customizing nvim as an IDE: java autocomplete improvement - get super methods after concrete ones (need to fork jdt.ls?)
- [ ] nvim IDE : how to have an easily togglable terminal like in IntelliJ? 
- [ ] check tmux still preserve history on ungraceful exit
- [ ] test: fresh install on manjaro i3 or minimal 
- [ ] test: fresh install on EndeavourOs (minimal edition ?)

