local function any<T>(...: (unknown) -> T)
	local checks = { ... }

	return function(x: unknown): T
		local fails = {}

		for _, check in checks do
			local ok, err: string = pcall(check, x)

			if ok then
				return x
			end

			table.insert(fails, err)
		end

		error(`expected value to meet atleast one check:\n\t{table.concat(fails, "\n\t")}`, 2)
	end
end

return any
