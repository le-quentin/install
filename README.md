# install
Install my env (packages, dotfiles management) on a fresh Unix install

## Plan

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

## How to

### Pull the repo

- Setup ssh key for github (copy the generated key in Github account): 
```sh
ssh-keygen -t ed25519 -C "quentin@bonnet.software"
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

### Manual setup after install

First, reboot.

If on arch, Dropbox was installed. Run it from rofi, it should appear in system tray. Set it to launch at startup, and sign in (it will open palemoon. Just sign in in firefox then paste the palemoon link in firefox to link the laptop). It should start syncing. You can find the files in ~/Dropbox. Open Thunar and add it to the quickbar on the left.

One thing the scripts don't take care of is the install of nvidia drivers. But on Manjaro it should be easy enough : Manjaro Settings Manager => install the hybrid intel/nvidia ones; then every program you wanna run on the GPU, simply do it with `prime-run [command]`.

...I could never make browsers work with Nvidia hardware acceleration. But by default they should run with intel graphics one, which is good enough (to check, Firefox: `about:support`=> Graphics having `WebRender` without `(Support)`; Vivaldi: chrome://gpu)

#### Disney

For my job at Disney, I have to use f5vpn. There is an AUR package, but it has proven to be unreliable after updates.

There is a workaround script, which still requires `f5vpn` to work. But the AUR package relies on an unsupported dependency that takes AGES to build. Workaround is using another dependency:
```sh
yay -G f5vpn
```

This downloaded the pkg files. Go into the directory and modify the PKGBUILD, find the `depends=` line, and replace `qt5-webkit` with `python-pyqt5-webengine`. Then:
```sh
makepkg -si
```

Will install the package with this dependency. 

Then, install the script:
```sh
git clone https://github.com/zrhoffman/svpn-login.git
cd svpn-login
./svpn-login.py --sessionid=<session-id> orlando-bsp.disney.com
```

To get the sessionid, just open the vpn virtual desk in a browser, and then run this javascript in the console:
```javascript
document.cookie.match(/MRHSession=(.*?); /)[1]
```

I should install the script in a proper location with these install scripts, and setup an alias for it.

