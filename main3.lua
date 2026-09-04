-- BIBI HUB: XP COMBAT v1.5 ✅ TELA NÃO CINZA
-- Auto-ataca NPCs | Escolha: Espada/Fruta/Luta | Fundo Seguro
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "1.5-XP-Fix",
    CorPrincipal = Color3.fromRGB(255, 105, 180),
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true,
    ModoAtaque = "Espada",
    Alcance = 150
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui", 10)
local Personagem, Raiz, AlvoAtual

-- 🔹 FUNDO SEGURO
local function CarregarFundo(container)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 55)
    container.BackgroundTransparency = 0
    container.BorderSizePixel = 0

    pcall(function()
        local Img = Instance.new("ImageLabel", container)
        Img.Size = UDim2.new(1,0,1,0)
        Img.ZIndex = -1
        Img.Image = "rbxasset://main.jpeg"
        Img.ScaleType = Enum.ScaleType.StretchToFill
        Img.BackgroundTransparency = 0.25
    end)
end

-- Tela de entrada
local function TelaCarregamento()
    local Tela = Instance.new("ScreenGui", Gui)
    local Fundo = Instance.new("Frame", Tela)
    Fundo.Size = UDim2.new(1,0,1,0)
    Fundo.BackgroundColor3 = Color3.fromRGB(15,15,40)
    local Titulo = Instance.new("TextLabel", Fundo)
    Titulo.Size = UDim2.new(0,300,0,60)
    Titulo.Position = UDim2.new(0.5,-150,0.4,-30)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "💖 BIBI HUB - XP FARM"
    Titulo.TextColor3 = BibiHub.CorPrincipal
    Titulo.Font = Enum.Font.GothamBold
    task.wait(0.6)
    Tela:Destroy()
end

-- Interface Completa
local function CriarInterface()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_XP"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.05,0)
    Janela.Size = UDim2.new(0,340,0,440)
    CarregarFundo(Janela)

    -- Cabeçalho
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,40)
    Cab.ZIndex = 10
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "⚔️ XP FARM COMBAT"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true

    -- ON/OFF
    local BtnOnOff = Instance.new("TextButton", Janela)
    BtnOnOff.Position = UDim2.new(0.05,0,0.12,0)
    BtnOnOff.Size = UDim2.new(0.4,0,0,35)
    BtnOnOff.ZIndex = 10
    BtnOnOff.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnOnOff.Text = "🟢 LIGADO"
    BtnOnOff.TextColor3 = Color3.new(1,1,1)
    BtnOnOff.Font = Enum.Font.GothamBold

    -- Config Ataque
    local Config = Instance.new("Frame", Janela)
    Config.Position = UDim2.new(0.05,0,0.22,0)
    Config.Size = UDim2.new(0.9,0,0.18,0)
    Config.ZIndex = 10
    Config.BackgroundColor3 = Color3.fromRGB(40,40,80,0.8)

    local CTitulo = Instance.new("TextLabel", Config)
    CTitulo.Size = UDim2.new(1,0,0,26)
    CTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    CTitulo.Text = "Modo de Ataque"
    CTitulo.TextColor3 = Color3.new(1,1,1)
    CTitulo.Font = Enum.Font.GothamBold

    local BtnEspada = Instance.new("TextButton", Config)
    BtnEspada.Position = UDim2.new(0.05,0,0.4,0)
    BtnEspada.Size = UDim2.new(0.28,0,0,28)
    BtnEspada.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnEspada.Text = "🗡️ Espada"
    BtnEspada.ZIndex = 10

    local BtnLuta = Instance.new("TextButton", Config)
    BtnLuta.Position = UDim2.new(0.38,0,0.4,0)
    BtnLuta.Size = UDim2.new(0.28,0,0,28)
    BtnLuta.BackgroundColor3 = Color3.fromRGB(80,80,130)
    BtnLuta.Text = "👊 Luta"
    BtnLuta.ZIndex = 10

    local BtnFruta = Instance.new("TextButton", Config)
    BtnFruta.Position = UDim2.new(0.71,0,0.4,0)
    BtnFruta.Size = UDim2.new(0.24,0,0,28)
    BtnFruta.BackgroundColor3 = Color3.fromRGB(80,80,130)
    BtnFruta.Text = "🍎 Fruta"
    BtnFruta.ZIndex = 10

    -- Alvo
    local AlvoTxt = Instance.new("TextLabel", Janela)
    AlvoTxt.Position = UDim2.new(0.05,0,0.43,0)
    AlvoTxt.Size = UDim2.new(0.9,0,0,28)
    AlvoTxt.BackgroundTransparency = 1
    AlvoTxt.ZIndex = 10
    AlvoTxt.Text = "🎯 Alvo: Procurando..."
    AlvoTxt.TextColor3 = Color3.new(1,1,1)
    AlvoTxt.Font = Enum.Font.GothamSemibold

    -- Lista
    local Lista = Instance.new("TextLabel", Janela)
    Lista.Position = UDim2.new(0.05,0,0.55,0)
    Lista.Size = UDim2.new(0.9,0,0.40,0)
    Lista.BackgroundColor3 = Color3.fromRGB(35,35,70,0.7)
    Lista.ZIndex = 10
    Lista.Text = "Inimigos próximos..."
    Lista.TextColor3 = Color3.new(0.9,0.9,0.9)
    Lista.Font = Enum.Font.GothamSemibold
    Lista.TextXAlignment = Enum.TextXAlignment.Left

    -- Eventos
    BtnOnOff.MouseButton1Click:Connect(function()
        BibiHub.Ativo = not BibiHub.Ativo
        BtnOnOff.BackgroundColor3 = BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnOnOff.Text = BibiHub.Ativo and "🟢 LIGADO" or "🔴 DESLIGADO"
    end)

    local function MudarModo(modo)
        BibiHub.ModoAtaque = modo
        BtnEspada.BackgroundColor3 = modo=="Espada" and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,130)
        BtnLuta.BackgroundColor3 = modo=="Combate" and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,130)
        BtnFruta.BackgroundColor3 = modo=="Fruta" and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,130)
    end
    BtnEspada.MouseButton1Click:Connect(function() MudarModo("Espada") end)
    BtnLuta.MouseButton1Click:Connect(function() MudarModo("Combate") end)
    BtnFruta.MouseButton1Click:Connect(function() MudarModo("Fruta") end)

    return {Alvo=AlvoTxt, Lista=Lista}
