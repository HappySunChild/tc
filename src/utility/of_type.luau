local repr = require("./repr")

local function of_type<T>(strtype: string)
	return function(x: unknown): T
		if type(x) ~= strtype then
			error(`expected value of type {strtype}, got {type(x)} ({repr(x)})`, 2)
		end

		return x
	end
end

return of_type
