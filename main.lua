-- BIBI HUB: Fruit Finder v1.3 🐙 (GitHub Edition)
-- ✅ Carrega fundo: main.jpeg (mesma pasta/repositório)
-- ✅ ON/OFF | TP Manual | Controle de Servidor
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "1.3-GitHub",
    CorPrincipal = Color3.fromRGB(255, 105, 180), -- Rosa Bibi 💖
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true,
    PodeTrocarServidor = false
}

-- Serviços
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService") -- Para URLs

local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui")
local Personagem, Raiz, Humano

-- 🔹 Carregar Fundo: main.jpeg (mesma pasta/repositório)
local function CarregarFundo(container)
    local FundoImagem = Instance.new("ImageLabel", container)
    FundoImagem.Name = "FundoBibi"
    FundoImagem.Size = UDim2.new(1, 0, 1, 0)
    FundoImagem.Position = UDim2.new(0, 0, 0, 0)
    FundoImagem.BackgroundTransparency = 1
    FundoImagem.ZIndex = -10
    FundoImagem.ScaleType = Enum.ScaleType.StretchToFill

    -- ✅ Funciona: Arquivo local ou repositório GitHub (raw)
    local sucesso, _ = pcall(function()
        -- Tenta caminho local primeiro
        FundoImagem.Image = "rbxasset://main.jpeg"
        task.wait()
        if FundoImagem.IsLoaded then return true end
        
        -- Se no GitHub: Use o link "raw" direto
        -- EXEMPLO: https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPO/main/main.jpeg
        -- O script detecta automaticamente se rodar do GitHub
        local caminhoRaw = debug.getinfo(1,"S").source:sub(2)
        if caminhoRaw:find("raw.githubusercontent.com") then
            local pastaRepo = caminhoRaw:match("(.*/)")
            FundoImagem.Image = pastaRepo .. "main.jpeg"
        end
        return true
    end)

    -- Fallback seguro se não encontrar imagem
    if not sucesso or not FundoImagem.IsLoaded then
        FundoImagem:Destroy()
        container.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
        print("ℹ️ Bibi Hub: Usando fundo padrão — coloque main.jpeg na pasta/repositório")
    else
        container.BackgroundColor3 = Color3.new(0,0,0)
        container.BackgroundTransparency = 0.25
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
    Titulo.Text = "💖 BIBI HUB"
    Titulo.TextColor3 = BibiHub.CorPrincipal
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    
    task.wait(0.8)
    Tela:Destroy()
end

-- 🔹 Interface Completa
local function CriarInterface()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_Main"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.08,0)
    Janela.Size = UDim2.new(0,330,0,420)
    Janela.BorderSizePixel = 0
    Janela.ClipsDescendants = true
    CarregarFundo(Janela) -- Aplica fundo personalizado
    
    -- Cabeçalho
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,40)
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    Cab.ZIndex = 5
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "💖 BIBI HUB - FRUTAS"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    
    -- Botão ON/OFF
    local BtnOnOff = Instance.new("TextButton", Janela)
    BtnOnOff.Position = UDim2.new(0.05,0,0.13,0)
    BtnOnOff.Size = UDim2.new(0.42,0,0,35)
    BtnOnOff.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnOnOff.Text = "🟢 LIGADO"
    BtnOnOff.TextColor3 = Color3.new(1,1,1)
    BtnOnOff.Font = Enum.Font.GothamBold
    BtnOnOff.TextScaled = true
    BtnOnOff.ZIndex = 5
    
    -- Botão Servidor
    local BtnServidor = Instance.new("TextButton", Janela)
    BtnServidor.Position = UDim2.new(0.53,0,0.13,0)
    BtnServidor.Size = UDim2.new(0.42,0,0,35)
    BtnServidor.BackgroundColor3 = Color3.fromRGB(180,60,60)
    BtnServidor.Text = "🔒 Servidor: NÃO"
    BtnServidor.TextColor3 = Color3.new(1,1,1)
    BtnServidor.Font = Enum.Font.GothamBold
    BtnServidor.TextScaled = true
    BtnServidor.ZIndex = 5
    
    -- Status
    local Status = Instance.new("TextLabel", Janela)
    Status.Position = UDim2.new(0.05,0,0.23,0)
    Status.Size = UDim2.new(0.9,0,0,25)
    Status.BackgroundTransparency = 1
    Status.Text = "✅ Sistema Pronto"
    Status.TextColor3 = Color3.fromRGB(100,255,100)
    Status.Font = Enum.Font.GothamSemibold
    Status.TextScaled = true
    Status.ZIndex = 5
    
    -- Lista de Frutas
    local ListaFrame = Instance.new("Frame", Janela)
    ListaFrame.Position = UDim2.new(0.05,0,0.30,0)
    ListaFrame.Size = UDim2.new(0.9,0,0.65,0)
    ListaFrame.BackgroundColor3 = Color3.fromRGB(35,35,65,0.85)
    ListaFrame.ZIndex = 5
    
    local ListaTitulo = Instance.new("TextLabel", ListaFrame)
    ListaTitulo.Size = UDim2.new(1,0,0,28)
    ListaTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    ListaTitulo.Text = "🍎 Frutas ➡️ Clique para ir"
    ListaTitulo.TextColor3 = Color3.new(1,1,1)
    ListaTitulo.Font = Enum.Font.GothamBold
    ListaTitulo.TextScaled = true
    
    local Lista = Instance.new("ScrollingFrame", ListaFrame)
    Lista.Position = UDim2.new(0,0,0,30)
    Lista.Size = UDim2.new(1,0,1,-30)
    Lista.BackgroundTransparency = 1
    Lista.CanvasSize = UDim2.new(0,0,1,1)
    Lista.ScrollBarThickness = 5
    
    -- Eventos
    BtnOnOff.MouseButton1Click:Connect(function()
        BibiHub.Ativo = not BibiHub.Ativo
        BtnOnOff.BackgroundColor3 = BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnOnOff.Text = BibiHub.Ativo and "🟢 LIGADO" or "🔴 DESLIGADO"
        Status.Text = BibiHub.Ativo and "✅ Buscando frutas..." or "⏸️ Pausado"
    end)
    
    BtnServidor.MouseButton1Click:Connect(function()
        BibiHub.PodeTrocarServidor = not BibiHub.PodeTrocarServidor
        BtnServidor.BackgroundColor3 = BibiHub.PodeTrocarServidor and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnServidor.Text = BibiHub.PodeTrocarServidor and "🔓 Servidor: SIM" or "🔒 Servidor: NÃO"
    end)
    
    return {Status=Status, Lista=Lista, Janela=Janela, Gui=Main}
