const types = require("./types")
const repr = require("./repr")

const function of_type(type_name: string): types.check
	return function(x: unknown): (boolean, string?)
		if type(x) ~= type_name then
			return false, `expected value of type {type_name}, got {type(x)} ({repr(x)})`
		end

		return true, nil
	end
end

const function of_typeof(type_name: string): types.check
	return function(x: unknown): (boolean, string?)
		if typeof(x) ~= type_name then
			return false, `expected value of typeof {type_name}, got {typeof(x)} ({repr(x)})`
		end

		return true, nil
	end
end

const function literal(literal_value: any): types.check
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

return {
	of_type = of_type,
	of_typeof = of_typeof,
	literal = literal,
	nan = nan,
}
