local function tuple(...: (unknown) -> (boolean, string?))
	local checks = { ... }

	return function(...: unknown): (boolean, string?)
		local args = { ... }

		for i, check in checks do
			local ok, err = check(args[i])

			if not ok then
				return false, `invalid tuple value at #{i}:\n\t{err}`
			end
		end

		return true, nil
	end
end

return tuple
