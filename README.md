# Arch Linux install notes
This is my personal collection of notes and guidelines to install Arch Linux on my T450. This is nothing official and there is no guarantee it will work for you. This is just how I do it.

You can for sure follow this to install Arch on your own machine. Just consider following notes, those might be different for you:
* I have BIOS. Not UEFI. So the installation is different for you if you have UEFI. Do not follow my guidelines, it won't do any good.
* I am using Wifi internet connection.
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
$ pacstrap /mnt base linux linux-firmware vim # you can substitute vim for nano or other text editors
```

Once that's done, generate some super important file that tells Arch how partitions and file systems are set up:
```bash
$ genfstab -U /mnt >> /mnt/etc/fstab
```

Now, we need to set up few things like locale, timezones and install some packages.
```bash
arch-chroot /mnt
```
