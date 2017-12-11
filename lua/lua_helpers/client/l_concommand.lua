
concommand.Add("l", function(_, _, _, line)
	luadev.RunOnSelf(line)
end, function(_, line)
	local ok = CompileString(line, "concommand_l", false)

	return type(ok) == "function" and { line } or { ok }
end)

