
function IsValid(var)
	if not var then return end
	if isstring(var) then return end
	local isvalid = var.IsValid
	if not isvalid then return end
	return isvalid(var)
end

ValidEntity = IsValid

