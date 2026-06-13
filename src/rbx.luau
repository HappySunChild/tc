const funcs = require("./funcs")
const of_typeof = funcs.of_typeof

const Instance = of_typeof("Instance")
const EnumItem = of_typeof("EnumItem")

local function of_instancetype<T>(class_name: string)
	return function(x: unknown): (boolean, string?)
		local ok, err = Instance(x)

		if not ok then
			return false, err
		end

		local x_class = (x :: Instance).ClassName

		if x_class ~= class_name then
			return false, `expected Instance of class {class_name}, got {x_class}`
		end

		return true, nil
	end
end

const function of_instanceisa<T>(class_name: string)
	return function(x: unknown): (boolean, string?)
		const ok, err = Instance(x)

		if not ok then
			return false, err
		end

		if not (x :: Instance):IsA(class_name) then
			return false, `expected Instance to match or inherit from {class_name}, got {(x :: Instance).ClassName}`
		end

		return true, nil
	end
end

const function of_enumtype(enum: Enum)
	return function(x: unknown): (boolean, string?)
		const ok, err = EnumItem(x)

		if not ok then
			return false, err
		end

		if (x :: EnumItem).EnumType ~= enum then
			return false, `expected EnumItem of type {enum}, got {x.EnumType}`
		end

		return true, nil
	end
end

const function as_warn<T>(check: (x: unknown) -> T)
	return function(x: unknown): T?
		const ok, err = pcall(check, x)

		if not ok then
			warn(err)

			return nil
		end

		return x
	end
end

return {
	of_instancetype = of_instancetype,
	of_instanceisa = of_instanceisa,
	of_enumtype = of_enumtype,
	as_warn = as_warn,

	Axes = of_typeof("Axes"),
	BrickColor = of_typeof("BrickColor"),
	CatalogSearchParams = of_typeof("CatalogSearchParams"),
	CFrame = of_typeof("CFrame"),
	Color3 = of_typeof("Color3"),
	ColorSequence = of_typeof("ColorSequence"),
	ColorSequenceKeypoint = of_typeof("ColorSequenceKeypoint"),
	Content = of_typeof("Content"),
	DateTime = of_typeof("DateTime"),
	DockWidgetPluginGuiInfo = of_typeof("DockWidgetPluginGuiInfo"),
	Enum = of_typeof("Enum"),
	EnumItem = of_typeof("EnumItem"),
	Enums = of_typeof("Enums"),
	Faces = of_typeof("Faces"),
	FloatCurveKey = of_typeof("FloatCurveKey"),
	Font = of_typeof("Font"),
	Instance = of_typeof("Instance"),
	NumberRange = of_typeof("NumberRange"),
	NumberSequence = of_typeof("NumberSequence"),
	NumberSequenceKeypoint = of_typeof("NumberSequenceKeypoint"),
	OverlapParams = of_typeof("OverlapParams"),
	Path2DControlPoint = of_typeof("Path2DControlPoint"),
	PathWaypoint = of_typeof("PathWaypoint"),
	PhysicalProperties = of_typeof("PhysicalProperties"),
	Random = of_typeof("Random"),
	Ray = of_typeof("Ray"),
	RaycastParams = of_typeof("RaycastParams"),
	RaycastResult = of_typeof("RaycastResult"),
	RBXScriptConnection = of_typeof("RBXScriptConnection"),
	RBXScriptSignal = of_typeof("RBXScriptSignal"),
	Rect = of_typeof("Rect"),
	Region3 = of_typeof("Region3"),
	Region3int16 = of_typeof("Region3int16"),
	RotationCurveKey = of_typeof("RotationCurveKey"),
	Secret = of_typeof("Secret"),
	SecurityCapabilities = of_typeof("SecurityCapabilities"),
	SharedTable = of_typeof("SharedTable"),
	TweenInfo = of_typeof("TweenInfo"),
	UDim = of_typeof("UDim"),
	UDim2 = of_typeof("UDim2"),
	ValueCurveKey = of_typeof("ValueCurveKey"),
	Vector2 = of_typeof("Vector2"),
	Vector2int16 = of_typeof("Vector2int16"),
	Vector3 = of_typeof("Vector3"),
	Vector3int16 = of_typeof("Vector3int16"),
}
