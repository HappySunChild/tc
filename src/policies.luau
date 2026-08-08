const checks = require("./checks")

export type policy<T... = ...any> = (...any) -> T...

--- Constructs a new policy that returns the result of `coercer` if the provided `check` does not pass.
const function coerce<T...>(check: checks.check, coercer: (...any) -> T...): policy<T...>
	return function(...: any): T...
		const ok = check(...)

		return if ok then ... else coercer(...)
	end
end

--- Constructs a new policy that returns the provided fallback values if the provided `check` does not pass.
const function fallback<T...>(check: checks.check, ...: T...): policy<T...>
	const default = { ... }

	return function(...: any): T...
		const ok = check(...)

		return if ok then ... else unpack(default)
	end
end

--- Constructs a new policy that throws an error if the provided `check` does not pass.
const function strict<T...>(check: checks.check): policy<T...>
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
