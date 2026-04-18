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
	no_throw = require("@self/utility/no_throw"),

	null = of_type<<nil>>("nil"),
	string = of_type<<string>>("string"),
	number = of_type<<number>>("number"),
	integer = of_type<<integer>>("integer"),
	boolean = of_type<<boolean>>("boolean"),
	table = of_type<<{ [any]: any }>>("table"),
	func = of_type<<(...any) -> ...any>>("function"),
	thread = of_type<<thread>>("thread"),
	userdata = of_type<<any>>("userdata"),
	vector = of_type<<vector>>("vector"),
	buffer = of_type<<buffer>>("buffer"),

	rbx = require("@self/rbx"),
}
