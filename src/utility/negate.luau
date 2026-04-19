local repr = require("./repr")

type function neg(t: type)
	return types.negationof(t)
end

local function negate(check: (unknown) -> (boolean, string?), label: string?)
	label = label or "provided check"
	return function(x: unknown): (boolean, string?)
		local ok = pcall(check, x)

		if ok then
			return false, `expected opposite of {label}, got {typeof(x)} ({repr(x)})`
		end

		return true, nil
	end
end

return negate
