const checks = require("./checks")

const function any(...: checks.check): checks.check
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

const function all(...: checks.check): checks.check
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

const function negate(check: checks.check, label: string?): checks.check
	label = label or "provided check"

	return function(...: any): (boolean, string?)
		const ok = check(...)

		if ok then
			return false, `expected opposite of {label}`
		end

		return true, nil
	end
end

return {
	any = any,
	all = all,
	negate = negate,
}
