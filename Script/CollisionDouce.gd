extends Area2D

func _en_collision():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func _recup_vecteur_pousse():
	var areas = get_overlapping_areas()
	var vecteur_pousse = Vector2.ZERO
	if _en_collision():
		var area = areas[0]
		vecteur_pousse = area.global_position.direction_to(global_position)
		vecteur_pousse = vecteur_pousse.normalized()
	return vecteur_pousse
