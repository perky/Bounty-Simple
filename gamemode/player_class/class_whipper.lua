
local CLASS = {}

CLASS.DisplayName			= "Whipper."
CLASS.Description			= "Whip those fools with a crowbar at high velocity. -25 health."
CLASS.WalkSpeed 			= 580
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 580
CLASS.DuckSpeed				= 0.4
CLASS.JumpPower				= 470
CLASS.StartHealth			= 75
CLASS.DrawTeamRing			= true
CLASS.Selectable			= true

function CLASS:Loadout( pl )

	pl:Give( "weapon_crowbar" )
	
end

function CLASS:OnSpawn( pl )
	pl:SetNWString( "NameColor", "green" )
end

player_class.Register( "Whipper", CLASS )