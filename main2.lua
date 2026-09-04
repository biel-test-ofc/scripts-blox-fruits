-- BIBI HUB: BAÚS/TESOUROS v1.5 ✅ TELA NÃO CINZA
-- Fundo seguro + main.jpeg opcional | Sem pastas
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "1.5-Chest-Fix",
    CorPrincipal = Color3.fromRGB(255, 105, 180),
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true,
    PodeTrocarServidor = false
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui", 10)
local Personagem, Raiz

-- 🔹 FUNDO SEGURO: Nunca fica invisível/cinza
local function CarregarFundo(container)
    -- Cor base SEMPRE visível
    container.BackgroundColor3 = Color3.fromRGB(22, 22, 55)
    container.BackgroundTransparency = 0
    container.BorderSizePixel = 0

    -- Tenta imagem decorativa (não quebra se falhar)
    pcall(function()
        local FundoImg = Instance.new("ImageLabel", container)
        FundoImg.Name = "FundoDecor"
        FundoImg.Size = UDim2.new(1, 0, 1, 0)
        FundoImg.Position = UDim2.new(0, 0, 0, 0)
        FundoImg.ZIndex = -1
        FundoImg.Image = "rbxasset://main.jpeg"
        FundoImg.ScaleType = Enum.ScaleType.StretchToFill
        FundoImg.BackgroundTransparency = 0.25
    end)
end

-- 🔹 Tela de carregamento visível
local function TelaCarregamento()
    local Tela = Instance.new("ScreenGui", Gui)
    Tela.Name = "Bibi_Load_Baus"
    Tela.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Fundo = Instance.new("Frame", Tela)
    Fundo.Size = UDim2.new(1,0,1,0)
    Fundo.BackgroundColor3 = Color3.fromRGB(15,15,40)

    local Titulo = Instance.new("TextLabel", Fundo)
    Titulo.Size = UDim2.new(0,300,0,60)
    Titulo.Position = UDim2.new(0.5,-150,0.4,-30)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "💖 BIBI HUB - BAÚS"
    Titulo.TextColor3 = BibiHub.CorPrincipal
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true

    task.wait(0.6)
    Tela:Destroy()
end

-- 🔹 Interface COMPLETA e VISÍVEL
local function CriarInterface()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_Baus"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Main.Enabled = true
    Main.ResetOnSpawn = false

    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.08,0)
    Janela.Size = UDim2.new(0,320,0,400)
    Janela.BackgroundTransparency = 0
    CarregarFundo(Janela)

    -- Cabeçalho
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,40)
    Cab.ZIndex = 10
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "📦 BAÚS / TESOUROS"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true

    -- Botão ON/OFF
    local BtnOnOff = Instance.new("TextButton", Janela)
    BtnOnOff.Position = UDim2.new(0.05,0,0.14,0)
    BtnOnOff.Size = UDim2.new(0.4,0,0,35)
    BtnOnOff.ZIndex = 10
    BtnOnOff.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnOnOff.Text = "🟢 LIGADO"
    BtnOnOff.TextColor3 = Color3.new(1,1,1)
    BtnOnOff.Font = Enum.Font.GothamBold

    -- Botão Servidor
    local BtnServidor = Instance.new("TextButton", Janela)
    BtnServidor.Position = UDim2.new(0.55,0,0.14,0)
    BtnServidor.Size = UDim2.new(0.4,0,0,35)
    BtnServidor.ZIndex = 10
    BtnServidor.BackgroundColor3 = Color3.fromRGB(180,60,60)
    BtnServidor.Text = "🔒 Servidor"
    BtnServidor.TextColor3 = Color3.new(1,1,1)
    BtnServidor.Font = Enum.Font.GothamBold

    -- Status
    local Status = Instance.new("TextLabel", Janela)
    Status.Position = UDim2.new(0.05,0,0.27,0)
    Status.Size = UDim2.new(0.9,0,0,25)
    Status.BackgroundTransparency = 1
    Status.ZIndex = 10
    Status.Text = "✅ Procurando baús..."
    Status.TextColor3 = Color3.fromRGB(120,255,120)
    Status.Font = Enum.Font.GothamSemibold

    -- Lista
    local ListaFrame = Instance.new("Frame", Janela)
    ListaFrame.Position = UDim2.new(0.05,0,0.38,0)
    ListaFrame.Size = UDim2.new(0.9,0,0.58,0)
    ListaFrame.ZIndex = 10
    ListaFrame.BackgroundColor3 = Color3.fromRGB(40,40,80,0.7)

    local ListaTitulo = Instance.new("TextLabel", ListaFrame)
    ListaTitulo.Size = UDim2.new(1,0,0,28)
    ListaTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    ListaTitulo.Text = "📦 Baús Encontrados"
    ListaTitulo.TextColor3 = Color3.new(1,1,1)
    ListaTitulo.Font = Enum.Font.GothamBold
    ListaTitulo.TextScaled = true

    local Lista = Instance.new("ScrollingFrame", ListaFrame)
    Lista.Position = UDim2.new(0,0,0,30)
    Lista.Size = UDim2.new(1,0,1,-30)
    Lista.BackgroundTransparency = 1
    Lista.ScrollBarThickness = 6

    -- Eventos
    BtnOnOff.MouseButton1Click:Connect(function()
        BibiHub.Ativo = not BibiHub.Ativo
        BtnOnOff.BackgroundColor3 = BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnOnOff.Text = BibiHub.Ativo and "🟢 LIGADO" or "🔴 DESLIGADO"
        Status.Text = BibiHub.Ativo and "✅ Buscando..." or "⏸️ Pausado"
    end)

    BtnServidor.MouseButton1Click:Connect(function()
        BibiHub.PodeTrocarServidor = not BibiHub.PodeTrocarServidor
        BtnServidor.BackgroundColor3 = BibiHub.PodeTrocarServidor and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnServidor.Text = BibiHub.PodeTrocarServidor and "🔓 Servidor" or "🔒 Servidor"
    end)

    return {Status=Status, Lista=Lista}
