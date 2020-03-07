# Changing CAPS_LOCK to ESCAPE on Logitech K380 bluetooth keyboard on Android

I've been using a rooted Android 9 tablet with Termux and it is great. I really wanted to change CAPS_LOCK to ESCAPE, because I'm used to that on my desktop when using vim. Fortunately I managed to do it. Here is how:

## 1. Find the keyboard's Vendor and Product id

1. Open tmux
2. $ su
3. $ cat /proc/bus/input/devices

	```
	...
	I: Bus=0005 Vendor=046d Product=b342 Version=0001
	N: Name="Keyboard K380"
	S: Sysfs=/devices/virtual/mics/uhid/0005:046D:B342.0007/input/input14
	...
	```

4. $ mkdir -p /data/system/devices/keylayout
5. $ cp /system/usr/keylayout/Generic.kl /data/system/devices/keylayout/Vendor_046D_Product_B342_Version_0001.kl
6. $ vim /data/system/devices/keylayout/Vendor_046D_Product_B342_Version_0001.kl
7. Change line "key 58 CAPS_LOCK" to "key 58 ESCAPE"
