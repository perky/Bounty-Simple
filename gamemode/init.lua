AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

resource.AddFile("sound/bounty/ching1.wav")
util.PrecacheSound("bounty/ching1.wav")

function GM:PlayerInitialSpawn( ply )
	self.BaseClass:PlayerInitialSpawn( ply )
	
	ply.bounty = 5
	UpdatePlayerVariables( ply )
	ply:SetTeam(TEAM_MAIN)
	ply:SetRandomClass()
end

function GM:PlayerJoinTeam( ply, teamid )
	self.BaseClass:PlayerJoinTeam( ply, teamid )
	
	if teamid == TEAM_UNASSIGNED then
		ply:SetTeam( TEAM_MAIN )
	end
end

function GM:CanStartRound( iNum )
	for k,ply in pairs(player.GetAll()) do
		ply:SetTeam(TEAM_MAIN)
		ply:SetRandomClass()
	end
    return true
end

function GM:OnRoundStart( iNum )
	UTIL_UnFreezeAllPlayers()
	
	for k,player in pairs( player.GetAll() ) do
		player.bounty = 5
		UpdatePlayerVariables( player )
	end
end

function GM:PlayerDeath( Victim, Weapon, Killer )
	self.BaseClass:PlayerDeath( Victim, Weapon, Killer )
	
	if Victim.bounty > 0 then
		Killer.bounty = Killer.bounty + 1
		Victim.bounty = Victim.bounty - 1
	end
	
	UpdatePlayerVariables( Killer )
	UpdatePlayerVariables( Victim )
	
	Killer:EmitSound("bounty/ching1.wav", 100, 100)
end

function UpdatePlayerVariables( Player )
	Player:SetNetworkedInt("bounty", Player.bounty)
end

function GM:CheckPlayerDeathRoundEnd()
	return false
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	if ( hitgroup == HITGROUP_HEAD ) then
		dmginfo:ScaleDamage( 1.6 )
	else
		dmginfo:ScaleDamage( 0.4 )
	end
end

function GM:RoundTimerEnd()
	if ( !GAMEMODE:InRound() ) then return end 
 
	local winner, draw = GAMEMODE:SelectCurrentlyWinningPlayer()
	if draw == 1 then
		GAMEMODE:RoundEndWithResult( -1, "Stalemate!" )
	else
		GAMEMODE:RoundEndWithResult( winner )
	end
end

function GM:SelectCurrentlyWinningPlayer()
	local winner
	local topscore = 0
	local draw = 1
 
	for k,v in pairs( player.GetAll() ) do
		if v:Team() != TEAM_CONNECTING and v:Team() != TEAM_UNASSIGNED then
			if v.bounty > topscore then
				winner = v
				topscore = v.bounty
				draw = 0
			elseif v.bounty == topscore then
				draw = 1
			end
		end
	end
 
	return winner, draw
end