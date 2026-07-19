const of_typeof = require("../checks").of_typeof

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

return {
	of_instancetype = of_instancetype,
	of_instanceisa = of_instanceisa,
	of_enumtype = of_enumtype,
}
