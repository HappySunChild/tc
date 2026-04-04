local function all<T>(...: (any) -> T)
	local checks = { ... }

	return function(x: unknown): T
		local fails = {}

		for _, check in checks do
			local ok, err: string = pcall(check, x)

			if not ok then
				table.insert(fails, err)
			end
		end

		if #fails > 0 then
			error(`expected value to meet all checks:\n\t{table.concat(fails, "\n\t")}`, 2)
		end

		return x
	end
end

return all
