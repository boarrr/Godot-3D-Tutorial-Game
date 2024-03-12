extends Node

@export var mob_scene: PackedScene

func _ready():
	$UI/Retry.hide()

func _on_spawn_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
	
	mob.initalize(mob_spawn_location.position, player_position)
	mob.squashed.connect($UI/Score._on_mob_squashed.bind())
	
	add_child(mob)

func _on_player_hit():
	$UI/Retry.show()
	$SpawnTimer.stop()


func _unhandled_input(event):
	if event.is_action_pressed("restart") and $UI/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
