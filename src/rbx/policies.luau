const checks = require("../checks")
const policies = require("../policies")

--- Constructs a new policy similar to `strict`, but instead logs a warning and returns `nil`.
const function as_warn<T...>(check: checks.check): policies.policy
	return function(...: any): ...any
		const ok, err = check(...)

		if not ok then
			warn(err)

			return nil
		end

		return ...
	end
end

return {
	as_warn = as_warn,
}