end

-- Ataque
local function Atacar()
    if not Personagem then return end
    pcall(function()
        local ferramenta = Personagem:FindFirstChildWhichIsA("Tool")
        if ferramenta then ferramenta:Activate() end
    end)
end

-- Loop
local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem = Jogador.Character
        Raiz = Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        if not BibiHub.Ativo or not Raiz then
            ui.Alvo.Text = "⏸️ Parado"
            return
        end

        local MelhorAlvo, MinDist, ListaTxt = nil, math.huge, ""
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= Personagem 
               and not obj:IsDescendantOf(Players) and obj.Humanoid.Health > 0 then
                local Parte = obj.PrimaryPart
                if Parte then
                    local d = (Raiz.Position - Parte.Position).Magnitude
                    if d < BibiHub.Alcance then
                        ListaTxt = ListaTxt.."• "..obj.Name.." ("..math.floor(d).."m)\n"
                        if d < MinDist then MinDist = d; MelhorAlvo = obj end
                    end
                end
            end
        end

        ui.Lista.Text = ListaTxt ~= "" and ListaTxt or "Nenhum inimigo"
        AlvoAtual = MelhorAlvo

        if AlvoAtual and AlvoAtual.PrimaryPart then
            ui.Alvo.Text = "🎯 Alvo: "..AlvoAtual.Name
            Raiz.CFrame = CFrame.new(Raiz.Position, Vector3.new(AlvoAtual.PrimaryPart.Position.X, Raiz.Position.Y, AlvoAtual.PrimaryPart.Position.Z))
            Atacar()
        else
            ui.Alvo.Text = "🎯 Nenhum alvo"
        end
    end)
end

-- Iniciar
coroutine.wrap(function()
    local ok, err = pcall(function()
        TelaCarregamento()
        local ui = CriarInterface()
        Iniciar(ui)
        print("✅ Bibi Hub XP OK")
    end)
    if not ok then warn("ERRO XP:", err) end
end)()