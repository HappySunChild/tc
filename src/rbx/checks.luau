const checks = require("../checks")
const of_typeof = checks.of_typeof

const Instance = of_typeof("Instance")
const EnumItem = of_typeof("EnumItem")

--- Constructs a new check that passes if the provided value is an `Instance` with a `ClassName` equal to `class_name`.
local function of_instancetype<T>(class_name: string): checks.check
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

--- Constructs a new check that passes if the provided value is an `Instance` that is of/inherits from `class_name`.
const function of_instanceisa<T>(class_name: string): checks.check
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

--- Constructs a new check that passes if the provided value is an `EnumItem` that is of the provided `Enum` type (e.g. Enum.Material).
const function of_enumtype(enum: Enum): checks.check
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

return {
	of_instancetype = of_instancetype,
	of_instanceisa = of_instanceisa,
	of_enumtype = of_enumtype,
}
