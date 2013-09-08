// Generated by CoffeeScript 1.6.3
(function(){var e=function(e,t){return function(){return e.apply(t,arguments)}};this.CameraKit=function(){function r(r){r==null&&(r={});this._updateDimensions=e(this._updateDimensions,this);this._cameraHandler=e(this._cameraHandler,this);this._resizeVideoElement=e(this._resizeVideoElement,this);this.width=r.width||n;this.height=r.height||t;this.throwError=r.onerror||this._showWarning;if(navigator.getMedia){this._appendCameraElement();this._requestNativeCameraAccess()}else this.throwError()}var t,n;navigator.getMedia=navigator.getUserMedia||navigator.webkitGetUserMedia||navigator.mozGetUserMedia||navigator.msGetUserMedia;window.URL=window.URL||window.webkitURL||window.mozURL||window.msURL;n=300;t=0;r.prototype.getImage=function(){var e;this.canvas.getContext("2d").drawImage(this.video,0,0,this.width,this.height);return e=this.canvas.toDataURL("image/png")};r.prototype._appendCameraElement=function(){var e;e=$("<div class='camerakit' />").css({visibility:"hidden",opacity:0,"z-index":-1});$("body").append(e);this.video=$("<video />")[0];this.canvas=$("<canvas />")[0];e.append(this.video);return e.append(this.canvas)};r.prototype._requestNativeCameraAccess=function(){this._streaming=!1;this.video.addEventListener("canplay",this._resizeVideoElement,!1);return navigator.getMedia({video:!0},this._cameraHandler,this.throwError)};r.prototype._resizeVideoElement=function(){if(!this._streaming){this.height=this.video.videoHeight/(this.video.videoWidth/this.width);this._updateDimensions(this.video);this._updateDimensions(this.canvas);return this.streaming=!0}};r.prototype._cameraHandler=function(e){navigator.mozGetUserMedia?this.video.mozSrcObject=e:this.video.src=window.URL.createObjectURL(e);return this.video.play()};r.prototype._showWarning=function(){return console.warn("Could not access native camera.")};r.prototype._updateDimensions=function(e){e.setAttribute("height",this.height);return e.setAttribute("width",this.width)};return r}()}).call(this);