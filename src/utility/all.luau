local function all<T>(...: (any) -> (boolean, string?))
	local checks = { ... }

	return function(x: unknown): (boolean, string?)
		local fails = {}

		for _, check in checks do
			local ok, err = check(x)

			if not ok then
				table.insert(fails, err)
			end
		end

		if #fails > 0 then
			return false, `expected value to meet all checks:\n\t{table.concat(fails, "\n\t")}`
		end

		return true, nil
	end
end

return all
