function rand(n) {
 return Math.floor(Math.random()*n)
}

function random_color() {
  var r = rand(255)
    , g = rand(255)
    , b = rand(255)

  return "rgb(" + r + "," + g + "," + b + ")"
}
