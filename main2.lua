-- BIBI HUB: CHEST FINDER ★ COMPLETO ★ DRAG + BOTÃO FLUTUANTE
local BibiHub = {
    Nome = "Bibi Hub",
    Versao = "2.0-BAUS",
    CorPrincipal = Color3.fromRGB(255, 105, 180),
    CorSecundaria = Color3.fromRGB(80, 80, 255),
    Ativo = true
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Jogador = Players.LocalPlayer
local Gui = Jogador:WaitForChild("PlayerGui",10)
local Personagem, Raiz

local function CarregarFundo(c)
    c.BackgroundColor3 = Color3.fromRGB(22,22,55)
    c.BackgroundTransparency = 0
    pcall(function()
        local i = Instance.new("ImageLabel",c)
        i.Size=UDim2.new(1,0,1,0) i.ZIndex=-1 i.Image="rbxasset://main.jpeg" i.ScaleType=Enum.ScaleType.StretchToFill i.BackgroundTransparency=0.25
    end)
end

local function TelaCarregamento()
    local t=Instance.new("ScreenGui",Gui)
    local f=Instance.new("Frame",t) f.Size=UDim2.new(1,0,1,0) f.BackgroundColor3=Color3.fromRGB(15,15,40)
    local tt=Instance.new("TextLabel",f) tt.Size=UDim2.new(0,300,0,60) tt.Position=UDim2.new(0.5,-150,0.4,-30) tt.BackgroundTransparency=1
    tt.Text="💖 BIBI HUB - BAÚS" tt.TextColor3=BibiHub.CorPrincipal tt.Font=Enum.Font.GothamBold tt.TextScaled=true
    task.wait(0.6) t:Destroy()
end

local function CriarInterface()
    local Main=Instance.new("ScreenGui",Gui) Main.Name="BibiHub_BAUS" Main.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

    local Janela=Instance.new("Frame",Main) Janela.Position=UDim2.new(0.02,0,0.08,0) Janela.Size=UDim2.new(0,320,0,420) CarregarFundo(Janela)

    local Cab=Instance.new("Frame",Janela) Cab.Size=UDim2.new(1,0,0,40) Cab.BackgroundColor3=BibiHub.CorPrincipal Cab.ZIndex=10
    local Tit=Instance.new("TextLabel",Cab) Tit.Size=UDim2.new(1,0,1,0) Tit.Text="📦 BAÚS / TESOUROS" Tit.TextColor3=Color3.new(1,1,1) Tit.Font=Enum.Font.GothamBold Tit.TextScaled=true

    -- Drag Janela
    local dj={Ativo=false}
    Janela.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dj.Ativo=true dj.p=Janela.Position dj.ip=i.Position end end)
    Janela.InputChanged:Connect(function(i) if dj.Ativo then local dx=i.Position.X-dj.ip.X local dy=i.Position.Y-dj.ip.Y Janela.Position=UDim2.new(0,math.clamp(dj.p.X.Offset+dx,0,1000),0,math.clamp(dj.p.Y.Offset+dy,0,600)) end end)
    local p=function() dj.Ativo=false end Janela.InputEnded:Connect(p) UserInputService.InputEnded:Connect(p)

    -- Botão Flutuante
    local BtnFloat=Instance.new("TextButton",Main) BtnFloat.Size=UDim2.new(0,55,0,55) BtnFloat.Position=UDim2.new(0.85,0,0.15,0) BtnFloat.BackgroundColor3=BibiHub.CorPrincipal BtnFloat.ZIndex=999
    BtnFloat.Text="💖" BtnFloat.TextColor3=Color3.new(1,1,1) BtnFloat.Font=Enum.Font.GothamBold BtnFloat.TextScaled=true
    Instance.new("UICorner",BtnFloat).CornerRadius=UDim.new(1,0)

    -- Drag Botão
    local db={Ativo=false}
    BtnFloat.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then db.Ativo=true db.p=BtnFloat.Position db.ip=i.Position end end)
    BtnFloat.InputChanged:Connect(function(i) if db.Ativo then local dx=i.Position.X-db.ip.X local dy=i.Position.Y-db.ip.Y BtnFloat.Position=UDim2.new(0,math.clamp(db.p.X.Offset+dx,0,1000),0,math.clamp(db.p.Y.Offset+dy,0,600)) end end)
    BtnFloat.InputEnded:Connect(function() db.Ativo=false end)
    BtnFloat.MouseButton1Click:Connect(function() Janela.Visible=not Janela.Visible BtnFloat.Text=Janela.Visible and "❌" or "👁️" end)

    -- ON/OFF
    local BtnOn=Instance.new("TextButton",Janela) BtnOn.Position=UDim2.new(0.05,0,0.14,0) BtnOn.Size=UDim2.new(0.9,0,0,35) BtnOn.ZIndex=10 BtnOn.BackgroundColor3=Color3.fromRGB(60,180,80) BtnOn.Text="🟢 LIGADO"
    BtnOn.MouseButton1Click:Connect(function() BibiHub.Ativo=not BibiHub.Ativo BtnOn.BackgroundColor3=BibiHub.Ativo and Color3.fromRGB(60,180,80) or Color3.fromRGB(180,60,60) BtnOn.Text=BibiHub.Ativo and "LIGADO" or "DESLIGADO" end)

    local Lista=Instance.new("ScrollingFrame",Janela) Lista.Position=UDim2.new(0.05,0,0.27,0) Lista.Size=UDim2.new(0.9,0,0.70,0) Lista.BackgroundColor3=Color3.fromRGB(40,40,80,0.7) Lista.ScrollBarThickness=6 Lista.BackgroundTransparency=0

    return {Lista=Lista, Main=Main}
