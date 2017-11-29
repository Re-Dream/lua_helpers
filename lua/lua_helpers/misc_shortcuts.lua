
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
	if not engine.ServerFrameTime then
		require("fps") -- this is probably causing heap corruption
	end
	hook.Add("Think", "serverfps", function()
		SetGlobalInt("serverfps", 1 / engine.ServerFrameTime and engine.ServerFrameTime() or engine.RealFrameTime())
	end)

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

