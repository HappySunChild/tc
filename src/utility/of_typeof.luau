local repr = require("./repr")

local function of_typeof<T>(strtype: string)
	return function(x: unknown): T
		if typeof(x) ~= strtype then
			error(`expected value of typeof {strtype}, got {type(x)} ({repr(x)})`, 2)
		end

		return x
	end
end

return of_typeof
