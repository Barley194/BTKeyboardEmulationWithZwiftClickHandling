Emulating the Zwift Click clicks as a virtual bluetooth keyboard.

What is this for? - If you want to use different game than Zwift (like MyWhoosh or others), but want to use the Zwift Click device to change virtual gears, you have to firstly translate the zwift click clicks to a standard keyboard preses and
then if you run the game on a different device (phone, tablet etc.) you need a way to transfer those keyboard clicks to the device running the game. That where you need to emulate the keyboard via bluetooth.
You simply connet the end device to the device running the scripts using bluetooth, and clicking the buttons on Zwift Click will act as pressing a keyboard button on the end device running the game.

By default it is setup for MyWhoosh (in 4.0 they added a virtual shifting) where the keys to upshif and downshift are "K" and "I". You can easly change the keys by editing the `startAll.sh` script.

By default it has a 30 minut timeout since starting the script until the script will fail due to not finding a Zwift Click device. If that happen, run the `startAll.sh` again.

My use case looks like this:
- Power on the raspberry pi
- Power on the trainer
- click a button on Zwift Click to put it in pairing mode
- train
- Power off the trainer
- Power off the raspberry pi

Due to this, I have no idea wether it will keep the connection to the Zwift Click if not used for longer period of time or not.


This is a project I made to combine 2 differrent projects into one. 
Most of the code is taken and slightly modifed from those 2 repositories:

https://github.com/jat255/zwift_click_handling

https://github.com/thanhlev/keyboard_mouse_emulate_on_raspberry

so most of the credits goes to the authors of those.

But I've made some modifications to better fit my use case and to launch everything with one command.

I was doing it on Raspberry Pi 3 with just a single, built in bluetooth adapter.

How to run:

- clone this git repository
- run `./setup.sh` once
- run `./startAll.sh` to start everything up
- (Optionaly) Add the `startAll.sh` script to crontab in order to start it at boot.
  Enter `crontab -e` and add at the end `@reboot sudo /path/to/the/repository/startAll.sh`
- Click a button on Zwift Click to wake it and put it in connecting mode (blue light blinking)
- Connect the end device to the "RpiVirtualKeyboard" over bluetooth (you can verify if it's working by opening a notepad, or any text field on the end device and pressing a button on zwift click, if it prints the letter, then it will work in game as well)

If you disconnect the bluetooth from the end device, in order for it to start working without restarting, first press a button on zwift click, it will then detect that no bluetooth end device is conneted and start listening for new connections then connect back to the RpiVirtualKeyboard and everything should work.
