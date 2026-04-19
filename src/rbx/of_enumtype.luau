local of_typeof = require("../utility/of_typeof")

local EnumItem = of_typeof("EnumItem")

local function of_enumtype(enum: Enum)
	return function(x: unknown): (boolean, string?)
		local ok, err = EnumItem(x)

		if not ok then
			return false, err
		end

		if (x :: EnumItem).EnumType ~= enum then
			return false, `expected EnumItem of type {enum}, got {x.EnumType}`
		end

		return true, nil
	end
end

return of_enumtype
