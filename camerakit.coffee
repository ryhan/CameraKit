class @CameraKit

  navigator.getMedia =
    navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia

  window.URL =
    window.URL ||
    window.webkitURL ||
    window.mozURL ||
    window.msURL

  DEFAULT_WIDTH = 300
  DEFAULT_HEIGHT = 0

  constructor: (options={}) ->

    @width = options.width || DEFAULT_WIDTH
    @height = options.height || DEFAULT_HEIGHT
    @throwError = options.onerror || @_showWarning

    if navigator.getMedia
      @_appendCameraElement()
      @_requestNativeCameraAccess()
    else
      @throwError()

  # Returns an image encoded as an image/png data URL
  getImage: ->
    # @_updateDimensions @canvas
    @canvas.getContext('2d').drawImage @video, 0, 0, @width, @height
    data = @canvas.toDataURL "image/png"

  getData: ->
    data = @canvas.getContext('2d').getImageData 0, 0, @width, @height

  # First, add the camera element to the DOM
  _appendCameraElement: ->

    $camera = $("<div class='camerakit' />").css {
      'visibility' : 'hidden',
      'opacity' : 0,
      'z-index' : -1
    }
    $('body').append $camera

    @video = $("<video />")[0]
    @canvas = $("<canvas />")[0]
    $camera.append @video
    $camera.append @canvas


  # Then, wait for the video element to be ready.
  _requestNativeCameraAccess: ->
    @_streaming = false
    @video.addEventListener 'canplay', @_resizeVideoElement, false
    navigator.getMedia { video: true }, @_cameraHandler, @throwError


  # Resize the video and canvas elements to use a proportionate height.
  _resizeVideoElement: =>
    if not @_streaming
      @height = @video.videoHeight / (@video.videoWidth / @width)
      @_updateDimensions @video
      @_updateDimensions @canvas
      @streaming = true

  # Process the stream coming from the video element
  _cameraHandler: (stream) =>
    if navigator.mozGetUserMedia
      @video.mozSrcObject = stream
    else
      @video.src = window.URL.createObjectURL stream
    @video.play()

  # Default way to handle errors. Can be overridden by supplying an 'onerror' function
  _showWarning: ->
    console.warn "Could not access native camera."

  _updateDimensions: (el) =>
    el.setAttribute "height", @height
    el.setAttribute "width", @width
