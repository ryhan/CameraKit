# CameraKit

A slightly nicer way to access a webcam from within a browser. Built by [Ryhan](https://github.com/ryhan).

#### Start by intializing a new instance of `CameraKit`. 

This should cause the browser to prompt the user about allowing access to the camera.
```javascript
// Set up and request access to the camera
var camera = new CameraKit();
```

You can optionally supply an `onerror` function that catches when
- the browser does not support native webcam access, or
- the user chose to deny webcam access

```javascript
var camera = new CameraKit({
  onerror: function(){ /* Do something when we couldn't access the camera */ }
});
```

#### Get the current image from the camera

Call `getImage()` on your `CameraKit` object. You'll be returned a png encoded as a data url.

```javascript
// Get a png encoded as a data url...
var new_image = camera.getImage();

// ... and set it as the source of your <img /> element.
some_image_element.setAttribute('src', new_image);
```
