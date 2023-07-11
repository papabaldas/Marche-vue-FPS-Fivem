-- Vitesse de marche normale
local normalSpeed = 2.0

-- Vitesse de marche en vue à la première personne
local firstPersonSpeed = 2.0

-- Détermine si le joueur est en vue à la première personne
function IsPlayerInFirstPerson(playerId)
    local source = source
    local ped = GetPlayerPed(source)
    return GetFollowPedCamViewMode() == 4 and GetPedConfigFlag(ped, 184, true) == 1
end

-- Événement appelé lorsqu'un joueur entre en vue à la première personne
RegisterNetEvent('playerEnteredFirstPerson')
AddEventHandler('playerEnteredFirstPerson', function()
    local source = source
    SetPlayerSpeed(source, true)
end)

-- Événement appelé lorsqu'un joueur quitte la vue à la première personne
RegisterNetEvent('playerLeftFirstPerson')
AddEventHandler('playerLeftFirstPerson', function()
    local source = source
    SetPlayerSpeed(source, false)
end)

-- Définir la vitesse du joueur
function SetPlayerSpeed(playerId, isInFirstPerson)
    local speed = normalSpeed
    if isInFirstPerson then
        speed = firstPersonSpeed
    end

    local ped = GetPlayerPed(playerId)
    local maxSpeed = GetEntityMaxSpeed(ped)
    local speedMultiplier = speed / normalSpeed
    SetEntityMaxSpeed(ped, speedMultiplier * maxSpeed)
end
