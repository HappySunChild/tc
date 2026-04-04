local function coerce<T>(check: (unknown) -> T, fallback: (unknown) -> T)
	return function(x: unknown): T
		local ok = pcall(check, x)

		return if ok then x else check(fallback(x))
	end
end

return coerce
