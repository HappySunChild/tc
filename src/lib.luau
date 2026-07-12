const repr = require("./repr")

const function of_type(type_name: string): (any) -> (boolean, string?)
	return function(x: unknown): (boolean, string?)
		if type(x) ~= type_name then
			return false, `expected value of type {type_name}, got {type(x)} ({repr(x)})`
		end

		return true, nil
	end
end

const function of_typeof(type_name: string): (any) -> (boolean, string?)
	return function(x: unknown): (boolean, string?)
		if typeof(x) ~= type_name then
			return false, `expected value of typeof {type_name}, got {typeof(x)} ({repr(x)})`
		end

		return true, nil
	end
end

const function literal(literal_value: any): (any) -> (boolean, string?)
	return function(x: unknown): (boolean, string?)
		if x ~= literal_value then
			return false,
				`expected value to exactly equal literal {typeof(literal_value)} {repr(literal_value)}, got {typeof(x)} {repr(
					x
				)}`
		end

		return true, nil
	end
end

const function nan(x: any): (boolean, string?)
	if x == x then
		return false, `expected nan, got {type(x)} {repr(x)}`
	end

	return true, nil
end

const function tuple(...: (any) -> (boolean, string?)): (...any) -> (boolean, string?)
	const checks = { ... }

	return function(...: any): (boolean, string?)
		const args = { ... }

		for i, check in checks do
			const ok, err = check(args[i])

			if not ok then
				return false, `invalid tuple value at #{i}:\n\t{err}`
			end
		end

		return true, nil
	end
end

const function any(...: (...any) -> (boolean, string?)): (...any) -> (boolean, string?)
	const checks = { ... }

	return function(...: any): (boolean, string?)
		const fails = {}

		for _, check in checks do
			const ok, err = check(...)

			if ok then
				return true, nil
			end

			table.insert(fails, err)
		end

		const formatted_fails = string.gsub(table.concat(fails, "\n"), "\n", "\n\t")

		return false, `expected value to meet atleast one check:\n\t{formatted_fails}`
	end
end

const function all(...: (any) -> (boolean, string?)): (...any) -> (boolean, string?)
	const checks = { ... }

	return function(...: any): (boolean, string?)
		const fails = {}

		for _, check in checks do
			const ok, err = check(...)

			if not ok then
				table.insert(fails, err)
			end
		end

		if #fails > 0 then
			const formatted_fails = string.gsub(table.concat(fails, "\n"), "\n", "\n\t")

			return false, `expected value to meet all checks:\n\t{formatted_fails}`
		end

		return true, nil
	end
end

const function negate(check: (...any) -> (boolean, string?), label: string?): (...any) -> (boolean, string?)
	label = label or "provided check"

	return function(...: any): (boolean, string?)
		const ok = check(...)

		if ok then
			return false, `expected opposite of {label}`
		end

		return true, nil
	end
end

const function coerce<T...>(check: (...any) -> (boolean, string?), coercer: (...any) -> T...): (...any) -> T...
	return function(...: any): T...
		const ok = check(...)

		return if ok then ... else coercer(...)
	end
end

const function fallback<T...>(check: (...any) -> (boolean, string?), ...: T...): (...any) -> T...
	const default = { ... }

	return function(...: any): T...
		const ok = check(...)

		return if ok then ... else unpack(default)
	end
end

const function strict<T...>(check: (any) -> (boolean, string?)): (...any) -> T...
	return function(...: any): T...
		const ok, err = check(...)

		if not ok then
			error(err, 2)
		end

		return ...
	end
end

return {
	of_type = of_type,
	of_typeof = of_typeof,
	literal = literal,
	nan = nan,
	tuple = tuple,

	any = any,
	all = all,

	negate = negate,

	coerce = coerce,
	fallback = fallback,

	strict = strict,
}
