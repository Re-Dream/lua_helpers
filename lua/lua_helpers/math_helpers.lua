
local VECTOR = FindMetaTable("Vector")

function math.between(x, a, b)
	return x >= a and x <= b or x >= b and x <= a
end
function VECTOR:WithinBox(a, b) -- different than WithinAABox
	return 	math.between(self.x, a.x, b.x) and
			math.between(self.y, a.y, b.y) and
			math.between(self.z, a.z, b.z)
end

