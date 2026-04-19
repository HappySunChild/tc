local function any<T>(...: (unknown) -> (boolean, string?))
	local checks = { ... }

	return function(x: unknown): (boolean, string?)
		local fails = {}

		for _, check in checks do
			local ok, err = check(x)

			if ok then
				return true, nil
			end

			table.insert(fails, err)
		end

		return false, `expected value to meet atleast one check:\n\t{table.concat(fails, "\n\t")}`
	end
end

return any
