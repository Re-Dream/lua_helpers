
local tag = "crashprotection"

local t = SysTime
crashprotection = crashprotection or {}

crashprotection.MaxExecTime = 10
crashprotection.InstructionInterval = 2^24

crashprotection.LastChecked = t()

do
	local hookFunc = function()
		if t() - crashprotection.LastChecked > crashprotection.MaxExecTime then
			error("Infinite loop detected!", 2)
		end
	end

	hook.Add("Think", tag, function()
		crashprotection.LastChecked = t()
		debug.sethook(hookFunc, "", crashprotection.InstructionInterval)
	end)
end

do return end
-- causes issues with starfall

if CLIENT then
	crashprotection.Cams = crashprotection.Cams or {}
	crashprotection.Backup = crashprotection.Backup or {}

	local cams = {
		["3D2D"]  = { cam.Start3D2D, cam.End3D2D, 0 },
		["3D"]    = { cam.Start3D, cam.End3D, 0 },
		["2D"]    = { cam.Start2D, cam.End2D, 0 },
		[""]      = { cam.Start, cam.End, 2 },
	}

	for n, f in pairs(cams) do
		crashprotection.Cams[n] = crashprotection.Cams[n] or 0
		crashprotection.Backup[n] = crashprotection.Backup[n] or f

		cam["Start" .. n] = function(...)
			crashprotection.Cams[n] = crashprotection.Cams[n] + 1
			return crashprotection.Backup[n][1](...)
		end

		cam["End" .. n] = function(...)
			if crashprotection.Cams[n] <= crashprotection.Backup[n][3] then
				collectgarbage()
				error("cam.End" .. n .. " called before cam.Start" .. n, 2)
			end

			crashprotection.Cams[n] = crashprotection.Cams[n] - 1
			return crashprotection.Backup[n][2](...)
		end
	end
end

