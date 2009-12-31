
local CLASS = {}

CLASS.DisplayName			= "Pistol Man!"
CLASS.Description			= "He looves his pistol."
CLASS.WalkSpeed 			= 400
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 400
CLASS.DuckSpeed				= 0.4
CLASS.JumpPower				= 300
CLASS.StartHealth			= 100
CLASS.PlayerModel			= "models/player/Kleiner.mdl"
CLASS.DrawTeamRing			= true
CLASS.Selectable			= true

function CLASS:Loadout( pl )

	pl:Give( "weapon_pistol" )
	pl:GiveAmmo(200, "Pistol")
	
end

function CLASS:OnSpawn( pl )
	pl:SetNWString( "NameColor", "pink" )
end

player_class.Register( "PistolMan", CLASS )