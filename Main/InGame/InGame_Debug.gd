extends Control


func _process(delta):
	$InGameState.text = "InGame: " + str(Ingame.INGAME_STATE.keys()[Ingame.state])

func _on_TravelButton_button_up():
	Ingame.set_state(Ingame.INGAME_STATE.travel)

func _on_IdleButton_button_up():
	Ingame.set_state(Ingame.INGAME_STATE.idle)	
