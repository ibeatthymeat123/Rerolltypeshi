-- Cargar Orion Library para la UI
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Crear Ventana de la UI
local Window = OrionLib:MakeWindow({Name = "Anime Adventures | Rollback", HidePremium = false, SaveConfig = true, ConfigFolder = "AA_Rollback"})

-- Pestañas en la UI
local MainTab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local RollbackTab = Window:MakeTab({Name = "Rollback", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Variables para guardar los datos antes del reroll
local savedTraits = nil
local savedGems = nil

-- Función para guardar el estado actual
local function saveState()
    local player = game.Players.LocalPlayer
    if player and player:FindFirstChild("TraitInventory") then
        savedTraits = {}
        for _, trait in pairs(player.TraitInventory:GetChildren()) do
            table.insert(savedTraits, trait.Name)
        end
        savedGems = player:FindFirstChild("Gems") and player.Gems.Value or nil
        OrionLib:MakeNotification({
            Name = "Guardado",
            Content = "Estado guardado con éxito.",
            Time = 3
        })
    else
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "No se pudo guardar el estado.",
            Time = 3
        })
    end
end

-- Función para restaurar los traits y gemas
local function rollbackState()
    local player = game.Players.LocalPlayer
    if savedTraits and player:FindFirstChild("TraitInventory") then
        for _, traitName in pairs(savedTraits) do
            local newTrait = Instance.new("StringValue")
            newTrait.Name = traitName
            newTrait.Parent = player.TraitInventory
        end
        if savedGems then
            player.Gems.Value = savedGems
        end
        OrionLib:MakeNotification({
            Name = "Rollback",
            Content = "Estado restaurado con éxito.",
            Time = 3
        })
    else
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "No hay estado guardado para restaurar.",
            Time = 3
        })
    end
end

-- Botones en la UI
MainTab:AddButton({
    Name = "Guardar Estado",
    Callback = function()
        saveState()
    end
})

RollbackTab:AddButton({
    Name = "Hacer Rollback",
    Callback = function()
        rollbackState()
    end
})

OrionLib:Init()
