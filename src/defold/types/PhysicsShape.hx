package defold.types;

enum PhysicsShape {
	Sphere(diameter:Float);

	Box(dimensions:Vector3);

	Capsule(diameter:Float, height:Float);

	Hull;
}

@:native("_G.physics")
extern enum abstract PhysicsShapeType(Int) {
	@:native('SHAPE_TYPE_SPHERE')
	var Sphere;
	@:native('SHAPE_TYPE_BOX')
	var Box;
	@:native('SHAPE_TYPE_CAPSULE')
	var Capsule;
	@:native('SHAPE_TYPE_HULL')
	var Hull;
}

typedef PhysicsShapeData = {
	var type:PhysicsShapeType;

	var ?diameter:Float;

	var ?height:Float;

	var ?dimensions:Vector3;
}

abstract PhysicsShapeWrapper(PhysicsShapeData) from PhysicsShapeData {
	public function toPhysicsShape():PhysicsShape {
		return switch (this.type) {
			case Sphere: PhysicsShape.Sphere(this.diameter);
			case Box: PhysicsShape.Box(this.dimensions);
			case Capsule: PhysicsShape.Capsule(this.diameter, this.height);
			case Hull: PhysicsShape.Hull;
		}
	}

	public static function fromPhysicsShape(shape:PhysicsShape):PhysicsShapeData {
		return switch (shape) {
			case Sphere(diameter): {type: PhysicsShapeType.Sphere, diameter: diameter};
			case Box(dimensions): {type: PhysicsShapeType.Box, dimensions: dimensions};
			case Capsule(diameter, height): {type: PhysicsShapeType.Sphere, diameter: diameter, height: height};
			case Hull: {type: PhysicsShapeType.Hull};
		}
	}
}
