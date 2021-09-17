extends Control

var viewportWidth = get_viewport().size.x
var viewportHeight = get_viewport().size.y

onready var Background = $Sprite

var scale = viewportWidth / Background.texture.get_size().x

# Set same scale value horizontally/vertically to maintain aspect ratio
# If however you don't want to maintain aspect ratio, simply set different
# scale along x and y
Background.set_scale(Vector2(scale, scale))
