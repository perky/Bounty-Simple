
local CLASS = {}

CLASS.DisplayName			= "Long Shot..."
CLASS.Description			= "Has a crossbow with zoom, not so fast though. -50 health."
CLASS.WalkSpeed 			= 300
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 300
CLASS.DuckSpeed				= 0.4
CLASS.JumpPower				= 200
CLASS.StartHealth			= 50
CLASS.PlayerModel			= "models/player/Kleiner.mdl"
CLASS.DrawTeamRing			= true
CLASS.Selectable			= true

function CLASS:Loadout( pl )

	pl:Give( "weapon_crossbow" )
	pl:GiveAmmo( 50, "XBowBolt")
	
end

function CLASS:OnSpawn( pl )
	pl:SetNWString( "NameColor", "yellow" )
end

player_class.Register( "LongShot", CLASS )