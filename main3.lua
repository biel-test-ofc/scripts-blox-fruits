-- BIBI HUB: XP FARM COMBAT v1.1 ⭐ (main3.lua)
-- ✅ Auto-detecta NPCs | Escolha: Fruta / Combate / Espada
-- ✅ Fundo main.jpeg | ON/OFF | Servidor | Mobile-friendly
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "1.1-Combat",
    CorPrincipal = Color3.fromRGB(255, 105, 180), -- Rosa Bibi 💖
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true,
    PodeTrocarServidor = false,
    ModoAtaque = "Espada", -- Opções: "Fruta", "Combate", "Espada"
    Alcance = 150 -- Distância para detectar inimigos
}

-- Serviços
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui")
local Personagem, Raiz, Humano, AlvoAtual

-- 🔹 Fundo: main.jpeg (mesma pasta)
local function CarregarFundo(container)
    local FundoImagem = Instance.new("ImageLabel", container)
    FundoImagem.Name = "FundoBibi"
    FundoImagem.Size = UDim2.new(1, 0, 1, 0)
    FundoImagem.Position = UDim2.new(0, 0, 0, 0)
    FundoImagem.BackgroundTransparency = 1
    FundoImagem.ZIndex = -10
    FundoImagem.ScaleType = Enum.ScaleType.StretchToFill

    local sucesso, _ = pcall(function()
        FundoImagem.Image = "rbxasset://main.jpeg"
    end)

    if not sucesso then
        FundoImagem:Destroy()
        container.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
        print("⚠️ main.jpeg não encontrado — fundo padrão")
    else
        container.BackgroundTransparency = 0.2
        print("✅ Fundo carregado: main.jpeg")
    end
end

-- 🔹 Tela de Carregamento
local function TelaCarregamento()
    local Tela = Instance.new("ScreenGui", Gui)
    Tela.Name = "Bibi_LoadXP"
    local Fundo = Instance.new("Frame", Tela)
    Fundo.Size = UDim2.new(1,0,1,0)
    CarregarFundo(Fundo)
    
    local Titulo = Instance.new("TextLabel", Fundo)
    Titulo.Size = UDim2.new(0,300,0,60)
    Titulo.Position = UDim2.new(0.5,-150,0.4,-30)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "💖 BIBI HUB - XP COMBAT"
    Titulo.TextColor3 = BibiHub.CorPrincipal
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    
    task.wait(0.8)
    Tela:Destroy()
end

