local function tuple<T...>(...: (unknown) -> unknown)
	local checks = { ... }

	return function(...: unknown): T...
		local args = { ... }

		for i, check in checks do
			local ok, err = pcall(check, args[i])
			if not ok then
				error(`invalid tuple value at #{i}:\n\t{err}`)
			end
		end

		return ... :: any
	end
end

return tuple
