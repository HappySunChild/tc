local of_type = require("@self/utility/of_type")

return {
	of_type = of_type,
	of_typeof = require("@self/utility/of_typeof"),
	literal = require("@self/utility/literal"),
	nan = require("@self/utility/nan"),
	any = require("@self/utility/any"),
	all = require("@self/utility/all"),
	negate = require("@self/utility/negate"),
	tuple = require("@self/utility/tuple"),
	coerce = require("@self/utility/coerce"),
	fallback = require("@self/utility/fallback"),
	strict = require("@self/utility/strict"),

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

	rbx = require("@self/rbx"),
}
