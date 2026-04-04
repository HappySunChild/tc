local of_typeof = require("../utility/of_typeof")

local EnumItem = of_typeof<<EnumItem>>("EnumItem")

local function of_enumtype<T>(enum: T & Enum)
	return function(x: unknown): T
		local x_enumtype = EnumItem(x).EnumType

		if x_enumtype ~= enum then
			error(`expected EnumItem of type {enum}, got {x_enumtype}`)
		end

		return x
	end
end

return of_enumtype
