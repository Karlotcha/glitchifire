;$(function() {
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

  function moveFragment(image, ctx) {
    var x = rand(width)
      , y = rand(height)
      , w = rand((width - x)/10) + 1
      , h = rand((height - y)/10) + 1
      , dx = x - 20 + rand(20)
      , dy = y - 20 + rand(20)
      , fragment = ctx.getImageData(x, y, w, h)

    ctx.putImageData(fragment, dx, dy)
  }

  function colorFragment(image, ctx) {
    var x = rand(width)
      , y = rand(height)
      , w = rand((width - x)/(rand(20)+1)) + 1
      , h = rand((height - y)/(rand(20)+1)) + 1
      , fragment = ctx.getImageData(x, y, w, h)
      , index = (x + y * w) * 4
      , color = rand(3)
      , new_color = rand(255)

    for (var i = 0; i < index; i=i+4) {
      fragment.data[i + color] = new_color
    }

    ctx.putImageData(fragment, x, y)
  }

  var source_img = document.getElementById("source")
  ctx.drawImage(source_img, 0, 0)

  var image = ctx.getImageData(0, 0, width, height)

  for (var i = 0; i < (width + height); i++) {
    drawPixel (image, rand(width), rand(height), rand(255), rand(255), rand(255), 255)
  }
  updateCanvas(image, ctx)

  for (var i = 0; i < 500; i++) {
    colorFragment(image, ctx)
    moveFragment(image, ctx)
  }

});
