-- This file contains pretty much of development helpers.
-- Set loadFile = false after the development!

local loadFile = true

if (loadFile) then
	if (SERVER) then
		ErrorNoHalt("NUTSCRIPT DEVELOPER HELPER IS STILL ACTIVE!\n")
	end
end

dev = dev or {}

function dev.allitems()
	print("[DEV] Print all item instances.")
	print("[DEV] INV INSTANCE: " .. tostring(nut.item.instances))

	PrintTable(nut.item.instances)
	print("[DEV] END OF RESULT.")
end

function dev.printInv(client)
	if (!client) then return end
	local inv = client:getChar():getInv()
	print("[DEV] CLINT INV ".. tostring(inv))

	inv:print()
end

function dev.invTest(client)
	if (!client) then return end
	local inv = client:getChar():getInv()
	print("[DEV] CLINT INV ".. tostring(inv))

	local randomItem = table.Random(inv:getItems())

	print(randomItem.name)
	local a, b = randomItem:transfer(nil, nil, nil, client, nil, true)

	if (a) then
		print("SUCESS")
	else
		print("FAIL", b)
		return
	end
	
	timer.Simple(10, function()
		a, b = randomItem:transfer(inv:getID(), nil, nil, client)

		if (a) then
			print("SUCESS")
		else
			print("FAIL")
			return
		end
	end)
end

function dev.printInvs()
	for invID, obj in pairs(nut.item.inventories) do
		if (invID == 0) then
			print("------------------------")
			print("LOGIC INVENTORY")
					PrintTable(obj)
			print("------------------------")
		else
			if (SERVER) then
				for k, v in ipairs(player.GetAll()) do
					obj:sync(v, true)
				end
			end

			obj:printAll()
		end
	end
end


function dev.charInvs()
	for k, v in ipairs(player.GetAll()) do
		print(v:Name(), v:getChar():getInv():getID())
	end
end

function dev.printData()
	for k, v in ipairs(player.GetAll()) do
		print("INVENTORY: " .. v:Name() .. " +=============")
		local char = v:getChar()
		local inv = char:getInv()

		for key, item in pairs(inv:getItems()) do
			print("ITEM DATA > ".. item.name)
			PrintTable(item.data)
		end
	end
end

function dev.printmats(client)
	local trace = client:GetEyeTraceNoCursor()
	local ent = trace.Entity

	if (ent and ent:IsValid() and ent:GetClass() == "nut_vendor") then
		local mats = ent:GetMaterials()
		PrintTable(mats)
	end
end

function dev.vmmats()
	local lp = LocalPlayer()
	local vm = lp:GetViewModel()
	if (vm and vm:IsValid()) then
		local mats = vm:GetMaterials()
		PrintTable(mats)
	end
end

local iconsize = 64
function dev.iconFrame(ply, cmd, args)
	local itemID = args[1]
	local frame = vgui.Create("DFrame")
	frame:MakePopup()
	frame:SetSize(iconsize*5 + 4, iconsize*5 + 4)
	frame:Center()
	function frame:addicon(a)
		local panel = self:Add("nutItemIcon")
		panel:SetSize(a.width * iconsize, a.height * iconsize)
		panel:SetZPos(1)
		panel:InvalidateLayout(true)
		panel:SetModel(a.model)
		panel:SetPos(10, 30)

		if (a.iconCam) then
			local iconCam = a.iconCam
			iconCam = {
				cam_pos = iconCam.pos,
				cam_fov = iconCam.fov,
				cam_ang = iconCam.ang,
			}
			renderdIcons[string.lower(a.model)] = true
			
			panel.Icon:RebuildSpawnIconEx(
				iconCam
			)
		end
	end

	function frame:reload()
		if frame.icon and frame.item then
			frame.icon:Remove()
			frame:addicon(frame.item)
		end
	end

	local a = nut.item.list[itemID]

	if (a) then
		frame.item = a

		local btn = frame:Add("DButton")
		btn:Dock(BOTTOM)

		frame:addicon(a)
	end
end
concommand.Add("ico", dev.iconFrame)

