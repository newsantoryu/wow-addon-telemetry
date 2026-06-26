local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event, unit)
    -- Só queremos monitorar a vida do próprio jogador ("player")
    if event == "UNIT_HEALTH" and unit ~= "player" then return end

    if not AlertaVidaDB then AlertaVidaDB = {} end

    local vidaAtual = UnitHealth("player")
    local vidaMaxima = UnitHealthMax("player")
    
    if vidaMaxima > 0 then
        local porcentagem = (vidaAtual / vidaMaxima) * 100
        local statusBixo = "normal"

        -- Define o status se a vida estiver abaixo de 40%
        if porcentagem <= 44 then
            statusBixo = "perigo"
        end

        -- Só atualiza o arquivo se o estado realmente mudou
        if AlertaVidaDB["status"] ~= statusBixo then
            AlertaVidaDB["status"] = statusBixo
            AlertaVidaDB["timestamp"] = time()
            print("|cFFFF0000[AlertaVida]:|r Status alterado para: " .. statusBixo)
        end
    end
end)
