local repr = require("./repr")

local cache: { [any]: (x: unknown) -> (boolean, string?) } = {}

local function literal<T>(ltrl: T)
	local cached_func = cache[ltrl]

	if cached_func ~= nil then
		return cached_func
	end

	local function func(x: unknown): (boolean, string?)
		if x == ltrl then
			return true, nil
		end

		return false, `expected value to exactly equal literal {typeof(ltrl)} {repr(ltrl)}, got {typeof(x)} {repr(x)}`
	end

	cache[ltrl] = func

	return func
end

return literal
