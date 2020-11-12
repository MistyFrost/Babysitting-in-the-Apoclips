extends Panel


onready var Todder_Status_Label = $"CenterContainer/GridContainer/Toddler Status"
onready var Food_Counter = $"CenterContainer/GridContainer/Food Counter"


func _on_Test_Toddler_died():
	Todder_Status_Label.text = "Died of Starvation"


func _on_Test_Toddler_Starving():
	Todder_Status_Label.text = "Toddler is Starving"


func _on_Test_Toddler_Full():
	Todder_Status_Label.text = "Toddler is Full"



func _on_Player_FPS_Controler_update_food_UI(food):
	Food_Counter.text = "Food left: " + str(food)
	



