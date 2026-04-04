local repr = require("./repr")

local function nan(x: unknown): number
	if x ~= x then
		error(`expected nan, got {type(x)} {repr(x)}`, 2)
	end

	return x :: number
end

return nan
