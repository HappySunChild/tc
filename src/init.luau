const checks = require("@self/checks")
const combinators = require("@self/combinators")
const policies = require("@self/policies")
const structural = require("@self/structural")

const of_type = checks.of_type

return {
	of_type = checks.of_type,
	of_typeof = checks.of_typeof,
	literal = checks.literal,
	nan = checks.nan,

	any = combinators.any,
	all = combinators.all,
	negate = combinators.negate,

	array = structural.array,
	map = structural.map,
	struct = structural.struct,
	tuple = structural.tuple,

	coerce = policies.coerce,
	fallback = policies.fallback,
	strict = policies.strict,

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
