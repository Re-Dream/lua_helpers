
function IsValid(val)
	if not val then return end
	if isstring(val) then return end
	if isnumber(val) then return end
	local isvalid = val.IsValid
	if not isvalid then return end
	return isvalid(val)
end

ValidEntity = IsValid

