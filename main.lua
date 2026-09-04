-- BIBI HUB: FRUIT FINDER ★ COMPLETO ★ DRAG + BOTÃO FLUTUANTE
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "2.0-FULL",
    CorPrincipal = Color3.fromRGB(255, 105, 180),
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true
}

-- Serviços
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui", 10)
local Personagem, Raiz

-- 🔹 FUNDO SEGURO (NUNCA CINZA)
local function CarregarFundo(container)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 55)
    container.BackgroundTransparency = 0
    container.BorderSizePixel = 0

    pcall(function()
        local Img = Instance.new("ImageLabel", container)
        Img.Name = "Fundo"
        Img.Size = UDim2.new(1,0,1,0)
        Img.ZIndex = -1
        Img.Image = "rbxasset://main.jpeg"
        Img.ScaleType = Enum.ScaleType.StretchToFill
        Img.BackgroundTransparency = 0.25
    end)
end

-- 🔹 TELA DE CARREGAMENTO
local function TelaCarregamento()
    local Tela = Instance.new("ScreenGui", Gui)
    local Fundo = Instance.new("Frame", Tela)
    Fundo.Size = UDim2.new(1,0,1,0)
    Fundo.BackgroundColor3 = Color3.fromRGB(15,15,40)
    local Titulo = Instance.new("TextLabel", Fundo)
    Titulo.Size = UDim2.new(0,300,0,60)
    Titulo.Position = UDim2.new(0.5,-150,0.4,-30)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "💖 BIBI HUB - FRUTAS"
    Titulo.TextColor3 = BibiHub.CorPrincipal
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true
    task.wait(0.6)
    Tela:Destroy()
end

-- 🔹 INTERFACE PRINCIPAL + DRAG + BOTÃO FLUTUANTE
local function CriarInterface()
    local Main = Instance.new("ScreenGui", Gui)
    Main.Name = "BibiHub_Fruit"
    Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Main.Enabled = true

    -- JANELA PRINCIPAL
    local Janela = Instance.new("Frame", Main)
    Janela.Position = UDim2.new(0.02,0,0.08,0)
    Janela.Size = UDim2.new(0,320,0,420)
    CarregarFundo(Janela)

    -- CABEÇALHO
    local Cab = Instance.new("Frame", Janela)
    Cab.Size = UDim2.new(1,0,0,40)
    Cab.ZIndex = 10
    Cab.BackgroundColor3 = BibiHub.CorPrincipal
    local Titulo = Instance.new("TextLabel", Cab)
    Titulo.Size = UDim2.new(1,0,1,0)
    Titulo.Text = "🍎 BIBI HUB - FRUTAS"
    Titulo.TextColor3 = Color3.new(1,1,1)
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextScaled = true

    -- SISTEMA DE ARRASTAR JANELA
    local DragJanela = {Ativo=false, InicioPos=nil, InicioToque=nil}
    Janela.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            DragJanela.Ativo = true
            DragJanela.InicioPos = Janela.Position
            DragJanela.InicioToque = i.Position
        end
    end)
    Janela.InputChanged:Connect(function(i)
        if DragJanela.Ativo then
            local dx = i.Position.X - DragJanela.InicioToque.X
            local dy = i.Position.Y - DragJanela.InicioToque.Y
            Janela.Position = UDim2.new(0, math.clamp(DragJanela.InicioPos.X.Offset+dx,0,1000), 0, math.clamp(DragJanela.InicioPos.Y.Offset+dy,0,600))
        end
    end)
    local function PararDrag() DragJanela.Ativo=false end
    Janela.InputEnded:Connect(PararDrag)
    UserInputService.InputEnded:Connect(PararDrag)

    -- BOTÃO FLUTUANTE (MINIMIZAR)
    local BtnFloat = Instance.new("TextButton", Main)
    BtnFloat.Size = UDim2.new(0,55,0,55)
    BtnFloat.Position = UDim2.new(0.85,0,0.15,0)
    BtnFloat.BackgroundColor3 = BibiHub.CorPrincipal
    BtnFloat.ZIndex = 999
    BtnFloat.Text = "💖"
    BtnFloat.TextColor3 = Color3.new(1,1,1)
    BtnFloat.Font = Enum.Font.GothamBold
    BtnFloat.TextScaled = true
    local Corner = Instance.new("UICorner", BtnFloat)
    Corner.CornerRadius = UDim.new(1,0)

    -- DRAG DO BOTÃO FLUTUANTE
    local DragBtn = {Ativo=false, InicioPos=nil, InicioToque=nil}
    BtnFloat.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            DragBtn.Ativo = true
            DragBtn.InicioPos = BtnFloat.Position
            DragBtn.InicioToque = i.Position
        end
    end)
    BtnFloat.InputChanged:Connect(function(i)
        if DragBtn.Ativo then
            local dx = i.Position.X - DragBtn.InicioToque.X
            local dy = i.Position.Y - DragBtn.InicioToque.Y
            BtnFloat.Position = UDim2.new(0, math.clamp(DragBtn.InicioPos.X.Offset+dx,0,1000), 0, math.clamp(DragBtn.InicioPos.Y.Offset+dy,0,600))
        end
    end)
    BtnFloat.InputEnded:Connect(function() DragBtn.Ativo=false end)

    -- TOGGLE MOSTRAR/ESCONDER
    BtnFloat.MouseButton1Click:Connect(function()
        Janela.Visible = not Janela.Visible
        BtnFloat.Text = Janela.Visible and "❌" or "👁️"
    end)

    -- BOTÃO ON/OFF
    local BtnOnOff = Instance.new("TextButton", Janela)
    BtnOnOff.Position = UDim2.new(0.05,0,0.14,0)
    BtnOnOff.Size = UDim2.new(0.9,0,0,35)
    BtnOnOff.ZIndex = 10
    BtnOnOff.BackgroundColor3 = Color3.fromRGB(60,180,80)
    BtnOnOff.Text = "🟢 FUNCIONANDO"
    BtnOnOff.TextColor3 = Color3.new(1,1,1)
    BtnOnOff.Font = Enum.Font.GothamBold
    BtnOnOff.MouseButton1Click:Connect(function()
        BibiHub.Ativo = not BibiHub.Ativo
        BtnOnOff.BackgroundColor3 = BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60)
        BtnOnOff.Text = BibiHub.Ativo and "🟢 LIGADO" or "🔴 DESLIGADO"
    end)

    -- STATUS
    local Status = Instance.new("TextLabel", Janela)
    Status.Position = UDim2.new(0.05,0,0.27,0)
    Status.Size = UDim2.new(0.9,0,0,25)
    Status.BackgroundTransparency = 1
    Status.ZIndex = 10
    Status.Text = "✅ Interface carregada!"
    Status.TextColor3 = Color3.fromRGB(120,255,120)
    Status.Font = Enum.Font.GothamSemibold

    -- LISTA DE FRUTAS
    local ListaFrame = Instance.new("Frame", Janela)
    ListaFrame.Position = UDim2.new(0.05,0,0.38,0)
    ListaFrame.Size = UDim2.new(0.9,0,0.58,0)
    ListaFrame.ZIndex = 10
    ListaFrame.BackgroundColor3 = Color3.fromRGB(40,40,80,0.7)
    local ListaTitulo = Instance.new("TextLabel", ListaFrame)
    ListaTitulo.Size = UDim2.new(1,0,0,28)
    ListaTitulo.BackgroundColor3 = BibiHub.CorSecundaria
    ListaTitulo.Text = "🍎 Frutas (Clique para ir)"
    ListaTitulo.TextColor3 = Color3.new(1,1,1)
    ListaTitulo.Font = Enum.Font.GothamBold
    local Lista = Instance.new("ScrollingFrame", ListaFrame)
    Lista.Position = UDim2.new(0,0,0,30)
    Lista.Size = UDim2.new(1,0,1,-30)
    Lista.BackgroundTransparency = 1
    Lista.ScrollBarThickness = 6

    return {Status=Status, Lista=Lista, Main=Main}
