extends CharacterBody2D

# 定义移动数值常量
const RUN_SPEED := 200.0
const JUMP_VELOCITY := -300.0

var gravity := ProjectSettings.get("physics/2d/default_gravity") as float

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
    # 定义每帧左右移动
    var direction := Input.get_axis("move_left","move_right")
    velocity.x = direction * RUN_SPEED
    # 定义每帧y轴移动
    velocity.y += gravity * delta

    # 定义每帧跳跃
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        velocity.y = JUMP_VELOCITY

    # 定义播放动画(闲置无输入还是跑动中)
    if is_on_floor():
        if is_zero_approx(direction):
            animation_player.play("idle")
        else:
            animation_player.play("running")
    else:
        animation_player.play("jump")

    # 当在移动的时候，且输入的方向是向左，则翻转动画
    if not is_zero_approx(direction):
        sprite_2d.flip_h = direction < 0

    
    move_and_slide()

