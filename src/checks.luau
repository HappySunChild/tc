const repr = require("./repr")

export type check = (...any) -> (boolean, string?)

--- Constructs a new primitive check that passes if the given value is of a certain type using `type`.
const function of_type(type_name: string): check
	return function(x: unknown): (boolean, string?)
		if type(x) ~= type_name then
			return false, `expected value of type {type_name}, got {type(x)} ({repr(x)})`
		end

		return true, nil
	end
end

--- Constructs a new primitive check that passes if the given value is of a certain type using `typeof`.
const function of_typeof(type_name: string): check
	return function(x: unknown): (boolean, string?)
		if typeof(x) ~= type_name then
			return false, `expected value of typeof {type_name}, got {typeof(x)} ({repr(x)})`
		end

		return true, nil
	end
end

--- Constructs a new primitive check that passes if the given value is exactly equal to the given value.
--- This does not account for `nan`, use the `nan` check for that.
const function literal(literal_value: any): check
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

--- Constructs a new primitive check that passes if the given value is `nan`.
const function nan(x: any): (boolean, string?)
	if x == x then
		return false, `expected nan, got {type(x)} {repr(x)}`
	end

	return true, nil
end

return {
	of_type = of_type,
	of_typeof = of_typeof,
	literal = literal,
	nan = nan,
}
