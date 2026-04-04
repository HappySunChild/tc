local of_typeof = require("../utility/of_typeof")

local Instance = of_typeof<<Instance>>("Instance")

local function of_instancetype<T>(class_name: string)
	return function(x: unknown): T
		local x_class = Instance(x).ClassName

		if x_class ~= class_name then
			error(`expected Instance of class {class_name}, got {x_class}`)
		end

		return x
	end
end

return of_instancetype
