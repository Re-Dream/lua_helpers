
local tag = "player_notify"

if SERVER then
	util.AddNetworkString(tag)

	local PLAYER = FindMetaTable("Player")

	function PLAYER:Notify(txt, typ, len, snd)
		net.Start(tag)
			net.WriteString(txt)
			net.WriteUInt  (typ, 2)
			net.WriteUInt  (len, 16)
			net.WriteString(snd or "")
		net.Send(self)
	end

	function Notify(txt, typ, len, snd)
		net.Start(tag)
			net.WriteString(txt)
			net.WriteUInt  (typ, 2)
			net.WriteUInt  (len, 16)
			net.WriteString(snd or "")
		net.Broadcast()
	end
end

if CLIENT then
	net.Receive(tag, function()
		local txt = net.ReadString()
		local typ = net.ReadUInt  (2)
		local len = net.ReadUInt  (16)
		local snd = net.ReadString()

		notification.AddLegacy(txt, typ, len)
		if snd:Trim() ~= "" then
			surface.PlaySound(snd)
		end
	end)
end

