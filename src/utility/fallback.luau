local function fallback<T>(check: (unknown) -> (boolean, string?), default: T)
	return function(x: unknown): T
		local ok = check(x)

		return if ok then x else default
	end
end

return fallback
