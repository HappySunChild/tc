const function as_warn<T>(check: (x: unknown) -> T)
	return function(x: unknown): T?
		const ok, err = pcall(check, x)

		if not ok then
			warn(err)

			return nil
		end

		return x
	end
end

return {
	as_warn = as_warn,
}
