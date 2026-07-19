const types = require("./types")

const function coerce<T...>(check: types.check, coercer: (...any) -> T...): types.policy<T...>
	return function(...: any): T...
		const ok = check(...)

		return if ok then ... else coercer(...)
	end
end

const function fallback<T...>(check: types.check, ...: T...): types.policy<T...>
	const default = { ... }

	return function(...: any): T...
		const ok = check(...)

		return if ok then ... else unpack(default)
	end
end

const function strict<T...>(check: types.check): types.policy<T...>
	return function(...: any): T...
		const ok, err = check(...)

		if not ok then
			error(err, 2)
		end

		return ...
	end
end

return {
	coerce = coerce,
	fallback = fallback,
	strict = strict,
}
