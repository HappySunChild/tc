local of_type = require("./utility/of_type")

return {
	null = of_type<<nil>>("nil"),
	string = of_type<<string>>("string"),
	number = of_type<<number>>("number"),
	boolean = of_type<<boolean>>("boolean"),
	table = of_type<<table>>("table"),
	func = of_type<<(...any) -> ...any>>("function"),
	thread = of_type<<thread>>("thread"),
	userdata = of_type<<any>>("userdata"),
	vector = of_type<<vector>>("vector"),
	buffer = of_type<<buffer>>("buffer"),
}
