local function repr(x: unknown): string
	local x_type = type(x)

	if x_type == "string" then
		return `"{x}"`
	elseif x_type == "function" then
		local argc, variadic, name = debug.info(x :: () -> (), "an")
		local args = {}

		for i = 1, argc do
			table.insert(args, `a{i}`)
		end

		if variadic then
			table.insert(args, "...")
		end

		return `function {name or ""}({table.concat(args, ", ")})`
	elseif x_type == "table" then
		return `\{ ... } ({x})`
	end

	return tostring(x)
end

return repr
