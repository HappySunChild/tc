local of_typeof = require("../utility/of_typeof")

local Instance = of_typeof("Instance")

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

return of_instancetype
