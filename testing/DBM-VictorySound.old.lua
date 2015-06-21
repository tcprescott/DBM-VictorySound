local rev = 10901

local L = DBM_VictorySound_Translations

-- enables debugging messages
local debugmsg_setting = true;

-- path to DBM-VictorySound sounds folder, shouldn't be changed
local path = "Interface\\AddOns\\DBM-VictorySound\\sounds\\"

local function debugmsg(msg) {
	if debugmsg_setting then
		print("DBMVS: " .. msg)
	end
}

local default_settings = {
    enabled = true,
	revision = rev,
	wipeSound = true,
    victorySound = true,
    startSound = true,
    wipePath = 'defeat.mp3',
    victoryPath = 'victory.mp3',
    startPath = 'start.mp3',
    musicDisable = true,
    masterSound = true,
	wipeSoundList = {
		'defeat.mp3',
		'PIRdefeat.mp3',
		'SMB3defeat.mp3',
		'SMWdefeat.mp3',
		'KCdefeat.mp3',
	}
	victorySoundList = {
	    'victory.mp3',
	    'SMB3victory.mp3',
	    'SMBvictory.mp3',
	    'SMRPGvictory.mp3',
	    'FFvictory.mp3',
	    'FFvictoryclassic.mp3',
	    'FFvictorylong.mp3',
	}
	startSoundList = {
	    'start.mp3',
	    'SMB3start.mp3',
	    'SMWstart.mp3',
	    'SMRPGstart.mp3',
	    'WCstart.mp3',
	    'SMRidleyStart.mp3',
	    'FFstart.mp3',
	    'FFXstart.mp3',
	}
}



DBM_VictorySound_Settings = {}
local settings = default_settings

local vs_startMusicPlaying = false;

--local settings = DBM_VictorySound_Options
local mainframe = CreateFrame("Frame", L.VictorySound_Options, UIParent)

local addDefaultOptions

local function playVS(startMusic, test, playSound, wipe)
    if settings.enabled or test then
        if startMusic then
			if vs_startMusicPlaying then
				debugmsg("vs_startMusicPlaying prevented music from playing")
			else
	            if vsMusicSetting == nil then
	                vsMusicSetting = GetCVar("Sound_EnableMusic")
					debugmsg("CVar Sound_EnableMusic set to " .. vsMusicSetting)
	            end
	            if settings.startSound then
	                if settings.musicDisable then
						debugmsg("Sound_EnableMusic set to 1")
	                    SetCVar("Sound_EnableMusic",1)
	                end
	                PlayMusic(path .. settings.startPath);
					debugmsg("Music started")
	            end
			end
			vs_startMusicPlaying = true;
        elseif not startMusic then
			if playSound then
				if wipe then
		            if settings.musicDisable then
						debugmsg("Sound_EnableMusic set to " .. vsMusicSetting)
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
						debugmsg("CVAR Sound_EnableMusic set to " .. vsMusicSetting)
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
			elseif not playSound then
	            if settings.musicDisable == true then
					debugmsg("CVAR Sound_EnableMusic set to " .. vsMusicSetting)
	                SetCVar("Sound_EnableMusic",vsMusicSettings)
	            end
	            vsMusicSetting = nil
			end
			vs_startMusicPlaying = false;
		end
	else
		debugmsg("vsPlay blocked due to addon settings")
	end
end
    
SLASH_KILLVS1 = '/killvs';
local function slashhandler(msg, editBox)
	playVS(false, true, false, true)
	debugmsg("killed music usic /killvs")
end
SlashCmdList["KILLVS"] = slashhandler;
	
-- Ripped from DBM-Core.
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function toboolean(var) 
    if var then return true else return false end
end

