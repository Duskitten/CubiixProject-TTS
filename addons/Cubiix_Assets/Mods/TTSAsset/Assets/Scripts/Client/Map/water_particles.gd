extends CPUParticles3D

func _ready() -> void:
	finished.connect(destroy.bind())
	
func destroy() -> void:
	self.queue_free()
