local function AutoComplete( cmd, stringargs )
	local ok,no = CompileString(stringargs,"yes",false)
	
	return type(ok)=="function" and {stringargs} or {ok}
end

concommand.Add("l", function(_,_,_,line) 
	luadev.RunOnSelf(line) 
end, AutoComplete)
