-- Cargar biblioteca de interfaz de usuario
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/UI-Library/main/source.lua"))()
local Window = Library:CreateWindow("Anime Adventures | Rollback")

-- Crear pestañas en la UI
local RollbackTab = Window:CreateFolder("Rollback")

-- Variables de almacenamiento
local savedTraits = nil
local selectedUnit = nil

-- Función para guardar el estado actual de los traits
local function saveTraits()
    if game.Players.LocalPlayer and game.Players.LocalPlayer.TraitInventory then
        savedTraits = game.Players.LocalPlayer.TraitInventory:GetChildren()
        print("Traits guardados correctamente.")
    else
        print("Error: No se pudo guardar los traits.")
    end
end

-- Función para hacer rollback de los traits
local function rollbackTraits()
    if savedTraits then
        for _, trait in pairs(savedTraits) do
            trait.Parent = game.Players.LocalPlayer.TraitInventory
        end
        print("Rollback aplicado con éxito.")
    else
        print("Error: No hay traits guardados para restaurar.")
    end
end

-- Botones en la UI para guardar y hacer rollback
RollbackTab:Button("Guardar Traits", saveTraits)
RollbackTab:Button("Hacer Rollback", rollbackTraits)
