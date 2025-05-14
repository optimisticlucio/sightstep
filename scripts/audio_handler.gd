class_name LightsHandler
extends Node2D

var lights_off_function: Callable;
var lights_on_function: Callable;

var lights_are_on: bool = false;

@onready var animation_handler: AnimationPlayer = $LightHandler;

# Supposed to be ran when the lights are turned on
func lights_on():
	lights_on_function.call();
	lights_are_on = true;

# Supposed to be ran when the lights are turned off
func lights_off():
	lights_off_function.call();
	lights_are_on = false;

# Starts the lights on animation.
func turn_lights_on():
	animation_handler.play("light_flicker");
