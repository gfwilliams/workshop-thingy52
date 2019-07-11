## [Step 5 - Notifications](step5.md)

## Step 5 : Notifications

Ok, so what if we want to get data from a Bluetooth Peripheral?

Well, we could use `characteristic.readValue()` which behaves exactly like
you'd expect - it returns a promise which resolves with the value.

However in many cases we're not interested repeatedly making readings,
but in getting notified when a reading changes.

* Ensure you don't have the `nRF Connect` app or and Web Bluetooth pages open and connected to the Thingy
* Connect to your Thingy with the Web IDE
* Upload the following code:

```JS
NRF.setServices({
    "7b340000-105b-2b38-3a74-2932f884e90e": {
      "7b340003-105b-2b38-3a74-2932f884e90e": {
        readable: true,
        notify: true,
        value: [0, 0, 0]
      }
    }
  }
);
NRF.on("connect", () => {
  setTimeout(() => {
    Thingy.onAcceleration(accel => {
      NRF.updateServices({
        "7b340000-105b-2b38-3a74-2932f884e90e": {
          "7b340003-105b-2b38-3a74-2932f884e90e": {
            value: [accel.x/10, accel.y/10, accel.z/10],
            notify: true
          }
        }
      });
    });
  }, 2000);
});
NRF.on("disconnect", _=>Thingy.onAcceleration());
```

* Now disconnect the IDE.

The Thingy has now configured itself as the following:

* **Service:** UUID 7b340000-105b-2b38-3a74-2932f884e90e - Thingy Service
  * **Characteristic:** UUID 7b340003-105b-2b38-3a74-2932f884e90e - Accelerometer - 3 bytes (notifyable)

So all we have to do is use `getPrimaryService` and `getCharacteristic` to find
the characteristic as before, but then `characteristic.startNotifications()` to
start us receiving `characteristicvaluechanged` events whenever the Thingy
sends a notification.

```HTML
<html>
<body>
<button onclick="connect()">Connect to Web Bluetooth</button>
<div id="data"></div>
<script>
function connect() {
  var dataDiv = document.querySelector("#data");
  var options =  {
    filters: [
      {namePrefix: 'Thingy'},
    ],
    optionalServices: [ "7b340000-105b-2b38-3a74-2932f884e90e" ]
  };
  var busy = false;
  var gatt, service;
  dataDiv.textContent = "Connecting";
  navigator.bluetooth.requestDevice(options).then(function(device) {
    console.log('Device: ' + JSON.stringify(device));
    return device.gatt.connect();
  }).then(function(g) {
   gatt = g;
   // Get our custom service
   return gatt.getPrimaryService("7b340000-105b-2b38-3a74-2932f884e90e");
  }).then(function(s) {
    service = s;
    // Get the Acceleorometer characteristic
    return service.getCharacteristic("7b340003-105b-2b38-3a74-2932f884e90e");
  }).then(function(characteristic) {    
    // When we get a notification, write the data to a div below the button
    characteristic.addEventListener('characteristicvaluechanged', function(event) {
      var value = event.target.value.buffer; // an arraybuffer
      dataDiv.textContent = (new Int8Array(value)).toString();
    });
    // Now start getting notifications
    return characteristic.startNotifications();
  }).then(function() {
    dataDiv.textContent = "Waiting for data...";
    //gatt.disconnect();
    console.log("Done!");
  }).catch(function(error) {
    dataDiv.textContent = "Ooops - " + error;
    console.log("Something went wrong. " + error);
  });
}
</script>
</body>
</html>
```


## That's it!
