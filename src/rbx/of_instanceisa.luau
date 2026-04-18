local of_typeof = require("../utility/of_typeof")

local Instance = of_typeof<<Instance>>("Instance")

local function of_instancetype<T>(class_name: string)
	return function(x: unknown): T
		local x_instance = Instance(x)

		if not x_instance:IsA(class_name) then
			error(`expected Instance to match or inherit from {class_name}, got {x_instance.ClassName}`, 2)
		end

		return x
	end
end

return of_instancetype