nut.command.add("giveitemmenu", {
	onRun = function(client, arguments)
		netstream.Start(client, "nutItemMenu")
	end
})

if (CLIENT) then
	local PANEL = {}

	function PANEL:Init()
		self:SetSize(300, 500)
		self:Center()
		self:MakePopup()

		self.menu = self:Add("PanelList")
		self.menu:Dock(FILL)
		self.menu:DockMargin(5, 5, 5, 5)
		self.menu:SetSpacing(2)
		self.menu:SetPadding(2)
		self.menu:EnableVerticalScrollbar()

		self:LoadItems()
	end

	function PANEL:LoadItems()
		local sorted = {}

		for k, v in pairs(nut.item.list) do
			if (v.base) then
				sorted[v.base] = sorted[v.base] or {}
				table.insert(sorted[v.base], v)
			else
				sorted["zzz"] = sorted["zzz"] or {}
				table.insert(sorted["zzz"], v)
			end
		end

		for k, v in SortedPairs(sorted) do
			local label = self.menu:Add("DLabel")
			label:SetText(k)
			self.menu:AddItem(label)

			for _, d in ipairs(v) do
				local button = self.menu:Add("DButton")
				button:SetText(L(d.name))
				self.menu:AddItem(button)

				function button:DoClick()
					LocalPlayer():ConCommand(Format('say /chargiveitem "%s" "%s"', LocalPlayer():Name(), d.uniqueID))
				end
			end
		end
	end

	vgui.Register("nutItemMenu", PANEL, "DFrame")

	netstream.Hook("nutItemMenu", function()
		local a = vgui.Create("nutItemMenu")
	end)
end

if (CLIENT) then
PANEL = {}
AccessorFunc( PANEL, "m_strModel", 		"Model" )
AccessorFunc( PANEL, "m_pOrigin", 		"Origin" )
AccessorFunc( PANEL, "m_bCustomIcon", 	"CustomIcon" )

