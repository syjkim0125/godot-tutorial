extends Node

@onready var infoCard: Control = $InfoCard
@onready var animationSprite: AnimatedSprite2D = $InfoCard/AnimatedSprite2D
@onready var infoCardText: RichTextLabel = $InfoCard/RichTextLabel
@onready var button: Button = $InfoCard/Button

signal close_dialog

func _ready():
	clear()

func toggle(show):
	if(show):
		button.visible = false
		infoCardText.visible = false
		infoCard.visible = true
		animationSprite.play("flip")
		animationSprite.set_frame(0)
	else:
		infoCard.visible = false
		clear()

func clear():
	infoCard.visible = false
	infoCardText.text = ""
	infoCardText.visible = false
	button.visible = false

func _on_animated_sprite_2d_animation_finished():
	infoCardText.visible = true
	infoCardText.visible_ratio = 0
	
	var tween = create_tween()
	tween.tween_property(infoCardText, "visible_ratio", 1, 2).set_trans(Tween.TRANS_LINEAR)
	tween.connect("finished", on_tween_finished)

func _on_button_pressed():
	emit_signal("close_dialog")
	toggle(false)

func on_tween_finished():
	button.visible = true
	
