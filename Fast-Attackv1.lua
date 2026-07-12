Services = setmetatable({}, {__index = function(self, name)
    local s, c = pcall(function() return cloneref(game:GetService(name)) end)
    if s then rawset(self, name, c) return c
    else error("Invalid Roblox Service: " .. tostring(name)) end
end})
FastAttack = loadstring([[
        local Modules = game.ReplicatedStorage.Modules
        local Net = Modules.Net
        local Register_Hit, Register_Attack = Net:WaitForChild('RE/RegisterHit'), Net:WaitForChild('RE/RegisterAttack')
        local Funcs = {}
        function GetAllBladeHits()
            bladehits = {}
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 
                and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
                    table.insert(bladehits, v)
                end
            end
            return bladehits
        end
        function Getplayerhit()
            bladehits = {}
            for _, v in pairs(workspace.Characters:GetChildren()) do
                if v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 
                and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
                    table.insert(bladehits, v)
                end
            end
            return bladehits
        end

        local Net = (Services.ReplicatedStorage.Modules.Net)

        local RegisterAttack = require(Net):RemoteEvent('RegisterAttack', true)
        local RegisterHit = require(Net):RemoteEvent('RegisterHit', true)

        function Funcs:Attack()
            
            
            local bladehits = {}
            for r,v in pairs(GetAllBladeHits()) do
                table.insert(bladehits, v)
        
            end
            for r,v in pairs(Getplayerhit()) do
                table.insert(bladehits, v)
            end
            
            if #bladehits == 0 then
                
                return
            end
            
            local args = {
                [1] = nil;
                [2] = {},
                [4] = '078da341'
            }
            for r, v in pairs(bladehits) do
                
                
                RegisterAttack:FireServer(0)
                if not args[1] then
                    args[1] = v.Head
                end
                table.insert(args[2], {
                    [1] = v,
                    [2] = v.HumanoidRootPart
                })
                table.insert(args[2], v)
            end
            
            
            RegisterHit:FireServer(unpack(args))
        end

        task.spawn(function() 
            while task.wait(.05) do 
                if _G.FastAttack == os.time() then 
                    pcall(function() 
                        Funcs:Attack() 
                    end)
                end 
            end
        end)

        getgenv().Attack = function(MonResult) 
            pcall(function() 
                _G.FastAttack = os.time()
            end)
        end 
        ]])

FastAttack()
getgenv().Attack()