end

-- TELEPORTE
local function Tele(parte)
    if not Raiz or not parte then return end
    Raiz.CFrame = parte.CFrame * CFrame.new(0,2,0)
    Raiz.Velocity = Vector3.zero
end

-- LOOP PRINCIPAL
local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem = Jogador.Character
        Raiz = Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        if not BibiHub.Ativo or not Raiz then ui.Lista:ClearAllChildren() return end

        local Frutas = {}
        for _, obj in pairs(Workspace:GetDescendants()) do
            local eh = obj.Name:lower():find("fruit") or obj.Name:lower():find("fruta") or obj.Name:lower():find("blox")
            local p = obj:IsA("Model") and obj.PrimaryPart or (obj:IsA("Part") and obj)
            if eh and p then
                local d = (Raiz.Position - p.Position).Magnitude
                table.insert(Frutas, {Obj=obj, Parte=p, Dist=d})
            end
        end
        table.sort(Frutas, function(a,b) return a.Dist < b.Dist end)
        ui.Lista:ClearAllChildren()

        if #Frutas == 0 then
            local v = Instance.new("TextLabel", ui.Lista)
            v.Size = UDim2.new(1,0,0,30)
            v.BackgroundTransparency = 1
            v.Text = "🔍 Nenhuma fruta próxima"
            v.TextColor3 = Color3.new(0.9,0.9,0.9)
        else
            ui.Status.Text = "✅ Encontradas: "..#Frutas
            for i,f in ipairs(Frutas) do
                local b = Instance.new("TextButton", ui.Lista)
                b.Size = UDim2.new(1,0,0,34)
                b.Position = UDim2.new(0,0,0,(i-1)*36)
                b.BackgroundColor3 = Color3.fromRGB(50,50,100,0.8)
                b.Text = "🍎 "..f.Obj.Name:sub(1,16).." • "..math.floor(f.Dist).."m"
                b.TextColor3 = Color3.new(1,1,1)
                b.Font = Enum.Font.GothamSemibold
                b.ZIndex = 10
                b.MouseButton1Click:Connect(function() Tele(f.Parte) end)
            end
            ui.Lista.CanvasSize = UDim2.new(0,0,0,#Frutas*36)
        end
    end)
end

-- INICIAR TUDO
coroutine.wrap(function()
    TelaCarregamento()
    local ui = CriarInterface()
    ui.Main.Parent = Gui
    Iniciar(ui)
    print("✅ MAIN.LUA PRONTO")
end)()