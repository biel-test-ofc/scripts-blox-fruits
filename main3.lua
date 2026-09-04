-- BIBI HUB: XP COMBAT ★ COMPLETO ★ DRAG + BOTÃO FLUTUANTE
local BibiHub={Nome="Bibi Hub",Versao="2.0-XP",CorPrincipal=Color3.fromRGB(255,105,180),CorSecundaria=Color3.fromRGB(80,80,255),Ativo=true,Modo="Espada"}

local Players=game:GetService("Players") local Workspace=game:GetService("Workspace") local RunService=game:GetService("RunService") local UIS=game:GetService("UserInputService")
local Jogador=Players.LocalPlayer local Gui=Jogador:WaitForChild("PlayerGui",10) local Personagem,Raiz

local function CarregarFundo(c)
    c.BackgroundColor3=Color3.fromRGB(20,20,55) c.BackgroundTransparency=0
    pcall(function() local i=Instance.new("ImageLabel",c) i.Size=UDim2.new(1,0,1,0) i.ZIndex=-1 i.Image="rbxasset://main.jpeg" i.ScaleType=Enum.ScaleType.StretchToFill i.BackgroundTransparency=0.25 end)
end

local function TelaCarregamento()
    local t=Instance.new("ScreenGui",Gui) local f=Instance.new("Frame",t) f.Size=UDim2.new(1,0,1,0) f.BackgroundColor3=Color3.fromRGB(15,15,40)
    local tt=Instance.new("TextLabel",f) tt.Size=UDim2.new(0,300,0,60) tt.Position=UDim2.new(0.5,-150,0.4,-30) tt.BackgroundTransparency=1 tt.Text="💖 BIBI HUB - XP FARM" tt.TextColor3=BibiHub.CorPrincipal tt.Font=Enum.Font.GothamBold task.wait(0.6) t:Destroy()
end

