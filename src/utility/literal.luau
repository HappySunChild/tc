local repr = require("./repr")

local function literal<T>(ltrl: T)
	return function(x: unknown): T
		if x == ltrl then
			return x
		end

		error(`expected value to exactly equal literal {typeof(ltrl)} {repr(ltrl)}, got {typeof(x)} {repr(x)}`, 2)
	end
end

return literal
