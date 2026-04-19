local function strict<T>(check: (x: T) -> (boolean, string?))
	return function(x: unknown): T
		local ok, err = check(x)

		if not ok then
			error(err, 2)
		end

		return x
	end
end

return strict