end

-- Teleporte
local function Teleportar(parte)
    if not Raiz or not parte then return end
    Raiz.CFrame = parte.CFrame * CFrame.new(0, 2, 0)
    Raiz.Velocity = Vector3.zero
end

-- Loop Principal
local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem = Jogador.Character
        Raiz = Personagem and Personagem:FindFirstChild("HumanoidRootPart")

        if not BibiHub.Ativo or not Raiz then
            ui.Lista:ClearAllChildren()
            return
        end

        local Baus = {}
        for _, obj in pairs(Workspace:GetDescendants()) do
            local ehBau = obj.Name:lower():find("chest") 
                        or obj.Name:lower():find("treasure")
                        or obj.Name:lower():find("bau") 
                        or obj.Name:lower():find("tesouro")
            local Parte = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("Part") and obj)
            if ehBau and Parte then
                local dist = (Raiz.Position - Parte.Position).Magnitude
                table.insert(Baus, {Obj=obj, Parte=Parte, Dist=dist})
            end
        end

        table.sort(Baus, function(a,b) return a.Dist < b.Dist end)
        ui.Lista:ClearAllChildren()

        if #Baus == 0 then
            local Vazio = Instance.new("TextLabel", ui.Lista)
            Vazio.Size = UDim2.new(1,0,0,30)
            Vazio.BackgroundTransparency = 1
            Vazio.Text = "🔍 Nenhum baú próximo"
            Vazio.TextColor3 = Color3.new(0.9,0.9,0.9)
            Vazio.Font = Enum.Font.Gotham
        else
            ui.Status.Text = string.format("✅ Encontrados: %d baús", #Baus)
            for i, bau in ipairs(Baus) do
                local Item = Instance.new("TextButton", ui.Lista)
                Item.Size = UDim2.new(1,0,0,32)
                Item.Position = UDim2.new(0,0,0,(i-1)*34)
                Item.BackgroundColor3 = Color3.fromRGB(50,50,90,0.8)
                Item.AutoLocalize = false
                Item.Text = string.format("📦 %s • %.0fm → Clique", bau.Obj.Name:sub(1,15), bau.Dist)
                Item.TextColor3 = Color3.new(1,1,1)
                Item.Font = Enum.Font.GothamSemibold
                Item.TextScaled = true
                Item.MouseButton1Click:Connect(function() Teleportar(bau.Parte) end)
            end
            ui.Lista.CanvasSize = UDim2.new(0,0,0,#Baus*34)
        end
    end)
end

-- Iniciar Tudo
coroutine.wrap(function()
    local ok, err = pcall(function()
        TelaCarregamento()
        local ui = CriarInterface()
        Iniciar(ui)
        print("✅ Bibi Hub BAÚS OK")
    end)
    if not ok then warn("ERRO BAÚS:", err) end
end)()