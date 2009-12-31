local CLASS = {}

CLASS.DisplayName			= "Bang"
CLASS.Description			= "This bad boy has an SMG but very slow. +50 health."
CLASS.WalkSpeed 			= 230
CLASS.CrouchedWalkSpeed 	= 0.2
CLASS.RunSpeed				= 230
CLASS.DuckSpeed				= 0.4
CLASS.JumpPower				= 200
CLASS.StartHealth			= 150
CLASS.PlayerModel			= "models/player/Kleiner.mdl"
CLASS.DrawTeamRing			= true
CLASS.Selectable			= true

function CLASS:Loadout( pl )

	pl:Give( "weapon_smg1" )
	pl:GiveAmmo(500, "SMG1")
	pl:GiveAmmo(1, "SMG1_Grenade")
	pl:Give( "weapon_frag" )
	pl:GiveAmmo(3, "grenade" )
	
end

function CLASS:OnSpawn( pl )
	pl:SetNWString( "NameColor", "red" )
end

function CLASS:OnDeath( pl, attacker, dmginfo )
	pl:DropWeapon(pl:GetWeapon("weapon_frag"))
end

player_class.Register( "Bang", CLASS )