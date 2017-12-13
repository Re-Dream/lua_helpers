
function string.urlencode(str)
	if str then
		str = str:gsub("\n", "\r\n")
		str = str:gsub("([^%w ])",
			function(c) return string.format("%%%02X", string.byte(c)) end
		)
		str = str:gsub(" ", "+")
	end
	return str
end

