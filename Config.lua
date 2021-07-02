nibWindowSize_Cfg = {

-- Window Size
scale = 1.3,		-- 1 = Normal

-- Drop-down menus
dropdownmenus = {
	enabled = true,		-- Enable the scaling of drop-down menus
	minscale = 0.70,	-- 0.64 to 1.5. Drop-down menus work off of UI Scale. Set this value to the smallest scale you want drop-down menus to go.
},

-- Custom Frames
customframes = {
	-- "ExampleFrameName",		-- Creating a line like this will resize the frame
	"TSB_SpellBookFrame",
	"pfConfigGUI",
},

-- Exclude Frames
-- To see all Frames getting resized, look in Core.lua
excludeframes = {
	-- ["ExampleFrameName"] = true,		-- Creating a line like this will stop the frame from being resized
	["PVPFrame"] = true,
	["KnowledgeBaseFrame"] = true,
},

}