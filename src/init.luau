const funcs = require("@self/funcs")
const of_type = funcs.of_type

return {
	of_type = funcs.of_type,
	of_typeof = funcs.of_typeof,
	literal = funcs.literal,
	nan = funcs.nan,
	any = funcs.any,
	all = funcs.all,
	negate = funcs.negate,
	tuple = funcs.tuple,
	coerce = funcs.coerce,
	fallback = funcs.fallback,
	strict = funcs.strict,

	-- primitive language types
	null = of_type("nil"),
	string = of_type("string"),
	number = of_type("number"),
	integer = of_type("integer"),
	boolean = of_type("boolean"),
	table = of_type("table"),
	func = of_type("function"),
	thread = of_type("thread"),
	userdata = of_type("userdata"),
	vector = of_type("vector"),
	buffer = of_type("buffer"),
}
