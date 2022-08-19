local M = {}

M.contains = function(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

return M