end

-- 🔹 Teleporte Manual
local function TeleportarPara(parte)
    if not Raiz or not parte then return end
    Raiz.CFrame = parte.CFrame * CFrame.new(0, 2.5, 0)
    Raiz.Velocity = Vector3.zero
end

-- 🔹 Loop de Busca
local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem = Jogador.Character
        if Personagem then Raiz = Personagem:FindFirstChild("HumanoidRootPart") end
        
        if not BibiHub.Ativo then
            ui.Lista:ClearAllChildren() return
        end
        if not Raiz then
            ui.Status.Text = "⚠️ Sem personagem" return
        end
        
        -- Busca frutas
        local frutas = {}
        for _, obj in pairs(Workspace:GetDescendants()) do
            local ehFruta = obj.Name:lower():find("fruit") or obj.Name:lower():find("fruta")
            local parte = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("Part") and obj or nil)
            if ehFruta and parte then
                local dist = (Raiz.Position - parte.Position).Magnitude
                table.insert(frutas, {Nome=obj.Name, Dist=dist, Parte=parte})
            end
        end
        
        table.sort(frutas, function(a,b) return a.Dist < b.Dist end)
        ui.Lista:ClearAllChildren()
        ui.Status.Text = string.format("✅ Encontradas: %d", #frutas)
        
        if #frutas == 0 then
            local vazio = Instance.new("TextLabel", ui.Lista)
            vazio.Size = UDim2.new(1,0,0,30)
            vazio.BackgroundTransparency = 1
            vazio.Text = "🔍 Nenhuma fruta"
            vazio.TextColor3 = Color3.new(0.8,0.8,0.8)
            vazio.Font = Enum.Font.Gotham
            vazio.TextScaled = true
        else
            for i, fruta in ipairs(frutas) do
                local item = Instance.new("Frame", ui.Lista)
                item.Size = UDim2.new(1,-5,0,32)
                item.Position = UDim2.new(0,0,0,(i-1)*34)
                item.BackgroundColor3 = Color3.fromRGB(45,45,75,0.9)
                
                local nome = Instance.new("TextLabel", item)
                nome.Size = UDim2.new(0.65,0,1,0)
                nome.BackgroundTransparency = 1
                nome.Text = string.format("🍎 %s (%.0fm)", fruta.Nome:sub(1,14), fruta.Dist)
                nome.TextColor3 = Color3.new(1,1,1)
                nome.Font = Enum.Font.GothamSemibold
                nome.TextScaled = true
                
                local btn = Instance.new("TextButton", item)
                btn.Size = UDim2.new(0.28,0,0.8,0)
                btn.Position = UDim2.new(0.7,0,0.1,0)
                btn.BackgroundColor3 = BibiHub.CorPrincipal
                btn.Text = "➡️ IR"
                btn.TextColor3 = Color3.new(1,1,1)
                btn.Font = Enum.Font.GothamBold
                btn.TextScaled = true
                btn.MouseButton1Click:Connect(function() TeleportarPara(fruta.Parte) end)
            end
            ui.Lista.CanvasSize = UDim2.new(0,0,0,#frutas*34)
        end
    end)
end

-- 🚀 Iniciar
coroutine.wrap(function()
    TelaCarregamento()
    local ui = CriarInterface()
    Iniciar(ui)
    print("💖 Bibi Hub GitHub v1.3 | Pronto!")
end)()