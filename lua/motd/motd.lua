--[[
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
logo:SetImage( "motd/logo_el.png" ) - Set the file path to your community logo.
topText:SetText( "ENCRYPTED" ) - Set the first section of your community name.
bottomText:SetText( "LASER" ) - Set the second section of your community name.
webpanel:OpenURL( "https://www.google.com" ) - Set the page to edit.
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
]]

local lightgrey = Color( 57, 57, 57, 255 )
local darkgrey = Color( 29, 29, 29, 255 )
local blue = Color( 53, 122, 248, 255 )

surface.CreateFont( "RobotoBold", {
	font = "Roboto",
	size = 32,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "RobotoBold64", {
	font = "Roboto",
	size = 64,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local function showMotd()
  local font = "RobotoBold"

  local border = 10

  local motdWidth = math.floor( ScrW() * 0.95 )
  local motdHeight = math.floor( ScrH() * 0.95 )
  local halfWidth = math.floor( ScrW() * 0.95 * 0.5 )
  
  local topHeight = math.floor( ScrH() * 0.95 * 0.3 )
  local middleHeight = math.floor( ScrH() * 0.95 * 0.6 )
  local bottomHeight = math.floor( ScrH() * 0.95 * 0.1 )
  
  local halfTopHeight = math.floor( ScrH() * 0.95 * 0.3 * 0.5 )

  local panel = vgui.Create( "DPanel" )
  
	panel:SetSize( motdWidth, motdHeight )
	panel:Center()
	panel:SetVisible( true )
	panel:MakePopup()
  
  local logo = vgui.Create( "DImage" )
  
  logo:SetParent( panel )
  logo:SetSize( 200, 200 )
  logo:SetPos( halfWidth - 210, halfTopHeight - 100 )
  logo:SetImage( "motd/logo_el.png" )
  
  local topText = vgui.Create( "DLabel", panel )

  topText:SetPos( halfWidth, halfTopHeight - 63 )
  topText:SetText( "ENCRYPTED" )
  topText:SetFont( "RobotoBold64" )
  topText:SizeToContents()
  
  local bottomText = vgui.Create( "DLabel", panel )

  bottomText:SetPos( halfWidth, halfTopHeight - 4 )
  bottomText:SetText( "LASER" )
  bottomText:SetFont( "RobotoBold64" )
  bottomText:SizeToContents()
  
  local webpanel = vgui.Create( "HTML" )
  
  webpanel:SetParent( panel )
  webpanel:SetSize( motdWidth - border * 4, middleHeight - border * 3 )
  webpanel:SetPos( border * 2, topHeight + border * 1.5 )
  webpanel:OpenURL( "https://www.google.com" )
  
  local accept_btn = vgui.Create( "DButton" )
  accept_btn:SetParent( panel )
  accept_btn:SetText( "ACCEPT TERMS AND CONDITIONS" )
  accept_btn:SetFont( "RobotoBold" )
  accept_btn:SetPos( border, topHeight + middleHeight + border * 0.5 )
  accept_btn:SetSize( halfWidth - border * 1.5, bottomHeight - border * 1.5 )
  accept_btn.DoClick = function()
    panel:Remove()
  end
  
  local deny_btn = vgui.Create( "DButton" )
  deny_btn:SetParent( panel )
  deny_btn:SetText( "DO NOT ACCEPT TERMS AND CONDITIONS" )
  deny_btn:SetFont( "RobotoBold" )
  deny_btn:SetPos( halfWidth + border * 0.5, topHeight + middleHeight + border * 0.5  )
  deny_btn:SetSize( halfWidth - border * 1.5, bottomHeight - border * 1.5 )
  deny_btn.DoClick = function()
    RunConsoleCommand( "disconnect" )
  end
  
  function panel:Init()
    self.startTime = SysTime()
  end
  
  function panel:Paint( width, height )
    Derma_DrawBackgroundBlur( self, self.startTime )
    
    surface.SetDrawColor( lightgrey )
    surface.DrawRect( 0, 0, width, height )
    
    surface.SetDrawColor( darkgrey )
    surface.DrawRect( border, border, width - border * 2, topHeight - border * 1.5 )
    surface.DrawRect( border, topHeight + border * 0.5, width - border * 2, middleHeight - border )
  end
  
  function deny_btn:Paint( width, height )
    surface.SetDrawColor( darkgrey )
    surface.DrawRect( 0, 0, width, height )
  end
  
  function accept_btn:Paint( width, height )
    surface.SetDrawColor( blue )
    surface.DrawRect( 0, 0, width, height )
  end
end

net.Receive( "showMOTD", function( length, ply ) showMotd() end )