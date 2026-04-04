local repr = require("./repr")

local function literal<T>(ltrl: T)
	return function(x: unknown): T
		if x == ltrl then
			return x
		end

		error(`expected value to exactly equal literal {repr(ltrl)}, got {repr(x)}`)
	end
end

return literal
