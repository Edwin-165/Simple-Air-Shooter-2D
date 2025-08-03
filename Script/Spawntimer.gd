extends Timer

var mintime = 1
var maxtime = 5

func _ready():
	spawntime()
	timeout.connect(spawntime)
	
func spawntime():
	set_wait_time(randf_range(mintime, maxtime))
