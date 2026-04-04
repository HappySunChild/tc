local of_typeof = require("../utility/of_typeof")

local EnumItem = of_typeof<<EnumItem>>("EnumItem")

local function of_enumtype(enum: Enum)
	return function(x: unknown): EnumItem
		local x_enumtype = EnumItem(x).EnumType

		if x_enumtype ~= enum then
			error(`expected EnumItem of type {enum}, got {x_enumtype}`, 2)
		end

		return x :: EnumItem
	end
end

return of_enumtype
