extends VBoxContainer

export var game_id = "GAME_ID"
export var score_type = "highscore"
export var score_limit = 5

onready var url = "https://kgd07w68ll.execute-api.eu-central-1.amazonaws.com/prod/score/" + game_id + "/" + score_type

onready var title := $Title
onready var http := $ScoreRequest
onready var table := $Table
onready var username := $SubmitInput/Name
onready var submit_btn := $SubmitInput/Submit
onready var score_label := $Score

var submitted = false
var submitting = false
var score = 0 setget set_score

func _ready():
	title.text = "Scoreboard: Top " + str(score_limit)


func set_score(value):
	score = value
	score_label.text = "Your score: " + str(score)
	submitted = false # A new score can now be submitted


func load_scores():
	submit_btn.disabled = true
	if http.request(url) != OK:
		print("Failed to get scores")

func _set_scores(scores):
	table.clear()
	
	for s in scores:
		var datetime = OS.get_datetime_from_unix_time(s.time)
		var datetime_str = "%s-%s-%s %s:%s" % [datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute]
		table.add_row_label([s.score, s.user, datetime_str])
		
		if score >= s.score and not submitted:
			submit_btn.disabled = false


func _on_ScoreRequest_request_completed(result, response_code, headers, body: PoolByteArray):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Request was not successful")
		return
	
	var body_str = body.get_string_from_utf8()
	var data = JSON.parse(body_str)
	if typeof(data.result) == TYPE_ARRAY: # GET request should be an array
		_set_scores(data.result)
	elif submitting:
		load_scores() # reload after submitting new score
		submitted = true
		submitting = false


func _on_Submit_pressed():
	if not username.text or submitted:
		return
	
	var data = {
		'score': score,
		'user': username.text,
		'time': OS.get_unix_time()
	}
	if http.request(url, [], true, HTTPClient.METHOD_POST, to_json(data)) == OK:
		submit_btn.disabled = true
		submitting = true
	else:
		print("Failed to submit score")
