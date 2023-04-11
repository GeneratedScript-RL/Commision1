--//Services

local ReplicatedStorage = game:GetService("ReplicatedStorage")

--//Vars

local Event = ReplicatedStorage.Remotes.PromptResponse

script.Parent.Yes.Activated:Connect(function()
	Event:FireServer(true)
	script.Parent.Parent.Parent.Enabled = false
end)

script.Parent.No.Activated:Connect(function()
	Event:FireServer(false)
	script.Parent.Parent.Parent.Enabled = false
end)

task.spawn(function()
	wait(10)
	if script.Parent.Parent.Parent.Enabled == true then
		Event:FireServer(false)
		script.Parent.Parent.Parent.Enabled = false
	end
end)