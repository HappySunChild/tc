local repr = require("./repr")

type function neg(t: type)
	return types.negationof(t)
end

local function negate<T>(check: (unknown) -> T, label: string?)
	label = label or "provided check"
	return function(x: unknown): neg<T>
		local ok = pcall(check, x)

		if ok then
			local lang_type = type(x)
			local ext_type = typeof(x)

			local display_type = if ext_type ~= lang_type then `{lang_type} ({ext_type})` else lang_type

			error(`expected opposite of {label}, got {display_type} ({repr(x)})`)
		end

		return x :: any
	end
end

return negate
