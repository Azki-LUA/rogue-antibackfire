-- This was not made by me, was made by Google Chrome
-- I am just editing it and adding things






pcall(function() for i,v in pairs(getconnections(game:service'ScriptContext'.Error)) do 
	v:Disconnect();
end end)


_G.FallionForgive = 5;

_G.spellsNeed = {
    ["Armis"] = {
        {min = 40, max = 60};
        {min = 70, max = 80};
    };
    ["Trickstus"] = {
        {min = 30, max = 70};
        {min = 30, max = 50};
    };
    ["Scrupus"] = {
        {min = 30, max = 100};
        {min = 30, max = 100};
    };
    ["Celeritas"] = {
        {min = 70, max = 90};
        {min = 70, max = 80};
    };
    ["Velo"] = {
        {min = 70, max = 100};
        {min = 40, max = 60};
    };
    ["Ignis"] = {
        {min = 80, max = 95};
        {min = 53, max = 57};
    };
    ["Gelidus"] = {
        {min = 80, max = 95};
        {min = 80, max = 100};
    };
    ["Viribus"] = {
        {min = 25, max = 35};
        {min = 60, max = 70};
    };
    ["Sagitta Sol"] = {
        {min = 50, max = 65};
        {min = 40, max = 60};
    };
    ["Tenebris"] = {
        {min = 90, max = 100};
        {min = 40, max = 60};
    };
    ["Nocere"] = {
        {min = 70, max = 85};
        {min = 70, max = 85};
    };
    ["Hystericus"] = {
        {min = 75, max = 90};
        {min = 15, max = 35};
    };
    ["Shrieker"] = {
        {min = 30, max = 50};
        {min = 30, max = 50};
    };
    ["Verdien"] = {
        {min = 75, max = 100};
        {min = 75, max = 85};
    };
    ["Contrarium"] = {
        {min = 80, max = 95};
        {min = 70, max = 90};
    };
    ["Floresco"] = {
        {min = 90, max = 100};
        {min = 80, max = 95};
    };
    ["Perflora"] = {
        {min = 70, max = 90};
        {min = 30, max = 50};
    };
    ["Manus Dei"] = {
        {min = 90, max = 95};
        {min = 50, max = 60};
    };
    ["Fons Vitae"] = {
        {min = 75, max = 100};
        {min = 75, max = 100};
    };
    ["Trahere"] = {
        {min = 75, max = 85};
        {min = 75, max = 85};
    };
    ["Furantur"] = {
        {min = 60, max = 80};
        {min = 60, max = 80};
    };
    ["Inferi"] = {
        {min = 10, max = 30};
        {min = 10, max = 30};
    };
    ["Howler"] = {
        {min = 60, max = 80};
        {min = 60, max = 80};
    };
    ["Secare"] = {
        {min = 90, max = 95};
        {min = 90, max = 95};
    };
    ["Ligans"] = {
        {min = 63, max = 80};
        {min = 63, max = 80};
    };
    ["Reditus"] = {
        {min = 50, max = 100};
        {min = 50, max = 100};
    };
    ["Fimbulvetr"] = {
        {min = 86, max = 90};
        {min = 70, max = 80};
    };
    ["Gate"] = {
        {min = 75, max = 80};
        {min = 75, max = 80};
    };
    ["Snarvindur"] = {
        {min = 60, max = 75};
        {min = 20, max = 30};
    };
    ["Hoppa"] = {
        {min = 40, max = 60};
        {min = 50, max = 60};
    };
    ["Percutiens"] = {
        {min = 60, max = 70};
        {min = 70, max = 80};
    };
    ["Dominus"] = {
        {min = 50, max = 100};
        {min = 50, max = 100};
    };
    ["Custos"] = {
        {min = 45, max = 65};
        {min = 45, max = 65};
    };
    ["Claritum"] = {
        {min = 90, max = 100};
        {min = 90, max = 100};
    };
    ["Globus"] = {
        {min = 70, max = 100};
        {min = 70, max = 100};
    };
    ["Intermissum"] = {
        {min = 70, max = 100};
        {min = 70, max = 100};
    };
}

local players = game:service'Players';
local player = players.LocalPlayer;
local remote = Instance.new'RemoteEvent';
local toggle = true;

local uIP = game:GetService'UserInputService';

function notify(text)
    starterGui:SetCore("SendNotification", {
        Title = "Anti-Backfire";
        Text = text;  
        Duration = 2;
    })
end

uIP.InputBegan:Connect(function(i, g)
    if g then return end
    local key = i.KeyCode;
    if key == Enum.KeyCode.T then
        toggle = not toggle;
        notify("anti backfire is "..(toggle and "enabled" or "disabled"))
    end
end)

local throwns = workspace.Thrown

local remoteNames = {
	["LeftClick"] = 1; -- normal
	["RightClick"] = 2; -- snap
}

local function checkForThrown(spell)
    local playername = player.Name;
    if not throwns:FindFirstChild(spell) then return false end;
    for i,v in pairs(throwns:GetChildren()) do
        if v.Name == spell then
            if v.Weld.Part0.Parent.Name == playername then
                return true;
            end
        end
    end
    return false
end

local function checkForTool(toolName)
    return player.Backpack:FindFirstChild(toolName) or player.Character:FindFirstChild(toolName)
end

local function getMageClass()
    if checkForTool("Furantur") or checkForTool("Globus") then return 15 end
    if checkForTool("Inferi") or checkForTool("Observe") or checkForTool("Perflora") then return 50 end
    return 100;
end

local oldfs;
oldfs = hookfunction(remote.FireServer, function(remote, ...)
	local args = {...};
	local castType = remoteNames[tostring(remote)];
    if castType and toggle then 
        local char = player.Character;
        if not char then return oldfs(remote, ...) end;
		local tool = char:FindFirstChildOfClass'Tool';
		if not tool then return oldfs(remote, ...) end;
		if not tool:FindFirstChild'Spell' then return oldfs(remote, ...) end;
        local backpack = player.Backpack;
        local isFallion = backpack:FindFirstChild'WiseCasting';
        local spellsNeed = _G.spellsNeed;
        local spell = tool.Name;
        local spellInfo = spellsNeed[spell][castType];
        local min = spellInfo.min;
        local max = spellInfo.max;
        local FallionForgive = _G.FallionForgive;
        local isNotSnap = castType==1;
        min = (isFallion and isNotSnap) and (min - FallionForgive) or min;
        max = (isFallion and isNotSnap) and (max + FallionForgive) or max;
        local mana = char.Mana.Value;
        if char.Artifacts:FindFirstChild'PhilosophersStone' then
            if mana > getMageClass() then
                return oldfs(remote, ...);
            end
        end
        if mana > min and mana < max then
            return oldfs(remote, ...);
        else
            if spell == "Tenebris" and castType == 2 then
                if checkForThrown("DarkBall") then
                    return oldfs(remote, ...);
                end
            elseif spell == "Gate" then
                if not char:FindFirstChild'Combat' and char:FindFirstChild'AzaelHorn' then
                    return oldfs(remote, ...);
                end
            elseif spell == "Velo" then
                if char:FindFirstChild'LightBall' then
                    return oldfs(remote, ...);
                end
            end
        end
        return nil;
	end
	return oldfs(remote, ...)
end)

notify("script inited")