-- 🔹 Interface Completa + CONFIGURAÇÕES
local function CriarInterface()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_XPCombat"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.05,0)
    Janela.Size = UDim2.new(0,340,0,450)
    Janela.BorderSizePixel = 0
    Janela.ClipsDescendants = true
    CarregarFundo(Janela)
    
    -- Cabeçalho
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,40)
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    Cab.ZIndex = 5
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "💖 BIBI HUB - ⚔️ XP FARM"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    
    -- Botão ON/OFF
    local BtnOnOff = Instance.new("TextButton", Janela)
    BtnOnOff.Position = UDim2.new(0.05,0,0.11,0)
    BtnOnOff.Size = UDim2.new(0.4,0,0,35)
    BtnOnOff.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnOnOff.Text = "🟢 LIGADO"
    BtnOnOff.TextColor3 = Color3.new(1,1,1)
    BtnOnOff.Font = Enum.Font.GothamBold
    BtnOnOff.ZIndex = 5
    
    -- Botão Servidor
    local BtnServidor = Instance.new("TextButton", Janela)
    BtnServidor.Position = UDim2.new(0.55,0,0.11,0)
    BtnServidor.Size = UDim2.new(0.4,0,0,35)
    BtnServidor.BackgroundColor3 = Color3.fromRGB(180,60,60)
    BtnServidor.Text = "🔒 Servidor: NÃO"
    BtnServidor.TextColor3 = Color3.new(1,1,1)
    BtnServidor.Font = Enum.Font.GothamBold
    BtnServidor.ZIndex = 5
    
    -- ⚙️ CONFIG: Escolha de Ataque
    local ConfigFrame = Instance.new("Frame", Janela)
    ConfigFrame.Position = UDim2.new(0.05,0,0.21,0)
    ConfigFrame.Size = UDim2.new(0.9,0,0.18,0)
    ConfigFrame.BackgroundColor3 = Color3.fromRGB(40,40,70,0.85)
    ConfigFrame.ZIndex = 5
    
    local ConfigTitulo = Instance.new("TextLabel", ConfigFrame)
    ConfigTitulo.Size = UDim2.new(1,0,0,25)
    ConfigTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    ConfigTitulo.Text = "⚙️ Modo de Ataque"
    ConfigTitulo.TextColor3 = Color3.new(1,1,1)
    ConfigTitulo.Font = Enum.Font.GothamBold
    ConfigTitulo.TextScaled = true
    
    -- Botões de alternância
    local BtnEspada = Instance.new("TextButton", ConfigFrame)
    BtnEspada.Position = UDim2.new(0.05,0,0.4,0)
    BtnEspada.Size = UDim2.new(0.28,0,0,28)
    BtnEspada.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnEspada.Text = "🗡️ Espada"
    BtnEspada.TextColor3 = Color3.new(1,1,1)
    BtnEspada.Font = Enum.Font.GothamBold
    BtnEspada.ZIndex = 5
    
    local BtnCombate = Instance.new("TextButton", ConfigFrame)
    BtnCombate.Position = UDim2.new(0.38,0,0.4,0)
    BtnCombate.Size = UDim2.new(0.28,0,0,28)
    BtnCombate.BackgroundColor3 = Color3.fromRGB(80,80,120)
    BtnCombate.Text = "👊 Luta"
    BtnCombate.TextColor3 = Color3.new(1,1,1)
    BtnCombate.Font = Enum.Font.GothamBold
    BtnCombate.ZIndex = 5
    
    local BtnFruta = Instance.new("TextButton", ConfigFrame)
    BtnFruta.Position = UDim2.new(0.71,0,0.4,0)
    BtnFruta.Size = UDim2.new(0.24,0,0,28)
    BtnFruta.BackgroundColor3 = Color3.fromRGB(80,80,120)
    BtnFruta.Text = "🍎 Fruta"
    BtnFruta.TextColor3 = Color3.new(1,1,1)
    BtnFruta.Font = Enum.Font.GothamBold
    BtnFruta.ZIndex = 5
    
    -- Status do Alvo
    local StatusFrame = Instance.new("Frame", Janela)
    StatusFrame.Position = UDim2.new(0.05,0,0.42,0)
    StatusFrame.Size = UDim2.new(0.9,0,0.22,0)
    StatusFrame.BackgroundColor3 = Color3.fromRGB(35,35,65,0.8)
    StatusFrame.ZIndex = 5
    
    local AlvoTxt = Instance.new("TextLabel", StatusFrame)
    AlvoTxt.Position = UDim2.new(0,0,0,0)
    AlvoTxt.Size = UDim2.new(1,0,0.5,0)
    AlvoTxt.BackgroundTransparency = 1
    AlvoTxt.Text = "🎯 Alvo: Nenhum"
    AlvoTxt.TextColor3 = Color3.new(1,1,1)
    AlvoTxt.Font = Enum.Font.GothamSemibold
    AlvoTxt.TextScaled = true
    
    local VidaTxt = Instance.new("TextLabel", StatusFrame)
    VidaTxt.Position = UDim2.new(0,0,0.5,0)
    VidaTxt.Size = UDim2.new(1,0,0.5,0)
    VidaTxt.BackgroundTransparency = 1
    VidaTxt.Text = "❤️ Vida: --"
    VidaTxt.TextColor3 = Color3.fromRGB(255,100,100)
    VidaTxt.Font = Enum.Font.GothamSemibold
    VidaTxt.TextScaled = true
    
    -- Lista de Inimigos Próximos
    local ListaFrame = Instance.new("Frame", Janela)
    ListaFrame.Position = UDim2.new(0.05,0,0.66,0)
    ListaFrame.Size = UDim2.new(0.9,0,0.30,0)
    ListaFrame.BackgroundColor3 = Color3.fromRGB(30,30,55,0.7)
    ListaFrame.ZIndex = 5
    
    local ListaTitulo = Instance.new("TextLabel", ListaFrame)
    ListaTitulo.Size = UDim2.new(1,0,0,25)
    ListaTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    ListaTitulo.Text = "👾 Inimigos Próximos"
    ListaTitulo.TextColor3 = Color3.new(1,1,1)
    ListaTitulo.Font = Enum.Font.GothamBold
    ListaTitulo.TextScaled = true
    
    local ListaInimigos = Instance.new("TextLabel", ListaFrame)
    ListaInimigos.Position = UDim2.new(0,0,0,28)
    ListaInimigos.Size = UDim2.new(1,0,1,-28)
    ListaInimigos.BackgroundTransparency = 1
    ListaInimigos.Text = "Procurando..."
    ListaInimigos.TextColor3 = Color3.new(0.8,0.8,0.8)
    ListaInimigos.Font = Enum.Font.GothamSemibold
    ListaInimigos.TextScaled = true
    ListaInimigos.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 🔄 Eventos de Configuração
    local function AtualizarModo(ativo)
        BtnEspada.BackgroundColor3 = ativo=="Espada" and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,120)
        BtnCombate.BackgroundColor3 = ativo=="Combate" and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,120)
        BtnFruta.BackgroundColor3 = ativo=="Fruta" and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,120)
        BibiHub.ModoAtaque = ativo
    end
    
    BtnEspada.MouseButton1Click:Connect(function() AtualizarModo("Espada") end)
    BtnCombate.MouseButton1Click:Connect(function() AtualizarModo("Combate") end)
    BtnFruta.MouseButton1Click:Connect(function() AtualizarModo("Fruta") end)
    
    -- ON/OFF
    BtnOnOff.MouseButton1Click:Connect(function()
        BibiHub.Ativo = not BibiHub.Ativo
        BtnOnOff.BackgroundColor3 = BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnOnOff.Text = BibiHub.Ativo and "🟢 LIGADO" or "🔴 DESLIGADO"
    end)
    
    -- Servidor
    BtnServidor.MouseButton1Click:Connect(function()
        BibiHub.PodeTrocarServidor = not BibiHub.PodeTrocarServidor
        BtnServidor.BackgroundColor3 = BibiHub.PodeTrocarServidor and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnServidor.Text = BibiHub.PodeTrocarServidor and "🔓 Servidor: SIM" or "🔒 Servidor: NÃO"
    end)
    
    return {
        Alvo = AlvoTxt,
        Vida = VidaTxt,
        Lista = ListaInimigos
    }
