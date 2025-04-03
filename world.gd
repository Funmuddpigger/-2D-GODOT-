extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var camera2d: Camera2D= $Player/Camera2D

# 计算相机边框
func _ready() -> void:
	# 拿到地图已使用像素
	var used := tile_map.get_used_rect().grow(-1)
	var tile_size := tile_map.tile_set.tile_size

	camera2d.limit_top = used.position.y * tile_size.y
	camera2d.limit_bottom = used.end.y * tile_size.y

	camera2d.limit_left = used.position.x * tile_size.x
	camera2d.limit_right = used.end.x * tile_size.x
	camera2d.reset_smoothing()
