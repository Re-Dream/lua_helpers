
if CLIENT then
	function cmd(cmd)
		LocalPlayer():ConCommand(cmd)
	end

	function Say(...)
		local first = true
		local msg = ""
		for _, v in pairs({...}) do
			if first then
				first = false
			else
				msg = msg .. " "
			end
			msg = msg .. tostring(v)
		end
		msg = msg:gsub("\n", ""):gsub(";", ":"):gsub("\"", "'")
		cmd("say " .. msg)
	end
	say = Say
elseif SERVER then
	local serverFrameTime = engine.ServerFrameTime
	local ok
	if not serverFrameTime then
		ok = pcall(require, "fps")
		serverFrameTime = engine.RealFrameTime
	else
		ok = true
	end
	if ok then
		hook.Add("Think", "serverfps", function()
			SetGlobalInt("serverfps", 1 / serverFrameTime())
		end)
	end

	function cmd(cmd)
		game.ConsoleCommand(cmd .. "\n")
	end

	function Say(...)
		local first = true
		local msg = ""
		for _, v in pairs({...}) do
			if first then
				first = false
			else
				msg = msg .. " "
			end
			msg = msg .. tostring(v)
		end
		msg = msg:gsub("\n", ""):gsub(";", ":"):gsub("\"", "'")
		cmd("say " .. msg)
	end
	say = Say
end

function engine.ServerFPS()
	return GetGlobalInt("serverfps")
end

function debug.getupvalues(func)
	local info = debug.getinfo(func)
	local ups = {}
	for i = 1, info.nups do
		ups[#ups + 1] = { debug.getupvalue(func, i) }
	end
	return ups
end

function debug.getparams(func)
	return debug.getinfo(func).nparams
end