end

local function Tele(p) if Raiz and p then Raiz.CFrame=p.CFrame*CFrame.new(0,2,0) end end

local function Iniciar(ui)
    RunService.Heartbeat:Connect(function()
        Personagem=Jogador.Character Raiz=Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        if not BibiHub.Ativo or not Raiz then ui.Lista:ClearAllChildren() return end

        local Baus={}
        for _,o in pairs(Workspace:GetDescendants()) do
            local eh=o.Name:lower():find("chest") or o.Name:lower():find("treasure") or o.Name:lower():find("bau")
            local p=o:IsA("Model") and o.PrimaryPart or (o:IsA("Part") and o)
            if eh and p then local d=(Raiz.Position-p.Position).Magnitude table.insert(Baus,{Obj=o,Parte=p,Dist=d}) end
        end
        table.sort(Baus,function(a,b) return a.Dist<b.Dist end)
        ui.Lista:ClearAllChildren()

        if #Baus==0 then
            local v=Instance.new("TextLabel",ui.Lista) v.Size=UDim2.new(1,0,0,30) v.BackgroundTransparency=1 v.Text="🔍 Nenhum baú" v.TextColor3=Color3.new(0.9,0.9,0.9)
        else
            for i,b in ipairs(Baus) do
                local btn=Instance.new("TextButton",ui.Lista) btn.Size=UDim2.new(1,0,0,34) btn.Position=UDim2.new(0,0,0,(i-1)*36) btn.BackgroundColor3=Color3.fromRGB(50,50,100,0.8)
                btn.Text="📦 "..b.Obj.Name:sub(1,16).." • "..math.floor(b.Dist).."m" btn.TextColor3=Color3.new(1,1,1) btn.ZIndex=10
                btn.MouseButton1Click:Connect(function() Tele(b.Parte) end)
            end
            ui.Lista.CanvasSize=UDim2.new(0,0,0,#Baus*36)
        end
    end)
end

coroutine.wrap(function() TelaCarregamento() local ui=CriarInterface() ui.Main.Parent=Gui Iniciar(ui) print("✅ MAIN2 PRONTO") end)()