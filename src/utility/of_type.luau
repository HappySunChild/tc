local repr = require("./repr")

local cache: { [string]: (x: unknown) -> (boolean, string?) } = {}

local function of_type(strtype: string)
	local cached_func = cache[strtype]

	if cached_func ~= nil then
		return cached_func
	end

	local function func(x: unknown): (boolean, string?)
		if type(x) ~= strtype then
			return false, `expected value of type {strtype}, got {type(x)} ({repr(x)})`
		end

		return true, nil
	end

	cache[strtype] = func

	return func
end

return of_type
