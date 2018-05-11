----------------------------------------------------------------------
-- quickstyles ipelet v. 0.1 author Andre Schulz
----------------------------------------------------------------------

label = "Quick Styles"

revertOriginal = _G.revertOriginal

about = [[
Ipelets for user defined styles
]]


----------------------------------------------------------------------


----------------------------------------------------------------------


function setstyle(model, num)

	local index = string.sub(tostring(num),1,1)

	local doc = model.doc
	local sheets = doc:sheets()

	-- Retrieve flag vector decode values 

	local flag  = tonumber(sheets:find("opacity","QuickFlag"..index))
	local flag_farrow = true
	local flag_rarrow = false
	local flag_pathmode = "strokedfilled"

	if (flag % 2)==1 then
		flag_farrow = false
	end
	flag = math.floor(flag/2)

	if (flag % 2)==1 then
		flag_rarrow = true
	end
	flag = math.floor(flag/2)

	if ((flag % 4)==1) then
		flag_pathmode = "stroked"
	elseif  ((flag % 4)==3) then
		flag_pathmode = "filled"
	else end

	-- set the remaining properties using the predifined styles in quickstyles.isy

	model.ui.setAttributes(model.ui, doc:sheets(),
		{stroke = "QuickColor"..index, 
		 pen="QuickWidth"..index, 
		 opacity="QuickOpacity"..index,
		 fill="QuickFill"..index,
		 dashstyle="QuickDash"..index,
		 farrowsize = "QuickFArrow"..index,
		 rarrowsize = "QuickRArrow"..index,
		 farrow =  flag_farrow,
		 rarrow =  flag_rarrow,
		 pathmode = flag_pathmode
		 })

	model.attributes.stroke = "QuickColor"..index
	model.attributes.pen =  "QuickWidth"..index
	model.attributes.opacity = "QuickOpacity"..index
	model.attributes.dashstyle = "QuickDash"..index
	model.attributes.fill = "QuickFill"..index
	model.attributes.farrowsize = "QuickFArrow"..index
	model.attributes.rarrowsize = "QuickRArrow"..index
	model.attributes.farrow = flag_farrow
	model.attributes.rarrow = flag_rarrow
	model.attributes.pathmode = flag_pathmode

	model.ui:update()
end



function set(model,num)
	setstyle(model,num)

	 local t = { label = label,
	      pno = model.pno,
	      vno = model.vno,
	      selection = model:selection(),
	      original = model:page():clone(),
	      undo = revertOriginal,
	    }
	     t.redo = function (t, doc)
	 	-- no redo possible yet..
	 	end
  	model:register(t)
end



function definestyle(model, num)

local index = string.sub(tostring(num),1,1)

local doc = model.doc
local sheets = doc:sheets()

-- check if quickstyles sheet exist

local sheet
local oldsheet = false

for s=1,sheets:count() do
	if tostring(sheets:sheet(s):name()) == "QuickStyles" then
		sheet = sheets:sheet(s)
	--	ipeui.messageBox(nil, "warning",sheets:sheet(s):name() , nil, nil)
		oldsheet = true
	end
end

if oldsheet == false then
	sheet = ipe.Sheet()    
	sheet:setName("QuickStyles")
	sheets:insert(sheets:count()+1,sheet)
end

-- get the attributes and write to sheet



local entry_pen=sheets:find("pen",model.attributes.pen)
sheet:add("pen", "QuickWidth"..index, entry_pen)
local entry_stroke=sheets:find("color",model.attributes.stroke)
sheet:add("color", "QuickColor"..index, entry_stroke)
local entry_fill=sheets:find("color",model.attributes.fill)
sheet:add("color", "QuickFill"..index, entry_fill)
local entry_opacity=sheets:find("opacity",model.attributes.opacity)
sheet:add("opacity", "QuickOpacity"..index, entry_opacity)
local entry_dash=sheets:find("dashstyle",model.attributes.dashstyle)
sheet:add("dashstyle", "QuickDash"..index, entry_dash)
local entry_dash=sheets:find("dashstyle",model.attributes.dashstyle)
sheet:add("dashstyle", "QuickDash"..index, entry_dash)
local entry_farrow=sheets:find("arrowsize",model.attributes.farrowsize)
sheet:add("arrowsize", "QuickFArrow"..index, entry_farrow)
local entry_rarrow=sheets:find("arrowsize",model.attributes.rarrowsize)
sheet:add("arrowsize", "QuickRArrow"..index, entry_rarrow)




-- Encode values stored in flag vector

local entry_opacity_flag = 0

if (not model.attributes.farrow) then
   entry_opacity_flag = entry_opacity_flag + 1
   end

if (model.attributes.rarrow) then
	entry_opacity_flag = entry_opacity_flag +2
	end


if (model.attributes.pathmode == "stroked") then
	entry_opacity_flag = entry_opacity_flag + 4
	end
if (model.attributes.pathmode == "filled") then
		entry_opacity_flag = entry_opacity_flag + 8
	end

-- write flag vector to sheet

sheet:add("opacity", "QuickFlag"..index, entry_opacity_flag)

end

function define(model,num)

	definestyle(model,num-5)

	local t = { label = label,
	      pno = model.pno,
	      vno = model.vno,
	      selection = model:selection(),
	      original = model:page():clone(),
	      undo = revertOriginal,
	    }
	     t.redo = function (t, doc)
	 	-- no redo possible yet..
	 	end
  	model:register(t)

end

----------------------------------------------------------------------

methods = {
  { label = "Style 1", run = set },
  { label = "Style 2", run = set },
  { label = "Style 3", run = set },
  { label = "Style 4", run = set },
  { label = "Style 5", run = set },
  { label = "Define style 1", run = define},
  { label = "Define style 2", run = define}, 
  { label = "Define style 3", run = define},
  { label = "Define style 4", run = define},   
  { label = "Define style 5", run = define} 
}

shortcuts.ipelet_1_quickstyles = "1"
shortcuts.ipelet_2_quickstyles = "2"
shortcuts.ipelet_3_quickstyles = "3"
shortcuts.ipelet_4_quickstyles = "4"
shortcuts.ipelet_5_quickstyles = "5"
shortcuts.ipelet_6_quickstyles = "Shift+1"
shortcuts.ipelet_7_quickstyles = "Shift+2"
shortcuts.ipelet_8_quickstyles = "Shift+3" 
shortcuts.ipelet_9_quickstyles = "Shift+4"
shortcuts.ipelet_10_quickstyles = "Shift+5"
----------------------------------------------------------------------
