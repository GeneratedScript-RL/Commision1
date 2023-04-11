--//Services

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

--//Vars

local ResponsePrompt = ReplicatedStorage.Remotes.PromptResponse
local EventPrompt = ReplicatedStorage.EventPrompt
local Sword = ServerStorage.ClassicSword

function StartEvent()
	local amountofplayersprompted = #Players:GetChildren()
	local attendees = {}
	local connection
	local responsesrecieved = 0
	local connections = {}
	
	for _, players in pairs(Players:GetChildren()) do
		local gui = EventPrompt:Clone()
		gui.Parent = players.PlayerGui
	end

	connection = ResponsePrompt.OnServerEvent:Connect(function(player, response)
		if response then
			table.insert(attendees, workspace:WaitForChild(player.Name))
		end
		responsesrecieved = responsesrecieved + 1
	end)

	repeat wait(1) until responsesrecieved == amountofplayersprompted

	connection:Disconnect()

	for _, attendee in pairs(attendees) do

		local newconnection
		local Humanoid = attendee.Humanoid

		attendee.HumanoidRootPart.CFrame = CFrame.new(workspace.EventPart1.Position) * CFrame.new(0, 5, 0)
		newconnection = Humanoid.Died:Connect(function()
			table.remove(attendees, table.find(attendees, attendee))
		end)
		
		local swordnew = Sword:Clone()
		swordnew.Parent = Players[attendee.Name].Backpack
		
		table.insert(connections, newconnection)
	end
end

function StartCooldownEvent()
	task.spawn(function()
		local ammins = 10
		local seconds = 60

		while wait(0.001) do

			seconds = seconds-1
			if seconds < 1 then

				ammins = ammins-1

				if ammins == -1 then
					break
				else
					seconds = 60
				end

			end
			workspace:SetAttribute("TimerStatus", ammins..":"..seconds.." Till next event!")
		end

		workspace:SetAttribute("TimerStatus", "Event is happening.")
		StartEvent()
	end)
end

StartCooldownEvent()