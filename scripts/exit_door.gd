class_name ExitDoor
extends Node2D

func close_door():
	$"Door-light".visible = false;
	$Door.texture = preload("res://assets/img/closed_door.png");
