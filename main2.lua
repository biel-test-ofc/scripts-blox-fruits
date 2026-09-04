-- BIBI HUB: Chest Farm v1.0 📦
-- Mesma interface → Agora procura BAÚS/TESOUROS
-- ✅ ON/OFF | TP Manual | Fundo main.jpeg | Sem pasta
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "1.0-Chest",
    CorPrincipal = Color3.fromRGB(255, 105, 180), -- Rosa Bibi 💖
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true,
    PodeTrocarServidor = false
}

-- Serviços
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui")
local Personagem, Raiz

-- 🔹 Fundo: main.jpeg (mesmo lugar, sem pasta)
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
    Tela.Name = "Bibi_Load"
    local Fundo = Instance.new("Frame", Tela)
    Fundo.Size = UDim2.new(1,0,1,0)
    CarregarFundo(Fundo)
    
    local Titulo = Instance.new("TextLabel", Fundo)
    Titulo.Size = UDim2.new(0,300,0,60)
    Titulo.Position = UDim2.new(0.5,-150,0.4,-30)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "💖 BIBI HUB - BAÚS"
    Titulo.TextColor3 = BibiHub.CorPrincipal
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    
    task.wait(0.8)
    Tela:Destroy()
end

-- 🔹 Interface Completa
local function CriarInterface()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_Chest"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.08,0)
    Janela.Size = UDim2.new(0,320,0,400)
    Janela.BorderSizePixel = 0
    Janela.ClipsDescendants = true
    CarregarFundo(Janela)
    
    -- Cabeçalho
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,38)
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    Cab.ZIndex = 5
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "💖 BIBI HUB - BAÚS/TESOUROS"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    
    -- Botão ON/OFF
    local BtnOnOff = Instance.new("TextButton", Janela)
    BtnOnOff.Position = UDim2.new(0.05,0,0.12,0)
    BtnOnOff.Size = UDim2.new(0.42,0,0,32)
    BtnOnOff.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnOnOff.Text = "🟢 LIGADO"
    BtnOnOff.TextColor3 = Color3.new(1,1,1)
    BtnOnOff.Font = Enum.Font.GothamBold
    BtnOnOff.TextScaled = true
    BtnOnOff.ZIndex = 5
    
    -- Botão Servidor
    local BtnServidor = Instance.new("TextButton", Janela)
    BtnServidor.Position = UDim2.new(0.53,0,0.12,0)
    BtnServidor.Size = UDim2.new(0.42,0,0,32)
    BtnServidor.BackgroundColor3 = Color3.fromRGB(180,60,60)
    BtnServidor.Text = "🔒 Servidor: NÃO"
    BtnServidor.TextColor3 = Color3.new(1,1,1)
    BtnServidor.Font = Enum.Font.GothamBold
    BtnServidor.TextScaled = true
    BtnServidor.ZIndex = 5
    
    -- Status
    local Status = Instance.new("TextLabel", Janela)
    Status.Position = UDim2.new(0.05,0,0.22,0)
    Status.Size = UDim2.new(0.9,0,0,22)
    Status.BackgroundTransparency = 1
    Status.Text = "✅ Procurando Baús..."
    Status.TextColor3 = Color3.fromRGB(100,255,100)
    Status.Font = Enum.Font.GothamSemibold
    Status.TextScaled = true
    Status.ZIndex = 5
    
    -- Lista
    local ListaFrame = Instance.new("Frame", Janela)
    ListaFrame.Position = UDim2.new(0.05,0,0.29,0)
    ListaFrame.Size = UDim2.new(0.9,0,0.66,0)
    ListaFrame.BackgroundColor3 = Color3.fromRGB(35,35,65,0.8)
    ListaFrame.ZIndex = 5
    
    local ListaTitulo = Instance.new("TextLabel", ListaFrame)
    ListaTitulo.Size = UDim2.new(1,0,0,26)
    ListaTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    ListaTitulo.Text = "📦 Baús (Clique ➡️ para ir)"
    ListaTitulo.TextColor3 = Color3.new(1,1,1)
    ListaTitulo.Font = Enum.Font.GothamBold
    ListaTitulo.TextScaled = true
    
    local Lista = Instance.new("ScrollingFrame", ListaFrame)
    Lista.Position = UDim2.new(0,0,0,28)
    Lista.Size = UDim2.new(1,0,1,-28)
    Lista.BackgroundTransparency = 1
    Lista.ScrollBarThickness = 5
    
    -- Eventos
    BtnOnOff.MouseButton1Click:Connect(function()
        BibiHub.Ativo = not BibiHub.Ativo
        BtnOnOff.BackgroundColor3 = BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnOnOff.Text = BibiHub.Ativo and "🟢 LIGADO" or "🔴 DESLIGADO"
        Status.Text = BibiHub.Ativo and "✅ Buscando Baús..." or "⏸️ Pausado"
    end)
    
    BtnServidor.MouseButton1Click:Connect(function()
        BibiHub.PodeTrocarServidor = not BibiHub.PodeTrocarServidor
        BtnServidor.BackgroundColor3 = BibiHub.PodeTrocarServidor and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnServidor.Text = BibiHub.PodeTrocarServidor and "🔓 Servidor: SIM" or "🔒 Servidor: NÃO"
    end)
    
    return {Status=Status, Lista=Lista}
