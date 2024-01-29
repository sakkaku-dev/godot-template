class_name RateLimitedSpawner2D
extends Spawner2D

@export var limiter: RateLimiter

func spawn():
	if limiter:
		if limiter.should_wait(): return
	
		limiter.run()
	
	return _create()
