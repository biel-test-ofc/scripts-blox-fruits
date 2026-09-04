-- BIBI HUB: FRUIT FINDER v1.5 ✅ TELA VISÍVEL
-- Corrige fundo cinza | main.jpeg obrigatória na pasta
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "1.5-Fix",
    CorPrincipal = Color3.fromRGB(255, 105, 180),
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui", 10)

-- ✅ Fundo SEGURO: Se main.jpeg falhar → cor sólida
local function CarregarFundo(container)
    -- Fundo de segurança SEMPRE visível
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    container.BackgroundTransparency = 0

    -- Tenta imagem, sem quebrar
    pcall(function()
        local img = Instance.new("ImageLabel", container)
        img.Name = "Fundo"
        img.Size = UDim2.new(1,0,1,0)
        img.ZIndex = -1
        img.Image = "rbxasset://main.jpeg"
        img.ScaleType = Enum.ScaleType.StretchToFill
        img.BackgroundTransparency = 0.3
    end)
end

-- ✅ Interface FORÇADAMENTE VISÍVEL
local function CriarUI()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_Fruit"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Main.Enabled = true
    Main.ResetOnSpawn = false

    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.08,0)
    Janela.Size = UDim2.new(0,320,0,400)
    Janela.BackgroundTransparency = 0
    Janela.BorderSizePixel = 0
    CarregarFundo(Janela)

    -- Cabeçalho
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,40)
    Cab.Position = UDim2.new(0,0,0,0)
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    Cab.ZIndex = 10
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "🍎 BIBI HUB - FRUTAS"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true

    -- ON/OFF
    local Btn = Instance.new("TextButton", Janela)
    Btn.Position = UDim2.new(0.05,0,0.15,0)
    Btn.Size = UDim2.new(0.9,0,0,40)
    Btn.BackgroundColor3 = Color3.fromRGB(60,180,80)
    Btn.Text = "🟢 FUNCIONANDO"
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    Btn.ZIndex = 10

    -- Status
    local Status = Instance.new("TextLabel", Janela)
    Status.Position = UDim2.new(0.05,0,0.28,0)
    Status.Size = UDim2.new(0.9,0,0,25)
    Status.BackgroundTransparency = 1
    Status.Text = "✅ Interface carregada!"
    Status.TextColor3 = Color3.new(1,1,1)
    Status.Font = Enum.Font.GothamSemibold
    Status.ZIndex = 10

    return Main
end

-- Início seguro
local Ok, Err = pcall(function()
    local ui = CriarUI()
    ui.Parent = Gui
    print("✅ Bibi Hub OK!")
end)

if not Ok then
    warn("ERRO:", Err)
    -- Tela de erro visível
    local ErrGui = Instance.new("ScreenGui", Gui)
    local Txt = Instance.new("TextLabel", ErrGui)
    Txt.Size = UDim2.new(0,300,0,100)
    Txt.Position = UDim2.new(0.5,-150,0.5,-50)
    Txt.BackgroundColor3 = Color3.new(1,0,0)
    Txt.Text = "ERRO: Verifique main.jpeg"
    Txt.TextColor3 = Color3.new(1,1,1)
    Txt.Font = Enum.Font.GothamBold
    ErrGui.Parent = Gui
end