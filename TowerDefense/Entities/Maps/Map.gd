extends Node2D

var pathA : PathFollow2D = null
var pathB : PathFollow2D = null
var pathC : PathFollow2D = null
var pathD : PathFollow2D = null

export var speedA : float = 1.0
export var speedB : float = 1.0
export var speedC : float = 1.0
export var speedD : float = 1.0

func _ready():
	pathA = find_node("FollowA")
	pathB = find_node("FollowB")
	pathC = find_node("FollowC")
	pathD = find_node("FollowD")

func _physics_process(delta):
	if pathA:
		pathA.offset += delta*speedA
	if pathB:
		pathB.offset += delta*speedB
	if pathC:
		pathC.offset += delta*speedC
	if pathD:
		pathD.offset += delta*speedD