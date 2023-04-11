wait(1)

script.Parent.TextLabel.Text = workspace:GetAttribute("TimerStatus")

while wait() do
	script.Parent.TextLabel.Text = workspace:GetAttribute("TimerStatus")
end