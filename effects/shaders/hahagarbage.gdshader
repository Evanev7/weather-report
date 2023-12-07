shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (COLOR.r == 0. && COLOR.g == 0. && COLOR.b == 0.) {
		COLOR.a = 0.;
	}
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
