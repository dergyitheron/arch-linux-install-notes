# Arch Linux install notes
This is my personal collection of notes and guidelines to install Arch Linux on my T450. This is nothing official and there is no guarantee it will work for you. This is just how I do it. There are also some notes and files that I'd like to keep and share.

You can for sure follow this to install Arch on your own machine. Just consider following notes, those might be different for you:
* I have BIOS. Not UEFI. So the installation is different for you if you have UEFI (I have tried to put notice in places where it differs).
* I am using Wifi internet connection. My device has drivers already included in the Arch ISO.
* I am booting from USB
* I have root and swap partitions

Please, for any good reference see [Arch Wiki Installation guide](https://wiki.archlinux.org/index.php/Installation_guide). I recommend to see the version in different languages, in my case there were some notes that helped me and I didn't find them in English version

---

## USB boot and preconfiguration
If you don't have USB with Arch prepared, go to [download ISO here](https://www.archlinux.org/download/). I use Rufus on Windows or `dd` command on Linux to create bootable USB.

### Keyboard layout
You might need to switch keyboard layout before continuing. Default is US. `ls /usr/share/kbd/keymaps/**/*.map.gz` lists all possible layouts. If you need to load for example Czech QWERTZ, command `loadkeys cz-qwertz` will do it.

### Wifi connection
You obviously would be good with internet. I use `iwd` to connect in the live booted USB. First of all, check if there are any active wlan interfaces with command `ip link`. In my case that is `wlan0`.

Next, fire up `iwctl` program which opens its own shell. First, check out the devices:
```bash
[iwd]$ device list
```

If you see your the previously mentioned wireless interface, good. Scan and list all networks with it:
```bash
[iwd]$ station wlan0 scan
[iwd]$ station wlan0 get-networks
```

At this point I usually exit the `iwd` and connect to the network with this command (you can omit the --passphrase if there is none):
```bash
$ iwctl --passphrase myNetworkPassword station wlan0 connect myNetworkSSID
```

And if you `ping github.com` you should receive a response! You are good to go for the preinstallation configuration.

*Keep in mind that this connection is just for the booted system, not for the actual installed one. I do cover Network Manager installation at the very end of the document*

## Preinstallation configuration
Now we need to create partition and format disk. This will actually erase the disk data so if you have anything that needs to be backed up, go back and do it now.

Command `fdisk -l` will show you connected drives. If you have one HDD/SSD drive and your bootable USB connected, you should see something like `/dev/sda` and `/dev/sdb`. You should easily tell from the sizes which one is the target for the system.

This opens the disk formatter tool on the `/dev/sda` drive. I'm not gonna cover how to create partitions and format them, checkout some other tutorial for `fdisk`. But the basic commands are `d` to delete existing partitions, `n` to create new one, `l` to list partitions, `t` to change partition type and `w` to write the changes.
```bash
fdisk /dev/sda
```

What I did was create swap partition `/dev/sda2` of 4GB and the rest is root partition `/dev/sda1`. You can skip the swap partition and go on without next commands related to swap (there is two of them only). **For UEFI systems you also need efi partition. See Arch Wiki for more info.**

Now, format the root and swap partitions:
```bash
$ mkfs.ext4 /dev/sda1
$ mkswap /dev/sda2
```

Activate the swap partition and mount the root partition:
```bash
$ mount /dev/sda1 /mnt
$ swapon /dev/sda2
```

## Install and configure
If you have end up doing all of the above without any issue, well done! Now it's gonna be just about having fun.

Install the Arch. I also threw in Vim because there is no text editor:
```bash
$ pacstrap /mnt base linux linux-firmware vim   #you can substitute vim with nano or other text editors
```

Once that's done, generate some super important file that tells Arch how partitions and file systems are set up:
```bash
$ genfstab -U /mnt >> /mnt/etc/fstab
```

Now, we need to set up few things like locale, timezones and install some packages. This can be changed later when booted into the system.
```bash
$ arch-chroot /mnt
```

Update packages:
```bash
$ pacman -Syu
```

### Timezone and locale
Now we change root directory for the current running process. This means that we can execute commands such as pacman and make it affect the installed system. Set the timezone, select the region and city of that region:
```bash
$ ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Turn on the HW clock:
```bash
$ hwclock --systohc
```

To set locale you first need to go into file `/etc/locale.gen` and uncomment lines with locale you want to be installed. Generate the results with `locale-gen` command. To set up language preference, add following line into file `/etc/locale.conf`:
```bash
LANG=en_US.UTF-8    #this is the locale you uncommented in /etc/locale.gen, can be changed later
```

In file /etc/vconsole.conf you can change keyboard layout. Default is US, but you can have Czech QWERTZ for example:
```bash
KEYMAP=cs-qwertz  #can be also changed later
```

### Hostname
Set up hostname by typing it into `/etc/hostname` (just type the hostname in and save) and then set up `/etc/hosts` like this:
```bash
127.0.0.1	  localhost
::1		      localhost
127.0.1.1	  myhostname.localdomain	myhostname
```

### Boot loader
You need boot loader. For this I grab GRUB as my weapon of choice ([setup with UEFI](https://wiki.archlinux.org/index.php/GRUB#UEFI_systems)):
```bash
$ pacman -S grub
$ grub-install /dev/sda   #if error, add --recheck  to the command
```

If you have Intel CPU, install `intel-ucode` as well. It's important for Microcode updates ([details here](https://wiki.archlinux.org/index.php/Microcode#Enabling_Intel_microcode_updates)).
```bash
$ pacman -S intel-ucode
```

You should find the `intel-ucode` in `/boot` directory. Now just update GRUB config:
```bash
$ grub-mkconfig -o /boot/grub/grub.cfg
```

### Network manager
If you rely on Wifi as me, you need good network manager. I choose NetworkManager and some other useful tools. (You can straight install some DE, for example KDE and GNOME come with network managers.)
```bash
$ pacman -S wpa_supplicant wireless_tools networkmanager
```

Turn NetworkManager on and make sure dhcpcd is disabled:
```bash
$ systemctl enable NetworkManager.service
$ systemctl disable dhcpcd.service
$ systemctl enable wpa_supplicant.service #for wireless security levels
```

After you boot to your system, there will be few commands to connect you to wireless network.

### Final touches
Last important thing what you should do is set password for root with `passwd` command.

Now, simply `umount -R /mnt` the system and `reboot`. Remove the USB stick and you should be booted straight into your new Arch Linux.

## Afterboot
After you reboot, you have to log in with root and password set in earlier steps. First of all start Network Manager and get connected:
```bash
$ systemctl start NetworkManager.service
```

For network management there is `nmcli` command:
```bash
$ nmcli device wifi list    #get list of available wifi networks
$ nmcli device wifi connect myNetworkSSID password myNetworkPassword    #connects you to myNetworkSSID
$ nmcli connection show     #get current connections
```

You can also use and install `nmtui` which is UI tool for terminal for network management.

If you decide to install some DE, for example KDE, create new user and make him sudoer first. Some DEs can't boot as root. First, install sudo:
```bash
$ pacman -S sudo
```
```bash
$ useradd -m derg   #create user derg with home directory
$ passwd derg       #setup password for derg

$ EDITOR=vim visudo #you can substitute vim with nano or other editor, this is the most secure way to add sudoers
```

In the edited file find root record and add `derg ALL=(ALL) ALL` bellow it. Save and close.

Now, to install KDE Plasma DE you need bunch of stuff. To simply have plasma you just need `plasma` and `xorg`. The rest is something extra. You can also install `kde-applications`, but I prefer installing single packages one by one. (See [this page](https://wiki.archlinux.org/index.php/KDE#Installation) for more details)
```bash
$ pacman -S xorg plasma plasma-wayland-session doplhin yakuake firefox yay
```

After done, enable the display manager service:
```bash
$ systemctl enable sddm.service
```

After you `reboot`, you can log into Plasma with newly created user and enjoy DE experience!
