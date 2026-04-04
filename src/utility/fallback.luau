local function fallback<T>(check: (unknown) -> T, default: T)
	return function(x: unknown): T
		local ok = pcall(check, x)

		return if ok then x else default
	end
end

return fallback
