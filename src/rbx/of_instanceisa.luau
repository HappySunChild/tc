local of_typeof = require("../utility/of_typeof")

local Instance = of_typeof("Instance")

local function of_instanceisa<T>(class_name: string)
	return function(x: unknown): (boolean, string?)
		local ok, err = Instance(x)

		if not ok then
			return false, err
		end

		if not (x :: Instance):IsA(class_name) then
			return false, `expected Instance to match or inherit from {class_name}, got {(x :: Instance).ClassName}`
		end

		return true, nil
	end
end

return of_instanceisa
