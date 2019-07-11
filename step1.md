# Workshop: Web Bluetooth for IoT Sensors

In this workshop we'll figure out how to use Web Bluetooth to interact with
other devices - but also how to use Espruino on embedded devices to develop
our own Bluetooth-enabled hardware.


**Note:** Nordic Thingy:52 devices have been provided by [@NordicTweets](https://twitter.com/NordicTweets) - please let them know on Twitter if you enjoy using Espruino on their devices.

## Step 1 - Connecting

The first step is to connect to your Thingy:52 via Web Bluetooth.
We'll do this with the Espruino IDE.

* First, go to http://www.espruino.com/ide **in an up to date Chrome Web Browser**
* Click the connection icon in the top left

Note: if using GNU/Linux you'll need to enable "experimental-web-platform-features" flag.

(Track [status](https://github.com/WebBluetoothCG/web-bluetooth/blob/master/implementation-status.md))

![](img/webide1.png)

* You should see `Web Bluetooth` - if you don't, check out [Espruino's Guide](http://www.espruino.com/Quick+Start+BLE#with-web-bluetooth) and if there's nothing useful there, seek help. We have a few USB dongles that'll work on older Macs and PCs.

![](img/webide2.png)

* Now it's time to set up the Thingy so you can connect to it.
* Peel the rubber case of the Thingy:52 back where the USB connector is, and flip the switch while making sure you're not pressing the top of the Thingy (there's a switch there):

![](img/thingy1.jpg)

![](img/thingy2.jpg)

* When the switch is in the 'on' position (away from USB) the Thingy should flash red for an instant.
* Now put it close to your computer.
* Click the connect icon in the top left of the IDE again, and click `Web Bluetooth`
* You should see a bunch of devices - choose the one beginning with the word `Thingy `
which has the highest signal strength shown by it:

![](img/webide3.png)

* Now you should be connected! While connected your Thingy will stop advertising so won't appear in anyone else's Web Bluetooth connection screen.

![](img/webide4.png)

On the left-hand side of the IDE is a REPL where you can enter commands. There's
Tab Completion and command history (using the up arrow) which may help you. Ctrl-C will clear the current line.

On the right-hand side there's an editor. Ctrl-Space will autocomplete, including documentation on the various functions available.
To upload code from the right-hand side, just click the 'Upload' button right in the middle of the IDE.

* To check you've got the right Thingy, try entering a command like `LED1.set()/reset()` or `Thingy.beep()` in the REPL on the left and make sure it's your one that is affected!

For a quick run-down of commands for accessing the hardware, check out http://www.espruino.com/Thingy52#on-board-peripherals

## Using the Thingy

Try entering the following code:

```JS
var flipped = false;

Thingy.onAcceleration(function(xyz) {
  var f = xyz.z < 0;
  if (flipped!=f) Thingy.beep(f ? 100 : 200);
  flipped = f;
});
```

You can either copy/paste this into the REPL on the left, or into the editor and then click upload.

Now if you flip the Thingy over it'll beep - with a different pitch depending on which way up it is.

**Note:** if you're uploading code that `require`s modules that aren't built in to the device, you'll
have to put that code on the right hand side and upload from there so the IDE is able to analyse your
code and figure out what needs loading.

## Other stuff...

If you're interested in playing with Espruino further...

* Try the simple on-screen tutorial by clicking the book in the top right of the IDE,
followed by `Tutorial`
* See the normal Espruino intro at http://www.espruino.com/Quick+Start+Code
* Check out the Thingy:52 documentation and tutorials: http://www.espruino.com/Thingy52
* Try the Graphical code editor - go to the Web IDE `Settings`->`General` and turn on `Nordic Thingy:52` under `Graphical Editor Extensions` - then click the `</>` icon at the bottom of the Web IDE window.


## Web Bluetooth Steps...

If the IDE at http://www.espruino.com/ide worked for you then great,
you're sorted!

If it didn't and it couldn't be made to work, but you can get Node.js and [Noble](https://github.com/noble/noble) working then
you can use [the Web Bluetooth wrapper for Node](https://www.npmjs.com/package/webbluetooth)
to follow along with more or less the same code (you can also use the
[Espruino command-line tools]((https://www.npmjs.com/package/espruino)) to communicate with the Thingy:52.




## [Step 2 - Advertising](step2.md)