function PANEL:Init()

	self:SetSize( 650, 502 )
	self:SetTitle( "Icon Editor" )
	
	local pnl = self:Add( "Panel" )
	pnl:SetSize( 400, 400 )
	pnl:Dock( FILL )
	pnl:DockMargin( 0, 0, 4, 0 )
	
		self.AnimList = pnl:Add( "DListView" )
		self.AnimList:AddColumn( "name" )
		self.AnimList:Dock( FILL )
		self.AnimList:SetSize( 200, 300 )
		self.AnimList:SetMultiSelect( true )
		self.AnimList:SetHideHeaders( true )
				
	local pnl = pnl:Add( "Panel" )
	pnl:Dock( BOTTOM )
	pnl:SetTall( 140 )

		self.BodyList = pnl:Add( "DListLayout" )
		self.BodyList:Dock( FILL )
		pnl:DockMargin( 0, 4, 0, 0 )
			
	local pnl = self:Add( "Panel" )
	pnl:SetSize( 400, 400 )
	pnl:Dock( RIGHT )
	
		local bg = pnl:Add( "DPanel" )
		bg:Dock( TOP )
		bg:SetSize( 400, 400 )
		bg:DockMargin( 0, 0, 0, 4 )
		bg.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 128 ) ) end
	
		self.SpawnIcon = bg:Add( "SpawnIcon" )
		//self.SpawnIcon.DoClick = function() self:RenderIcon() end

		self.ModelPanel = bg:Add( "DAdjustableModelPanel" )
		self.ModelPanel:Dock( FILL )
		self.ModelPanel.FarZ = 32768

	local pnl2 = pnl:Add( "Panel" )
	pnl2:SetSize( 400, 64 )
	pnl2:Dock( FILL )

		local BestGuess = pnl2:Add( "DImageButton" )
		BestGuess:SetImage( "icon32/wand.png" )
		BestGuess:SetStretchToFit( false )
		BestGuess:SetDrawBackground( true )
		BestGuess.DoClick = function() self:BestGuessLayout() end
		BestGuess:Dock( LEFT )
		BestGuess:DockMargin( 0, 0, 0, 0 )
		BestGuess:SetWide( 50 )
		BestGuess:SetTooltip( "Best Guess" )

		local FullFrontal = pnl2:Add( "DImageButton" )
		FullFrontal:SetImage( "icon32/hand_point_090.png" )
		FullFrontal:SetStretchToFit( false )
		FullFrontal:SetDrawBackground( true )
		FullFrontal.DoClick = function() self:FullFrontalLayout() end
		FullFrontal:Dock( LEFT )
		FullFrontal:DockMargin( 2, 0, 0, 0 )
		FullFrontal:SetWide( 50 )
		FullFrontal:SetTooltip( "Front" )
				
		local Above = pnl2:Add( "DImageButton" )
		Above:SetImage( "icon32/hand_property.png" )
		Above:SetStretchToFit( false )
		Above:SetDrawBackground( true )
		Above.DoClick = function() self:AboveLayout() end
		Above:Dock( LEFT )
		Above:DockMargin( 2, 0, 0, 0 )
		Above:SetWide( 50 )
		Above:SetTooltip( "Above" )
		
		local Right = pnl2:Add( "DImageButton" )
		Right:SetImage( "icon32/hand_point_180.png" )
		Right:SetStretchToFit( false )
		Right:SetDrawBackground( true )
		Right.DoClick = function() self:RightLayout() end
		Right:Dock( LEFT )
		Right:DockMargin( 2, 0, 0, 0 )
		Right:SetWide( 50 )
		Right:SetTooltip( "Right" )
		
		local Origin = pnl2:Add( "DImageButton" )
		Origin:SetImage( "icon32/hand_point_090.png" )
		Origin:SetStretchToFit( false )
		Origin:SetDrawBackground( true )
		Origin.DoClick = function() self:OriginLayout() end
		Origin:Dock( LEFT )
		Origin:DockMargin( 2, 0, 0, 0 )
		Origin:SetWide( 50 )
		Origin:SetTooltip( "Center" )

		local Render = pnl2:Add( "DButton" )
		Render:SetText( "RENDER" )
		Render.DoClick = function() self:RenderIcon() end
		Render:Dock( RIGHT )
		Render:DockMargin( 2, 0, 0, 0 )
		Render:SetWide( 50 )
		Render:SetTooltip( "Render Icon" )
		
		local Picker = pnl2:Add( "DImageButton" )
		Picker:SetImage( "icon32/color_picker.png" )
		Picker:SetStretchToFit( false )
		Picker:SetDrawBackground( true )
		Picker.DoClick = function() 

			self:SetVisible( false )

			util.worldpicker.Start( function( tr )

				self:SetVisible( true )
				
				print( tr.Entity )

				if ( !IsValid( tr.Entity ) ) then return end

				
				
				self:SetFromEntity( tr.Entity )

			end )
		end

		Picker:Dock( RIGHT )
		Picker:DockMargin( 2, 0, 0, 0 )
		Picker:SetWide( 50 )     

	local pnl3 = pnl2:Add( "Panel" )
	pnl3:SetSize( 400, 20 )
	pnl3:Dock( TOP )
	pnl3:DockMargin( 0, 0, 0, 4 )
	pnl3:MoveToBack()
		
		self.AnimTrack = pnl3:Add( "DSlider" )
		self.AnimTrack:Dock( FILL )
		self.AnimTrack:SetNotches( 100 )
		self.AnimTrack:SetTrapInside( true )
		self.AnimTrack:SetLockY( 0.5 )
		
		self.AnimPause = pnl3:Add( "DImageButton" )
		self.AnimPause:SetImage( "icon16/control_pause_blue.png" )
		self.AnimPause:SetStretchToFit( false )
		self.AnimPause:SetDrawBackground( true )
		self.AnimPause:SetIsToggle( true )
		self.AnimPause:SetToggle( false )
		self.AnimPause:Dock( LEFT )
		self.AnimPause:SetWide( 32 )

end