end

-- 🔹 Teleporte Manual
local function TeleportarPara(parte)
    if not Raiz or not parte then return end
    Raiz.CFrame = parte.CFrame * CFrame.new(0, 2, 0)
    Raiz.Velocity = Vector3.zero
end

-- 🔹 Loop Principal (PROCURA BAÚS/TESOUROS)
local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem = Jogador.Character
        Raiz = Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        
        -- Limpa se desligado
        if not BibiHub.Ativo then
            ui.Lista:ClearAllChildren()
            ui.Status.Text = "⏸️ Pausado"
            return
        end
        
        if not Raiz then
            ui.Status.Text = "⚠️ Sem personagem"
            return
        end
        
        -- 🔑 AQUI: Procura BAÚS em vez de frutas!
        local Baus = {}
        for _, obj in pairs(Workspace:GetDescendants()) do
            -- Detecta nomes: Chest, Treasure, Baú, Tesouro etc.
            local ehBau = obj.Name:lower():find("chest") 
                        or obj.Name:lower():find("treasure")
                        or obj.Name:lower():find("bau") 
                        or obj.Name:lower():find("tesouro")
            
            local Parte = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("Part") and obj)
            if ehBau and Parte then
                local Dist = (Raiz.Position - Parte.Position).Magnitude
                table.insert(Baus, {Nome=obj.Name, Dist=Dist, Parte=Parte})
            end
        end
        
        -- Ordena por distância
        table.sort(Baus, function(a,b) return a.Dist < b.Dist end)
        
        -- Atualiza UI
        ui.Lista:ClearAllChildren()
        ui.Status.Text = string.format("✅ Encontrados: %d Baús", #Baus)
        
        if #Baus == 0 then
            local Vazio = Instance.new("TextLabel", ui.Lista)
            Vazio.Size = UDim2.new(1,0,0,28)
            Vazio.BackgroundTransparency = 1
            Vazio.Text = "🔍 Nenhum baú por perto"
            Vazio.TextColor3 = Color3.new(0.8,0.8,0.8)
            Vazio.Font = Enum.Font.Gotham
            Vazio.TextScaled = true
            return
        end
        
        -- Lista com botão IR
        for i, Bau in ipairs(Baus) do
            local Item = Instance.new("Frame", ui.Lista)
            Item.Size = UDim2.new(1,-4,0,30)
            Item.Position = UDim2.new(0,0,0,(i-1)*32)
            Item.BackgroundColor3 = Color3.fromRGB(40,40,70)
            
            local Nome = Instance.new("TextLabel", Item)
            Nome.Size = UDim2.new(0.6,0,1,0)
            Nome.BackgroundTransparency = 1
            Nome.Text = string.format("📦 %s (%.0fm)", Bau.Nome:sub(1,14), Bau.Dist)
            Nome.TextColor3 = Color3.new(1,1,1)
            Nome.Font = Enum.Font.GothamSemibold
            Nome.TextScaled = true
            
            local BtnIr = Instance.new("TextButton", Item)
            BtnIr.Size = UDim2.new(0.3,0,0.8,0)
            BtnIr.Position = UDim2.new(0.65,0,0.1,0)
            BtnIr.BackgroundColor3 = BibiHub.CorPrincipal
            BtnIr.Text = "➡️ IR"
            BtnIr.TextColor3 = Color3.new(1,1,1)
            BtnIr.Font = Enum.Font.GothamBold
            BtnIr.TextScaled = true
            
            BtnIr.MouseButton1Click:Connect(function()
                TeleportarPara(Bau.Parte)
            end)
        end
    end)
end

-- 🚀 Iniciar
coroutine.wrap(function()
    TelaCarregamento()
    local ui = CriarInterface()
    Iniciar(ui)
    print("💖 Bibi Hub Chest Farm Pronto!")
end)()
