extends Node

@onready var InfoCard: Control = $InfoCard
@onready var AnimationSprite: AnimatedSprite2D = $"InfoCard/AnimatedSprite2D"
@onready var InfoCardText: RichTextLabel = $"InfoCard/RichTextLabel"

signal close_dialog

func _ready():
	clear()

func toggle(show):
	if(show):
		InfoCardText.visible = false
		InfoCard.visible = true
		AnimationSprite.play("flip")
		AnimationSprite.set_frame(0)
	else:
		InfoCard.visible = false
		clear()

func clear():
	InfoCard.visible = false
	InfoCardText.text = ""
	InfoCardText.visible = false


func _on_animated_sprite_2d_animation_finished():
	InfoCardText.visible = true
	InfoCardText.visible_ratio = 0
	
	var tween = create_tween()
	tween.tween_property(InfoCardText, "visible_ratio", 1, 2).set_trans(Tween.TRANS_LINEAR)


func _on_button_pressed():
	emit_signal("close_dialog")
	toggle(false)
