// $('body').append('<canvas id="canvas" width="1000" height="1000" style="border:1px solid red;"></canvas>')
$('body').append('<canvas id="canvas" width="1000" height="1000"></canvas>')

var c      = document.getElementById("canvas")
  , ctx    = c.getContext("2d")
  , width  = c.width
  , height = c.height

function drawPixel (image, x, y, r, g, b, a) {
  var index = (x + y * width) * 4

  image.data[index + 0] = r
  image.data[index + 1] = g
  image.data[index + 2] = b
  image.data[index + 3] = a
}

function updateCanvas(image, ctx) {
  ctx.putImageData(image, 0, 0)
}

// image = ctx.createImageData(width, height)
// drawPixel (100, 100, 100, 100, 100, 100, 100)
// updateCanvas()

var source_img = new Image()
source_img.src = 'https://avatars3.githubusercontent.com/u/1086288?v=3&s=460'
source_img.crossOrigin = "Anonymous"

source_img.onload = function() {
  ctx.drawImage(source_img, 0, 0)
}

setInterval(function() {
  var image = ctx.getImageData(0, 0, width, height)
  drawPixel (image, 100, 100, 100, 100, 100, 100, 100)
  updateCanvas(image, ctx)
}, 1)
