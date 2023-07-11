local hasEnteredFirstPerson = false
local firstPersonSpeed = 2.0 -- Vitesse de marche en vue à la première personne
local normalSpeed = 2.0 -- Vitesse de marche normale

-- Détermine si le joueur est en vue à la première personne
function IsPlayerInFirstPerson()
    return GetFollowPedCamViewMode() == 4
end

-- Événement appelé lorsqu'un joueur entre en vue à la première personne
RegisterNetEvent('playerEnteredFirstPerson')
AddEventHandler('playerEnteredFirstPerson', function()
    SetPlayerSpeed(firstPersonSpeed)
    SetPedMovementClipset(PlayerPedId(), "move_m@_idles@first_person", true)
end)

-- Événement appelé lorsqu'un joueur quitte la vue à la première personne
RegisterNetEvent('playerLeftFirstPerson')
AddEventHandler('playerLeftFirstPerson', function()
    SetPlayerSpeed(normalSpeed)
    ResetPedMovementClipset(PlayerPedId())
end)

-- Vérifier périodiquement si le joueur est en première personne et déclencher les événements appropriés
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Vérifie toutes les 500 millisecondes (2 fois par seconde)

        local isInFirstPerson = IsPlayerInFirstPerson()

        if isInFirstPerson then
            -- Si le joueur est en première personne mais n'a pas encore déclenché l'événement
            if not hasEnteredFirstPerson then
                hasEnteredFirstPerson = true
                TriggerEvent('playerEnteredFirstPerson')
            end
        else
            -- Si le joueur n'est pas en première personne mais avait précédemment déclenché l'événement
            if hasEnteredFirstPerson then
                hasEnteredFirstPerson = false
                TriggerEvent('playerLeftFirstPerson')
            end
        end
    end
end)

-- Définir la vitesse du joueur
function SetPlayerSpeed(speed)
    local playerPed = PlayerPedId()
    SetEntityMaxSpeed(playerPed, speed)
end
