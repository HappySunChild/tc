local function coerce<T>(check: (unknown) -> (boolean, string?), fallback: (unknown) -> T)
	return function(x: unknown): T
		local ok = check(x)

		return if ok then x else fallback(x)
	end
end

return coerce
