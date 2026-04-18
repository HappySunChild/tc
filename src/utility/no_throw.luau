local function no_throw<T>(check: (unknown) -> T)
	return function(x: unknown): (boolean, T | string?)
		return pcall(check, x)
	end
end

return no_throw
