
local tag = "webmaterial"

if not file.IsDir(tag, "DATA") then
	file.CreateDir(tag)
end

local cache = {}
local function FetchWebMaterial(name, url)
	http.Fetch(url, function(data, len, _, err)
		file.Write(tag .. "/" .. name .. ".png", data)

		local mat = Material("../data/" .. tag .. "/" .. name .. ".png")

		if not mat or mat:IsError() then
			Msg"[WebMaterial] "print("Downloaded material, but it's an error: ", name)
			return
		end

		cache[name] = mat
	end, function(err)
		Msg"[WebMaterial] "print("HTTP fetch failed for ", url, ": " .. tostring(err))
	end)
end

local fallback = Material("models/debug/debugwhite")
function WebMaterial(name, url, callback)
	if not file.Exists(tag .. "/" .. name .. ".png", "DATA") then
		FetchWebMaterial(name, url)
	else
		local mat = Material("../data/" .. tag .. "/" .. name .. ".png")

		if not mat or mat:IsError() then
			Msg"[WebMaterial] "print("Material found, but it's an error: ", name, ", redownloading")
			FetchWebMaterial(name, url)
		else
			cache[name] = mat
		end
	end
	local c = cache[name]
	c = (not c or c:IsError()) and fallback or c
	if isfunction(callback) then
		callback(name, url, c)
	end
	return c or fallback
end

