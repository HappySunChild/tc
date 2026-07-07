type Pair = { key: string, value: string }

const FULL_TABLE_PRINTOUT = false

const function render_table_pairs(pairs: { Pair }, depth: number)
	if #pairs == 0 then
		return "{}"
	end

	const outer_indent = string.rep("\t", depth)
	const inner_indent = string.rep("\t", depth + 1)

	const lines = { "{" }

	for _, pair in pairs do
		table.insert(lines, `{inner_indent}[{pair.key}] = {pair.value},`)
	end

	table.insert(lines, outer_indent .. "}")

	return table.concat(lines, "\n")
end

const function repr(x: unknown): string
	const x_type = type(x)

	if x_type == "string" then
		return `"{x}"`
	elseif x_type == "function" then
		const arg_count: number, variadic: boolean, name: string? = debug.info(x :: () -> (), "an")
		const display_args = {}

		for i = 1, arg_count do
			table.insert(display_args, `a{i}`)
		end

		if variadic then
			table.insert(display_args, "...")
		end

		return `function {name or ""}({table.concat(display_args, ", ")})`
	elseif x_type == "table" then
		if not FULL_TABLE_PRINTOUT then
			return `\{ ... } ({x})`
		end

		const active: { [any]: number } = {}

		const function recursive(current: any, depth: number): string
			if type(current) ~= "table" then
				return repr(current)
			end

			if active[current] ~= nil then
				return `[ RECURSIVE +{depth - active[current] - 1} ]`
			end

			active[current] = depth

			const ordered_pairs: { Pair } = {}

			for key, value in current do
				table.insert(ordered_pairs, {
					key = recursive(key, depth + 1),
					value = recursive(value, depth + 1),
				})
			end

			table.sort(ordered_pairs, function(a: Pair, b: Pair)
				return a.key < b.key
			end)

			local output = render_table_pairs(ordered_pairs, depth)
			const metatable = getmetatable(current) :: any

			if metatable then
				output = `setmetatable({output}, {recursive(metatable, depth)})`
			end

			if table.isfrozen(current) then
				output = `table.freeze({output})`
			end

			active[current] = nil

			return output
		end

		return recursive(x, 0)
	end

	return tostring(x)
end

return repr