function PANEL:SetDefaultLighting()

	self.ModelPanel:SetAmbientLight( Color( 255 * 0.3, 255 * 0.3, 255 * 0.3 ) )
	
	self.ModelPanel:SetDirectionalLight( 0, Color( 255 * 0.2, 255 * 0.2, 255 * 0.2 ) )
	self.ModelPanel:SetDirectionalLight( 1, Color( 255 * 1.3, 255 * 1.3, 255 * 1.3 ) )
	self.ModelPanel:SetDirectionalLight( 2, Color( 255 * 0.2, 255 * 0.2, 255 * 0.2 ) )
	self.ModelPanel:SetDirectionalLight( 3, Color( 255 * 0.2, 255 * 0.2, 255 * 0.2 ) )
	self.ModelPanel:SetDirectionalLight( 4, Color( 255 * 2.3, 255 * 2.3, 255 * 2.3 ) )
	self.ModelPanel:SetDirectionalLight( 5, Color( 255 * 0.1, 255 * 0.1, 255 * 0.1 ) )

end

function PANEL:BestGuessLayout()

	local ent = self.ModelPanel:GetEntity()
	local pos = ent:GetPos()
	
	local tab = PositionSpawnIcon( ent, pos )
	
	if ( tab ) then
		self.ModelPanel:SetCamPos( tab.origin )
		self.ModelPanel:SetFOV( tab.fov )
		self.ModelPanel:SetLookAng( tab.angles )
	end

end

function PANEL:FullFrontalLayout()

	local ent = self.ModelPanel:GetEntity()
	local pos = ent:GetPos()
	local campos = pos + Vector( -200, 0, 0 )
	
	self.ModelPanel:SetCamPos( campos )
	self.ModelPanel:SetFOV( 45 )
	self.ModelPanel:SetLookAng( (campos * -1):Angle() )
	
end

function PANEL:AboveLayout()

	local ent = self.ModelPanel:GetEntity()
	local pos = ent:GetPos()
	local campos = pos + Vector( 0, 0, 200 )
	
	self.ModelPanel:SetCamPos( campos )
	self.ModelPanel:SetFOV( 45 )
	self.ModelPanel:SetLookAng( (campos * -1):Angle() )
	
end

function PANEL:RightLayout()

	local ent = self.ModelPanel:GetEntity()
	local pos = ent:GetPos()
	local campos = pos + Vector( 0, 200, 0 )
	
	self.ModelPanel:SetCamPos( campos )
	self.ModelPanel:SetFOV( 45 )
	self.ModelPanel:SetLookAng( (campos * -1):Angle() )
	
end

function PANEL:OriginLayout()

	local ent = self.ModelPanel:GetEntity()
	local pos = ent:GetPos()
	local campos = pos + Vector( 0, 0, 0 )
	
	self.ModelPanel:SetCamPos( campos )
	self.ModelPanel:SetFOV( 45 )
	self.ModelPanel:SetLookAng( Angle( 0, -180, 0 ) )
	
end

function PANEL:UpdateEntity( ent )

	ent:SetEyeTarget( self.ModelPanel:GetCamPos() )
	
	if ( self.AnimTrack:GetDragging() ) then
	
		ent:SetCycle( self.AnimTrack:GetSlideX() )
		self.AnimPause:SetToggle( true )
		
	else
		
		self.AnimTrack:SetSlideX( ent:GetCycle() )
		
	end
	
	if ( !self.AnimPause:GetToggle() ) then
		ent:FrameAdvance( FrameTime() )		
	end

end

function PANEL:RenderIcon()
	
	local ent = self.ModelPanel:GetEntity()
	
	local tab = {}
	tab.ent		= ent
	
	tab.cam_pos = self.ModelPanel:GetCamPos()
	tab.cam_ang = self.ModelPanel:GetLookAng()
	tab.cam_fov = self.ModelPanel:GetFOV()

	export = [[ITEM.iconCam = {
	ang	= Angle(%s, %s, %s),
	fov	= %s,
	pos	= Vector(%s, %s, %s)
}]]

	print(Format(export, tab.cam_ang[1], tab.cam_ang[2], tab.cam_ang[3], tab.cam_fov, tab.cam_pos[1], tab.cam_pos[2], tab.cam_pos[3]))

	self.SpawnIcon:RebuildSpawnIconEx( tab )

end


