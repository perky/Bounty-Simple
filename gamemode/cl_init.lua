include( "shared.lua" )

surface.CreateFont( "HUDNumber5", ScreenScale(48), 400, true, true, "BountyBigFont" )

local Sprite = {}
Sprite[0] = Material( "sprites/key_0" )
Sprite[1] = Material( "sprites/key_1" )
Sprite[2] = Material( "sprites/key_2" )
Sprite[3] = Material( "sprites/key_3" )
Sprite[4] = Material( "sprites/key_4" )
Sprite[5] = Material( "sprites/key_5" )
Sprite[6] = Material( "sprites/key_6" )
Sprite[7] = Material( "sprites/key_7" )
Sprite[8] = Material( "sprites/key_8" )
Sprite[9] = Material( "sprites/key_9" )

function RenderEffects()
	
	cam.Start3D(EyePos(), EyeAngles())
		for k,ply in pairs(player:GetAll()) do
			if(ply:Alive()) then
			local num = ply:GetNetworkedInt("bounty")
			local digit1 = math.floor(num/10)
			local digit2 = num-(digit1*10)
			
			render.SetMaterial( Sprite[digit2] )
			local pos = ply:EyePos() + Vector(0,0,30)
			local v1 = pos-LocalPlayer():EyePos()
			local v2 = v1:Angle():Right()
			render.DrawSprite(pos, 16, 16, white)
			if(digit1 > 0) then
				render.SetMaterial( Sprite[digit1] )
				render.DrawSprite(pos+v2*-12, 16, 16, white) --first attempt
			end
			end
		end
	cam.End3D()
end
hook.Add( "RenderScreenspaceEffects", "BountySimple_RenderScreenspaceEffects", RenderEffects )

function GM:UpdateHUD_Alive( InRound )
 
        if ( GAMEMODE.RoundBased || GAMEMODE.TeamBased ) then
       
                local Bar = vgui.Create( "DHudBar" )
                GAMEMODE:AddHUDItem( Bar, 2 )
               
                if ( GAMEMODE.RoundBased ) then
				
						local RoundNumber = vgui.Create( "DHudUpdater" );
                                RoundNumber:SizeToContents()
                                RoundNumber:SetValueFunction( function() return "$"..LocalPlayer():GetNetworkedInt("bounty") end )
                                RoundNumber:SetLabel( "BOUNTY" )
                        Bar:AddItem( RoundNumber )
               
                        local RoundNumber = vgui.Create( "DHudUpdater" );
                                RoundNumber:SizeToContents()
                                RoundNumber:SetValueFunction( function() return GetGlobalInt( "RoundNumber", 0 ) end )
                                RoundNumber:SetLabel( "ROUND" )
                        Bar:AddItem( RoundNumber )
                       
                        local RoundTimer = vgui.Create( "DHudCountdown" );
                                RoundTimer:SizeToContents()
                                RoundTimer:SetValueFunction( function()
                                    if ( GetGlobalFloat( "RoundStartTime", 0 ) > CurTime() ) then return GetGlobalFloat( "RoundStartTime", 0 )  end
                                    return GetGlobalFloat( "RoundEndTime" ) end )
                                RoundTimer:SetLabel( "TIME" )
                        Bar:AddItem( RoundTimer )
 
                end
               
        end
 
end

function GM:AddScoreboardDeaths( ScoreBoard )
        local f = function( ply ) return ply:GetNetworkedInt("bounty") end
        ScoreBoard:AddColumn( "Bounty", 50, f, 0.5, nil, 6, 6 )
end

function GM:AddScoreboardKills( ScoreBoard )
        local f = function( ply ) return ply:Frags() end
        ScoreBoard:AddColumn( "Frags", 50, f, 0.5, nil, 6, 6 )
end

local CircleMat = Material( "SGM/playercircle" );
function GM:DrawPlayerRing( pPlayer )
 
        if ( !IsValid( pPlayer ) ) then return end
        if ( !pPlayer:GetNWBool( "DrawRing", false ) ) then return end
        if ( !pPlayer:Alive() ) then return end
       
        local trace = {}
        trace.start     = pPlayer:GetPos() + Vector(0,0,50)
        trace.endpos    = trace.start + Vector(0,0,-300)
        trace.filter    = pPlayer
       
        local tr = util.TraceLine( trace )
       
        if not tr.HitWorld then
                tr.HitPos = pPlayer:GetPos()
        end
		
		local clr   = pPlayer:GetNWString( "NameColor", -1 )
		local color = Color(255,255,255,255)
		if ( clr && clr != -1 && clr != "" ) then
			color = list.Get( "PlayerColours" )[ clr ]
		end
		color.a = 40;
 
        render.SetMaterial( CircleMat )
        render.DrawQuadEasy( tr.HitPos + tr.HitNormal, tr.HitNormal, GAMEMODE.PlayerRingSize, GAMEMODE.PlayerRingSize, color ) 
 
end