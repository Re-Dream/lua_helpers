
local tag = "sv_gui_openurl"

if SERVER then
	util.AddNetworkString(tag)

	local PLAYER = FindMetaTable("Player")

	function PLAYER:OpenURL(url)
		net.Start(tag)
			net.WriteString(url)
		net.Send(self)
	end
end

if CLIENT then
	net.Receive(tag, function()
		local str = net.ReadString()

		EasyChat.OpenURL(str)
	end)
end

