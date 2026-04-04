local repr = require("./repr")

type function neg(t: type)
	return types.negationof(t)
end

local function negate<T>(check: (unknown) -> T, label: string?)
	label = label or "provided check"
	return function(x: unknown): neg<T>
		local ok = pcall(check, x)

		if ok then
			error(`expected opposite of {label}, got {typeof(x)} ({repr(x)})`, 2)
		end

		return x :: any
	end
end

return negate