end

-- 🔹 Funções de Ataque
local function UsarHabilidade(tipo)
    if not Personagem then return end
    -- Simulação: Acessa ferramentas/habilidades conforme escolhido
    if tipo == "Espada" then
        pcall(function() Personagem:FindFirstChildWhichIsA("Tool") and Personagem:FindFirstChildWhichIsA("Tool"):Activate() end)
    elseif tipo == "Combate" then
        pcall(function() UserInputService.InputBegan:Fire({KeyCode=Enum.KeyCode.Mouse1}, {}) end)
    elseif tipo == "Fruta" then
        pcall(function() 
            for _,f in pairs(Personagem:GetChildren()) do
                if f:IsA("Tool") and (f.Name:find("Fruit") or f.Name:find("Fruta")) then f:Activate() end
            end
        end)
    end
end

-- 🔹 Loop Principal: Busca NPC + Ataque
local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        -- Atualiza personagem
        Personagem = Jogador.Character
        if not Personagem then 
            ui.Alvo.Text = "⚠️ Sem personagem" return 
        end
        Raiz = Personagem:FindFirstChild("HumanoidRootPart")
        Humano = Personagem:FindFirstChild("Humanoid")
        if not Raiz or not Humano then return end
        
        -- Pausa se desligado
        if not BibiHub.Ativo then
            AlvoAtual = nil
            ui.Alvo.Text = "⏸️ Pausado"
            ui.Lista.Text = "---"
            return
        end
        
        -- 🔍 Busca NPCs/Inimigos
        local MelhorAlvo, MenorDist = nil, math.huge
        local ListaNomes = ""
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            -- Detecta NPCs/inimigos (padrão Blox Fruits)
            local EhInimigo = obj:IsA("Model") and obj:FindFirstChild("Humanoid") 
                and obj ~= Personagem 
                and not obj:IsDescendantOf(Players)
            
            if EhInimigo then
                local Parte = obj.PrimaryPart
                if Parte then
                    local Dist = (Raiz.Position - Parte.Position).Magnitude
                    if Dist < BibiHub.Alcance then
                        ListaNomes = ListaNomes .. "• " .. obj.Name .. " ("..math.floor(Dist).."m)\n"
                        if Dist < MenorDist and obj.Humanoid.Health > 0 then
                            MenorDist = Dist
                            MelhorAlvo = obj
                        end
                    end
                end
            end
        end
        
        -- Atualiza interface
        if ListaNomes == "" then ListaNomes = "Nenhum inimigo próximo" end
        ui.Lista.Text = ListaNomes
        
        -- Se tem alvo: atacar
        AlvoAtual = MelhorAlvo
        if AlvoAtual and AlvoAtual:FindFirstChild("Humanoid") and AlvoAtual.Humanoid.Health > 0 then
            local AlvoParte = AlvoAtual.PrimaryPart
            ui.Alvo.Text = "🎯 Alvo: " .. AlvoAtual.Name
            ui.Vida.Text = "❤️ Vida: " .. math.floor(AlvoAtual.Humanoid.Health) .. "/" .. math.floor(AlvoAtual.Humanoid.MaxHealth)
            
            -- Volta para o alvo
            Raiz.CFrame = CFrame.new(Raiz.Position, Vector3.new(AlvoParte.Position.X, Raiz.Position.Y, AlvoParte.Position.Z))
            
            -- ⚔️ Ataque conforme escolha
            UsarHabilidade(BibiHub.ModoAtaque)
        else
            ui.Alvo.Text = "🎯 Alvo: Nenhum/Morto"
            ui.Vida.Text = "---"
        end
    end)
end

-- 🚀 Iniciar tudo
coroutine.wrap(function()
    TelaCarregamento()
    local Interface = CriarInterface()
    Iniciar(Interface)
    print("💖 Bibi Hub XP Combat Pronto! (main3.lua)")
end)()