function PANEL:SetIcon( icon )

	local model = icon:GetModelName()
	self:SetOrigin( icon )
	
	self.SpawnIcon:SetSize( icon:GetSize() )
	self.SpawnIcon:InvalidateLayout( true )
	
	if ( !model || model == "" ) then
	
		self:SetModel( "error.mdl" )
		self.SpawnIcon:SetSpawnIcon( icon:GetIconName() )
		self:SetCustomIcon( true )
		
	else

		self:SetModel( model )
		self.SpawnIcon:SetModel( model, icon:GetSkinID(), icon:GetBodyGroup() )
		self:SetCustomIcon( false )

	end

end

function PANEL:Refresh()

	self.ModelPanel:SetModel( self:GetModel() )
	self.ModelPanel.LayoutEntity = function() self:UpdateEntity( self.ModelPanel:GetEntity() )  end

	local ent = self.ModelPanel:GetEntity()
	local pos = ent:GetPos()
	
	local tab = PositionSpawnIcon( ent, pos )
	
	ent:SetSkin( self.SpawnIcon:GetSkinID() )
	ent:SetBodyGroups( self.SpawnIcon:GetBodyGroup() )
	
	self:BestGuessLayout()
	self:FillAnimations( ent )
	self:SetDefaultLighting()

end

function PANEL:FillAnimations( ent )

	self.AnimList:Clear()

	for k, v in SortedPairsByValue( ent:GetSequenceList() ) do
	
		local line = self.AnimList:AddLine( string.lower( v ) )
		
		line.OnSelect = function()
		
			ent:ResetSequence( v )
			ent:SetCycle( 0 )
		
		end
	
	end

	self.BodyList:Clear()
	
	if ( ent:SkinCount() - 1 > 0 ) then

		local combo = self.BodyList:Add( "DComboBox" )
								
		for l=0, ent:SkinCount()-1 do
			combo:AddChoice( "Skin " .. l, function()	
		
				ent:SetSkin( l )
							
				if ( self:GetOrigin() ) then
					self:GetOrigin():SkinChanged( l )
				end
							
				-- If we're not using a custom, change our spawnicon
				-- so we save the new skin in the right place...
				if ( !self:GetCustomIcon() ) then
					self.SpawnIcon:SetModel( self.SpawnIcon:GetModelName(), l, self.SpawnIcon:GetBodyGroup() )
				end
						
			end )
		end

		combo:ChooseOptionID( ent:GetSkin( l ) + 1 )
		combo.OnSelect = function( pnl, index, value, data ) data()	end	
	
	end
	
	for k=0, ent:GetNumBodyGroups()-1 do
	
		if ( ent:GetBodygroupCount( k ) <= 1 ) then continue end
		
		local combo = self.BodyList:Add( "DComboBox" )
							
		for l=0, ent:GetBodygroupCount( k )-1 do
			
			combo:AddChoice( ent:GetBodygroupName( k ) .. " " .. l, function()	
				
				-- Body Group Changed..
				ent:SetBodygroup( k, l ) 
						
				if ( self:GetOrigin() ) then
					self:GetOrigin():BodyGroupChanged( k, l )
				end
						
				-- If we're not using a custom, change our spawnicon
				-- so we save the new skin in the right place...
				if ( !self:GetCustomIcon() ) then
					self.SpawnIcon:SetBodyGroup( k, l )
					self.SpawnIcon:SetModel( self.SpawnIcon:GetModelName(), self.SpawnIcon:GetSkinID(), self.SpawnIcon:GetBodyGroup() )
				end
					
			end )

		end
			
		combo:ChooseOptionID( ent:GetBodygroup( k ) + 1 )

		combo.OnSelect = function( pnl, index, value, data ) data() end

	end

end

function PANEL:SetFromEntity( ent )

	if ( !IsValid( ent ) ) then return end

	self.SpawnIcon:SetModel( ent:GetModel(), ent:GetSkin() )//, ent:GetBodyGroup() )
	self:SetModel( ent:GetModel() )
	self:Refresh()

end

vgui.Register( "IconEditor", PANEL, "DFrame" )
end