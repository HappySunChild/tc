const repr = require("./repr")

const checks = require("./checks")
const of_type = checks.of_type

const validate_table = of_type("table")

const function array(element_check: checks.check): checks.check
	return function(x: any): (boolean, string?)
		const t_ok, t_err = validate_table(x)

		if not t_ok then
			return false, t_err
		end

		const count = #x
		const is_mixed = next(x, if count > 0 then count else nil) ~= nil

		if is_mixed then
			return false, "expected array value, got mixed table"
		end

		for index, element in x do
			const ok, err = element_check(element)

			if not ok then
				return false, `invalid array element at index {index};\n\t{err}`
			end
		end

		return true, nil
	end
end

const function map(key_check: checks.check, value_check: checks.check): checks.check
	return function(x: any): (boolean, string?)
		const t_ok, t_err = validate_table(x)

		if not t_ok then
			return false, t_err
		end

		for key, value in x do
			const ok_key, err_key = key_check(key)

			if not ok_key then
				return false, `invalid key in map;\n\t{err_key}`
			end

			const ok_value, err_value = value_check(value)

			if not ok_value then
				return false, `invalid value in map at key {repr(key)};\n\t{err_value}`
			end
		end

		return true, nil
	end
end

const function struct(shape: { [any]: checks.check }): checks.check
	return function(x: any): (boolean, string?)
		const t_ok, t_err = validate_table(x)

		if not t_ok then
			return false, t_err
		end

		for key, validate in shape do
			const ok, err = validate(x[key])

			if not ok then
				return false, `invalid value at key {repr(key)};\n\t{err}`
			end
		end

		return true, nil
	end
end

const function tuple(...: checks.check): checks.check
	const checks = { ... }

	return function(...: any): (boolean, string?)
		const args = { ... }

		for index, check in checks do
			const ok, err = check(args[index])

			if not ok then
				return false, `invalid tuple value at #{index}:\n\t{err}`
			end
		end

		return true, nil
	end
end

return {
	array = array,
	map = map,
	struct = struct,
	tuple = tuple,
}
