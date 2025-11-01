local Player = game:GetService("Players").LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local AutoStandGui = Instance.new("ScreenGui")
AutoStandGui.Name = "AutoStandGui"
AutoStandGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = AutoStandGui

local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(0, 100, 0, 40)
StartBtn.Position = UDim2.new(0.5, -50, 0.3, 0)
StartBtn.Text = "START FARM"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
StartBtn.Parent = Frame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0, 200, 0, 30)
Status.Position = UDim2.new(0.5, -100, 0.7, 0)
Status.Text = "Status: Ready"
Status.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Status.Parent = Frame

local function farmStands()
    while task.wait(1) do
        Status.Text = "Status: Farming..."
        
        -- Поиск стрел в инвентаре
        local arrow = Player.Backpack:FindFirstChild("Stand Arrow") 
        if not arrow then
            arrow = Player.Character:FindFirstChild("Stand Arrow")
        end
        
        if arrow then
            -- Использование стрелы
            pcall(function()
                Player.Character.Humanoid:EquipTool(arrow)
                task.wait(0.5)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,0)
                task.wait(0.1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,0)
            end)
        end
        
        -- Поиск стрел в мире
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("arrow") then
                Player.Character:MoveTo(obj.Position)
                task.wait(2)
            end
        end
    end
end

StartBtn.MouseButton1Click:Connect(function()
    farmStands()
end)