--- @class ValidateSpec
--- @field [1] any
--- @field [2] vim.validate.Validator
--- @field [3]? boolean
--- @field [4]? string

local _unpack = unpack or table.unpack

--- Checks and validation wrappers.
---
--- @class FzfNerdfont.Check
local FzfNerdCheck = {}

--- @param spec table<string, vim.validate.Spec>
local function legacy_validate(spec)
    vim.validate(spec)
end

--- @param T table<string, vim.validate.Spec|ValidateSpec>
function FzfNerdCheck.validate(T)
    if vim.fn.has("nvim-0.11") ~= 1 then
        ---@cast T table<string, vim.validate.Spec>
        legacy_validate(T)
        return
    end

    ---@cast T table<string, ValidateSpec>
    for name, spec in pairs(T) do
        vim.validate(name, _unpack(spec))
    end
end

return FzfNerdCheck
