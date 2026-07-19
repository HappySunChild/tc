# tc
A successor to the ubiquitous [`t`](https://github.com/osyrisrblx/t) module.

This module is a collection of useful and simple utility functions for easily performing runtime type checks.
Also comes with some Roblox specific utility functions that can be accessed via the `rbx` module.


## Example Usage
> [!NOTE]
> It is recommended that you cache the resulting derived callbacks returned by functions in this module to avoid creating redundant closures repeatedly.

```luau
const tc = require("tc")

const string_or_number = tc.any(tc.string, tc.number)

assert(string_or_number(1))
assert(string_or_number("hello"))
assert(string_or_number({ "a string within a table", "of strings" })) --[[ throws with message:
	expected value to meet atleast one check:
			expected value of type string, got table ({ ... } (table: 0x0000029388e96cd0))
			expected value of type number, got table ({ ... } (table: 0x0000029388e96cd0))
]]

```

### Roblox Example
```luau
const ReplicatedStorage = game:GetService("ReplicatedStorage")

const tc = require(ReplicatedStorage.tc)
const tc_rbx = require(ReplicatedStorage.tc.rbx)

local only_materials_and_numbers = tc.any(tc_rbx.of_enumtype(Enum.Material), tc.number)

assert(only_materials_and_numbers(123))
assert(only_materials_and_numbers(Enum.Material.Air))
```

## Strictness Disclaimer
By default `tc` does **not** error during runtime type mismatches, instead opting to return a boolean
along with an error string explaining why it failed. Because of this you can simply plug your typechecker
directly into an `assert` call for a simple and clean "strict" typecheck (as shown in the examples above).

`tc` also provides a `strict` policy which essentially does the assert check for you, while also
returning the value given to it. While this isn't generally useful it can be used in some
clever ways like so:

```luau
const tc = require("tc")

const strict_number = tc.strict(tc.number)

const function create_thing(value: any)
	return {
		value = strict_number(value),
	}
end

create_thing(1337)
create_thing("not a number") -- throws: expected value of type number, got string ("not a number")
```