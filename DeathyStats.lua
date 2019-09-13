local EventFrame = CreateFrame("Frame")
deathZones = {};
EventFrame:RegisterEvent("PLAYER_DEAD")
EventFrame:SetScript("OnEvent", function(self,event,...)
	local curZone = GetRealZoneText();
	
	if deaths == nil then
		ChatFrame1:AddMessage("This is your first ever death. Congratulations!")
		deaths = 1
		deathsThisLevel = 1
		deathZones[curZone] = 1

	else
		deaths = deaths + 1
		
		if deathsThisLevel == 0 then
			ChatFrame1:AddMessage("This is your first death this level.")
			deathsThisLevel = 1
		else
			deathsThisLevel = deathsThisLevel + 1
			ChatFrame1:AddMessage("This is death number " .. deathsThisLevel .. " this level.")
		end
		
		if deathZones[curZone] == nil or deathZones[curZone] == 0 then
			ChatFrame1:AddMessage("This is your first death in this area.")
			deathZones[curZone] = 1
		else
			deathZones[curZone] = deathZones[curZone] + 1
			ChatFrame1:AddMessage("This is death number " .. deathZones[curZone] .. " in this area.")
		end
		
		ChatFrame1:AddMessage("This is death number: " .. deaths .. ". Try to prevent your health from reaching 0.")
	end	
end)

-- This takes a screenshot when you ding. It will display /played and the deaths per level statistic as well
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:SetScript("OnEvent", function (self, event)
	-- wait a bit so the yellow animation appears 400ms seems good
	C_Timer.After(.4, Screenshot)
	ChatFrame1:AddMessage("Last level you died " .. deathsThisLevel .. " times.")
	RequestTimePlayed()
	deathsThisLevel = 0	
end
)

SLASH_deaths1 = "/ds"
SLASH_deaths2 = "/deathy"

SlashCmdList["deaths"] = function(msg)
	if deaths and deathsThisLevel and deathZones then
		ChatFrame1:AddMessage("You have died " .. deaths .. " times in total, " .. deathsThisLevel .. " times this level and " .. deathZones[GetRealZoneText()] .. " times in this area.")
	else
		ChatFrame1:AddMessage("You haven't died this level or in this zone yet. Tryhard.");
	end
end