local Opts = nibWindowSize_Cfg
local nWS = CreateFrame("Frame")

-- Standard Frames
local StandardFrames = {
	"ArenaFrame",
	"AudioOptionsFrame",
	"BankFrame",
	"BattlefieldFrame",
	"CharacterFrame",
	"DressUpFrame",
	"FriendsFrame",
	"GossipFrame",
	"GuildRegistrarFrame",
	"HelpFrame",
	"InterfaceOptionsFrame",
	"KnowledgeBaseFrame",
	"LFDParentFrame",
	"LFGParentFrame",
	"MacOptionsFrame",
	"MailFrame",
	"MerchantFrame",
	"OpenMailFrame",
	"PetStableFrame",
	"PVPFrame",
	"QuestLogFrame",
	"QuestLogDetailFrame",
	"QuestFrame",
	"SpellBookFrame",
	"StackSplitFrame",
	"TabardFrame",
	"TaxiFrame",
	"TradeFrame",
	"VideoOptionsFrame",
	"WorldStateScoreFrame",
	"CraftFrame"
}

-- Frames created from LOD AddOns
local LODAddOns = {
	["Blizzard_ArchaeologyUI"] = "ArchaeologyFrame",
	["Blizzard_AuctionUI"] = "AuctionFrame",
	["Blizzard_BindingUI"] = "KeyBindingFrame",
	["Blizzard_Calendar"] = "CalendarFrame",
	["Blizzard_GMSurveyUI"] = "GMSurveyFrame",
	["Blizzard_GuildUI"] = "GuildFrame",
	["Blizzard_GuildBankUI"] = "GuildBankFrame",
	["Blizzard_InspectUI"] = "InspectFrame",
	["Blizzard_ItemSocketingUI"] = "ItemSocketingFrame",
	["Blizzard_MacroUI"] = "MacroFrame",
	["Blizzard_ReforgingUI"] = "ReforgingFrame",
	["Blizzard_TimeManager"] = "TimeManagerFrame",
	["Blizzard_TradeSkillUI"] = "TradeSkillFrame",
	["Blizzard_TrainerUI"] = "ClassTrainerFrame",
	["Blizzard_TalentUI"] = "PlayerTalentFrame",
}

-- Frames to avoid changing while in combat
local SecureFrames = {
	["SpellBookFrame"] = true,
}

-- Resize Frame table
local ResizeFrames = StandardFrames

-- Hook into frames
function nWS.HookFrames()
	local Scale, MinScale = tonumber(GetCVar("UIScale")), Opts.dropdownmenus.minscale
	
	if Opts.dropdownmenus then
		if Opts.dropdownmenus.enabled then
			-- DropDownMenu
			if DropDownList1 then
				hooksecurefunc(DropDownList1, "Show", function()
					if Scale < MinScale then DropDownList1:SetScale(MinScale) end
				end)
			end
			if DropDownList2 then
				hooksecurefunc(DropDownList2, "Show", function()
					if Scale < MinScale then DropDownList2:SetScale(MinScale) end
				end)
			end
		end
	end
end

-- Adjust Window Size
function nWS.ResizeWindows()
	for i,v in pairs(ResizeFrames) do
		local f = _G[v]
		if f then
			if not ((SecureFrames[v] and InCombatLockdown()) or Opts.excludeframes[v]) then
				f:SetScale(Opts.scale)
			end
		end
	end
end

----
local function EventHandler(self, event, ...)
	if event == "PLAYER_LOGIN" then
		nWS.HookFrames()
		-- Add Custom Frames
		for i,v in pairs(Opts.customframes) do
			tinsert(ResizeFrames, v)
		end
	elseif event == "ADDON_LOADED" then
		-- Add LoD Frames
		local addon = ...
		if LODAddOns[addon] then
			tinsert(ResizeFrames, LODAddOns[addon])
		end	
	end
	nWS.ResizeWindows()
end
nWS:RegisterEvent("PLAYER_LOGIN")
nWS:RegisterEvent("ADDON_LOADED")
nWS:SetScript("OnEvent", EventHandler)