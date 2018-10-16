--[[
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
Configure line 15 to point to your logo file within materials.
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
]]

AddCSLuaFile()

if CLIENT then
	include( "motd/motd.lua" )
end

if SERVER then
	AddCSLuaFile( "motd/motd.lua" )
	resource.AddSingleFile( "materials/elgcmotd/logo.png" )
	util.AddNetworkString( "showMOTD" )
  
  local function sendMOTD( ply )
    net.Start( "showMOTD" )
    net.Send( ply )
  end
  
  local function checkChatCommand( player, text, teamChat, isDead )
    if string.lower( text ) == "!motd" and player:IsValid() then
      sendMotd( player )
    end
  end
  
  hook.Add( "PlayerInitialSpawn", "ShowMOTDOnInitialSpawn", sendMOTD )
  hook.Add( "OnPlayerChat", "MOTDCommand", checkChatCommand )
end