local function createpanel()
	-- creates first panel, which is the main VS
    panel = DBM_GUI:CreateNewPanel(L.MainTab .. rev, "option")
        do
			local area = panel:CreateArea(L.AreaEnable, nil, 50, true)
			local enabled = area:CreateCheckButton(L.Activate, true)
            
            local area2 = panel:CreateArea(L.AreaGeneral, nil, 310, true)
            local wipeSound = area2:CreateCheckButton(L.VictorySound_Wipe, true)
            local victorySound = area2:CreateCheckButton(L.VictorySound_Victory, true)
            local masterSound = area2:CreateCheckButton(L.MasterSound, true)
            local startSound = area2:CreateCheckButton(L.VictorySound_Start, true)
            local musicDisable = area2:CreateCheckButton(L.VictorySound_DisableMusic, true)
            local startWarning = area2:CreateText(L.StartWarning, 350, true, nil, "left")
            startWarning:SetPoint("TOPLEFT", area2.frame, "TOPLEFT", 20, -140)
            
			enabled:SetScript("OnClick", 		    function(self) settings.enabled = toboolean(self:GetChecked()) end)
			enabled:SetScript("OnShow", 		    function(self) self:SetChecked(settings.enabled) end)
           
            wipeSound:SetScript("OnClick", 		    function(self) settings.wipeSound = toboolean(self:GetChecked()) end)
			wipeSound:SetScript("OnShow", 		    function(self) self:SetChecked(settings.wipeSound) end)
            victorySound:SetScript("OnClick", 		function(self) settings.victorySound = toboolean(self:GetChecked()) end)
			victorySound:SetScript("OnShow", 		function(self) self:SetChecked(settings.victorySound) end)
            masterSound:SetScript("OnClick", 		function(self) settings.masterSound = toboolean(self:GetChecked()) end)
			masterSound:SetScript("OnShow", 		function(self) self:SetChecked(settings.masterSound) end)
            startSound:SetScript("OnClick", 		function(self) settings.startSound = toboolean(self:GetChecked()) end)
			startSound:SetScript("OnShow", 			function(self) self:SetChecked(settings.startSound) end)
            musicDisable:SetScript("OnClick", 		function(self) settings.musicDisable = toboolean(self:GetChecked()) end)
			musicDisable:SetScript("OnShow", 		function(self) self:SetChecked(settings.musicDisable) end)
            
            local resettool = area:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_VictorySound_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)
		end

	-- creates the victory options panel
	victoryOptionsPanel = panel:CreateNewPanel(L.VictoryOptionsSubtab, "option")
		do
			local area = victoryOptionsPanel:CreateArea(L.VictoryAreaPath, nil, nil, true)
			
            local victoryPath = area:CreateEditBox(L.VictoryPath, settings.victoryPath, 200)
            victoryPath:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 27, -30)
			
            local victoryPlay = area:CreateButton(L.Button_Play, 100, 20)
			victoryPlay:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 250, -30)
			
            victorySoundListDropdown = { }
            for i=1, getn(settings.victorySoundList), 1 do
				table.insert(victorySoundListDropdown, { text=settings.victorySoundList[i],value=i })
			end
            local victoryList = area:CreateDropdown(L.VictorySoundList, victorySoundListDropdown, settings.victoryPath, function(value) settings.victoryPath = settings.victorySoundList[value] victoryPath:SetText(settings.victorySoundList[value])  end, 200)
			victoryList:SetScript("OnShow", function(self) 
                table.wipe(victorySoundListDropdown)
                for i=1, getn(settings.victorySoundList), 1 do
                    table.insert(victorySoundListDropdown, { text=settings.victorySoundList[i],value=i })
                end
			end)
			
            victoryPath:SetScript("OnTextChanged", 	function(self) settings.victoryPath = self:GetText() end)
			victoryPath:SetScript("OnShow", 		function(self) self:SetText(settings.victoryPath) end)
            victoryPlay:SetScript("OnClick",        function(self) playVS(false, true, true, false) end)
			
            local resettool = area:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_VictorySound_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)
		end

	-- creates the defeat options panel
	defeatOptionsPanel = panel:CreateNewPanel(L.DefeatOptionsSubtab, "option")
		do
			local area = victoryOptionsPanel:CreateArea(L.DefeatAreaPath, nil, nil, true)
			
            local wipePath = area:CreateEditBox(L.WipePath, settings.wipePath, 200)
            wipePath:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 27, -30)
			
            local wipePlay = area:CreateButton(L.Button_Play, 100, 20)
			wipePlay:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 250, -30)
			
            wipeSoundListDropdown = { }
            for i=1, getn(settings.wipeSoundList), 1 do
				table.insert(wipeSoundListDropdown, { text=settings.wipeSoundList[i],value=i })
			end
            local wipeList = area:CreateDropdown(L.WipeSoundList, wipeSoundListDropdown, settings.wipePath, function(value) settings.wipePath = settings.wipeSoundList[value] wipePath:SetText(settings.wipeSoundList[value])  end, 200)
			wipeList:SetScript("OnShow", function(self) 
                table.wipe(wipeSoundListDropdown)
                for i=1, getn(settings.wipeSoundList), 1 do
                    table.insert(wipeSoundListDropdown, { text=settings.wipeSoundList[i],value=i })
                end
			end)
			
			wipeList:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 0, -70)
            wipePath:SetScript("OnTextChanged", 	function(self) settings.wipePath = self:GetText() end)
			wipePath:SetScript("OnShow", 		    function(self) self:SetText(settings.wipePath) end)
            wipePlay:SetScript("OnClick",           function(self) playVS(false, true, true, true) end)
			
            local resettool = area:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_VictorySound_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)
		end
		
	-- creates the start options panel
	startOptionsPanel = panel:CreateNewPanel(L.StartOptionsSubtab, "option")
		do
			local area = startOptionsPanel:CreateArea(L.StartAreaPath, nil, nil, true)
			
            local startPath = area:CreateEditBox(L.StartPath, settings.startPath, 200)
            startPath:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 27, -30)

            local startPlay = area:CreateButton(L.Button_Play, 100, 20)
            local startPlayStop = area:CreateButton(L.Button_Stop, 100, 20)
			startPlay:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 250, -30)
			startPlayStop:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 250, -60)

            startSoundListDropdown = { }
            for i=1, getn(settings.startSoundList), 1 do
				table.insert(startSoundListDropdown, { text=settings.startSoundList[i],value=i })
			end
            local startList = area:CreateDropdown(L.StartSoundList, startSoundListDropdown, settings.startPath, function(value) settings.startPath = setting.startSoundList[value] startPath:SetText(settings.startSoundList[value])  end, 200)
			startList:SetScript("OnShow", function(self) 
                table.wipe(startSoundListDropdown)
                for i=1, getn(settings.startSoundList), 1 do
                    table.insert(startSoundListDropdown, { text=settings.startSoundList[i],value=i })
                end
			end)
			startList:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 0, -70)
	
            startPath:SetScript("OnTextChanged", 	function(self) settings.startPath = self:GetText() end)
			startPath:SetScript("OnShow", 		function(self) self:SetText(settings.startPath) end)
            
            startPlay:SetScript("OnClick",        function(self) playVS(true, true, false, true) end)
            startPlayStop:SetScript("OnClick",        function(self) playVS(false, true, false, true); end)
			
            local resettool = area:CreateButton(L.Button_ResetSettings, 100, 16)
			resettool:SetPoint('BOTTOMRIGHT', area.frame, "TOPRIGHT", 0, 0)
			resettool:SetNormalFontObject(GameFontNormalSmall)
			resettool:SetHighlightFontObject(GameFontNormalSmall)
			resettool:SetScript("OnClick", function(self) 
				table.wipe(DBM_VictorySound_Settings)
				addDefaultOptions(settings, default_settings)

				DBM_GUI_OptionsFrame:Hide()
				DBM_GUI_OptionsFrame:Show()				
			end)
		end
end

DBM:RegisterOnGuiLoadCallback(createpanel, 25)

local function addDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" then
			addDefaultOptions(v, t2[i])
		end
	end
end

do
    mainframe:SetScript("OnEvent", function(self, event, ...)
        if event == "ADDON_LOADED" and select(1, ...) == "DBM-VictorySound" then
            -- Update settings of this Addon
            settings = DBM_VictorySound_Settings
            addDefaultOptions(settings, default_settings)
        end
    end)
        
    -- lets register the Events
    mainframe:RegisterEvent("ADDON_LOADED")
end

function DBM:VS_StartCombat(mod, delay, synced)
    -- Plays on start
	playVS(true, true, false)
    DBM:SavedStartCombat(mod, delay, synced);
end

DBM.SavedStartCombat = DBM.StartCombat;
DBM.StartCombat = DBM.VS_StartCombat;

function DBM:VS_EndCombat(mod, wipe)
	playVS(false, true, false, wipe)
    DBM:SavedEndCombat(mod, wipe);
end

DBM.SavedEndCombat = DBM.EndCombat;
DBM.EndCombat = DBM.VS_EndCombat;