local function CriarInterface()
    local Main=Instance.new("ScreenGui",Gui) Main.Name="BibiHub_XP" Main.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

    local Janela=Instance.new("Frame",Main) Janela.Position=UDim2.new(0.02,0,0.05,0) Janela.Size=UDim2.new(0,340,0,440) CarregarFundo(Janela)

    local Cab=Instance.new("Frame",Janela) Cab.Size=UDim2.new(1,0,0,40) Cab.BackgroundColor3=BibiHub.CorPrincipal Cab.ZIndex=10
    local Tit=Instance.new("TextLabel",Cab) Tit.Size=UDim2.new(1,0,1,0) Tit.Text="⚔️ XP FARM COMBAT" Tit.TextColor3=Color3.new(1,1,1) Tit.Font=Enum.Font.GothamBold Tit.TextScaled=true

    -- Drag Janela
    local dj={Ativo=false}
    Janela.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dj.Ativo=true dj.p=Janela.Position dj.ip=i.Position end end)
    Janela.InputChanged:Connect(function(i) if dj.Ativo then local dx=i.Position.X-dj.ip.X local dy=i.Position.Y-dj.ip.Y Janela.Position=UDim2.new(0,math.clamp(dj.p.X.Offset+dx,0,1000),0,math.clamp(dj.p.Y.Offset+dy,0,600)) end end)
    Janela.InputEnded:Connect(function() dj.Ativo=false end)

    -- Botão Flutuante
    local BtnFloat=Instance.new("TextButton",Main) BtnFloat.Size=UDim2.new(0,55,0,55) BtnFloat.Position=UDim2.new(0.85,0,0.15,0) BtnFloat.BackgroundColor3=BibiHub.CorPrincipal BtnFloat.ZIndex=999
    BtnFloat.Text="💖" BtnFloat.TextColor3=Color3.new(1,1,1) BtnFloat.Font=Enum.Font.GothamBold Instance.new("UICorner",BtnFloat).CornerRadius=UDim.new(1,0)

    -- Drag Botão
    local db={Ativo=false}
    BtnFloat.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then db.Ativo=true db.p=BtnFloat.Position db.ip=i.Position end end)
    BtnFloat.InputChanged:Connect(function(i) if db.Ativo then local dx=i.Position.X-db.ip.X local dy=i.Position.Y-db.ip.Y BtnFloat.Position=UDim2.new(0,math.clamp(db.p.X.Offset+dx,0,1000),0,math.clamp(db.p.Y.Offset+dy,0,600)) end end)
    BtnFloat.MouseButton1Click:Connect(function() Janela.Visible=not Janela.Visible BtnFloat.Text=Janela.Visible and "❌" or "👁️" end)

    -- Modo Ataque
    local ModoFrame=Instance.new("Frame",Janela) ModoFrame.Position=UDim2.new(0.05,0,0.14,0) ModoFrame.Size=UDim2.new(0.9,0,0.20,0) ModoFrame.BackgroundColor3=Color3.fromRGB(40,40,80,0.8) ModoFrame.ZIndex=10
    local BtnEsp=Instance.new("TextButton",ModoFrame) BtnEsp.Position=UDim2.new(0.05,0,0.3,0) BtnEsp.Size=UDim2.new(0.28,0,0,30) BtnEsp.BackgroundColor3=Color3.fromRGB(60,180,80) BtnEsp.Text="🗡️ Espada" BtnEsp.ZIndex=10
    local BtnLut=Instance.new("TextButton",ModoFrame) BtnLut.Position=UDim2.new(0.38,0,0.3,0) BtnLut.Size=UDim2.new(0.28,0,0,30) BtnLut.BackgroundColor3=Color3.fromRGB(80,80,130) BtnLut.Text="👊 Luta" BtnLut.ZIndex=10
    local BtnFrut=Instance.new("TextButton",ModoFrame) BtnFrut.Position=UDim2.new(0.71,0,0.3,0) BtnFrut.Size=UDim2.new(0.24,0,0,30) BtnFrut.BackgroundColor3=Color3.fromRGB(80,80,130) BtnFrut.Text="🍎 Fruta" BtnFrut.ZIndex=10

    local AlvoTxt=Instance.new("TextLabel",Janela) AlvoTxt.Position=UDim2.new(0.05,0,0.36,0) AlvoTxt.Size=UDim2.new(0.9,0,0,30) AlvoTxt.BackgroundTransparency=1 AlvoTxt.Text="🎯 Alvo: ..." AlvoTxt.TextColor3=Color3.new(1,1,1) AlvoTxt.ZIndex=10

    local function MudarModo(m) BibiHub.Modo=m BtnEsp.BackgroundColor3=(m=="Espada") and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,130) BtnLut.BackgroundColor3=(m=="Combate") and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,130) BtnFrut.BackgroundColor3=(m=="Fruta") and Color3.fromRGB(60,180,80) or Color3.fromRGB(80,80,130) end
    BtnEsp.MouseButton1Click:Connect(function() MudarModo("Espada") end)
    BtnLut.MouseButton1Click:Connect(function() MudarModo("Combate") end)
    BtnFrut.MouseButton1Click:Connect(function() MudarModo("Fruta") end)

    return {Alvo=AlvoTxt, Main=Main}
end

local function Atacar()
    if not Personagem then return end
    pcall(function() local t=Personagem:FindFirstChildWhichIsA("Tool") if t then t:Activate() end end)
end

local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem=Jogador.Character Raiz=Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        if not BibiHub.Ativo or not Raiz then ui.Alvo.Text="⏸️ Parado" return end

        local Melhor,MenorD=nil,math.huge
        for _,obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj~=Personagem and not obj:IsDescendantOf(Players) and obj.Humanoid.Health>0 then
                local p=obj.PrimaryPart
                if p then local d=(Raiz.Position-p.Position).Magnitude if d<150 and d<MenorD then MenorD=d Melhor=obj end end
            end
        end

        if Melhor then
            ui.Alvo.Text="🎯 Alvo: "..Melhor.Name
            Raiz.CFrame=CFrame.new(Raiz.Position.X,Raiz.Position.Y,Raiz.Position.Z, Melhor.PrimaryPart.Position.X-Raiz.Position.X,0, Melhor.PrimaryPart.Position.Z-Raiz.Position.Z)
            Atacar()
        else
            ui.Alvo.Text="🎯 Nenhum inimigo"
        end
    end)
end

coroutine.wrap(function() TelaCarregamento() local ui=CriarInterface() ui.Main.Parent=Gui Iniciar(ui) print("✅ MAIN3 PRONTO") end)()