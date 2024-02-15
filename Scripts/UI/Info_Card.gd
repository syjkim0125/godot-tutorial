extends Node

@onready var InfoCard: Control = $"../InfoCard"
@onready var AnimationSprite: AnimatedSprite2D = $"../InfoCard/AnimatedSprite2D"
@onready var Text: RichTextLabel = $"../InfoCard/RichTextLabel"

func _ready():
	clear()

func toggle(show):
	if(show):
		Text.visible = false
		InfoCard.visible = true
		AnimationSprite.play("flip")
		AnimationSprite.set_frame(0)
	else:
		InfoCard.visible = false

func clear():
	InfoCard.visible = false
	Text.text = ""
	Text.visible = false


func _on_animated_sprite_2d_animation_finished():
	Text.visible = true
	Text.visible_ratio = 0
	
	var tween = create_tween()
	tween.tween_property(Text, "visible_ratio", 1, 2).set_trans(Tween.TRANS_LINEAR)
