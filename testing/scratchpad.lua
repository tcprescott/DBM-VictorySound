function DBM:VS_EndCombat(mod, wipe)
	playVS(false, false, wipe)
    DBM:SavedEndCombat(mod, wipe);
end

----------------------

function DBM:VS_StartCombat(mod, delay, synced)
    -- Plays on start
	playVS(true, false)
    DBM:SavedStartCombat(mod, delay, synced);
end

-------------------------

local function playVS(startMusic, test, wipe)
	if startMusic then
		vs_startMusicPlaying = true;
	elseif not startMusic then
		vs_startMusicPlaying == false;
	end
		
    if settings.enabled or test then
        if startMusic then
            if vsMusicSetting == nil then
                vsMusicSetting = GetCVar("Sound_EnableMusic")
            end
            if settings.startSound then
                if settings.musicDisable then
                    SetCVar("Sound_EnableMusic",1)
                end
                PlayMusic(path .. settings.startPath);
            end
        elseif not startMusic then
			StopMusic()
			if wipe then
	            if settings.musicDisable then
	                SetCVar("Sound_EnableMusic",vsMusicSetting)
	            end 
	            vsMusicSetting = nil
	            if settings.wipeSound then
	                if settings.masterSound then
	                    PlaySoundFile(path .. settings.wipePath, "Master");
	                else
	                    PlaySoundFile(path .. settings.wipePath);
	                end
	            end
			elseif not wipe then
	            if settings.musicDisable == true then
	                SetCVar("Sound_EnableMusic",vsMusicSetting)
	            end
	            vsMusicSetting = nil
	            if settings.victorySound == true then
	                if settings.masterSound == true then
	                    PlaySoundFile(path .. settings.victoryPath, "Master");
	                else
	                    PlaySoundFile(path .. settings.victoryPath);
	                end
	            end
			end
		end
	end
end
