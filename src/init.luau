const lib = require("@self/lib")
const of_type = lib.of_type

return {
	of_type = lib.of_type,
	of_typeof = lib.of_typeof,
	literal = lib.literal,
	nan = lib.nan,
	any = lib.any,
	all = lib.all,
	negate = lib.negate,
	tuple = lib.tuple,
	coerce = lib.coerce,
	fallback = lib.fallback,
	strict = lib.strict,

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
