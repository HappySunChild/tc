local repr = require("./repr")

local function nan(x: unknown): (boolean, string?)
	if x ~= x then
		return false, `expected nan, got {type(x)} {repr(x)}`
	end

	return true, nil
end

return nan
