-- This Is A Script With It Kept In Mind You Have A Datastore In Place For The Cash

-- Woohoo DataStoreService
local DataStoreService = game:GetService("DataStoreService")
-- Yay PlayerCash Via A Data Store Already Made
local PlayerCash = DataStoreService:GetDataStore("PlayerCash")

-- When A Player Is Added It Makes Sure The Player Has Their Stats
function OnPlayerAdded(player: Player)
  -- Declares The Value Of Stats And Instances A Folder In The Player
	local stats = Instance.new("Folder", player)
  -- Changes The Folders Name To "leaderstats"
	stats.Name = 'leaderstats'
  -- Declares The Value Of Cash And Instances A New NumberValue In Stats
	local Cash = Instance.new("NumberValue", stats)
  -- Changes The NumberValue's Name To "$"
	Cash.Name = "$"
  -- Changes The NumberValue To 0
	Cash.Value = 0
  -- It Checks For The Data Being Loaded In The BooleanValue(BoolValue) Using The DataLoaded Value
	local DataLoaded = Instance.new("BoolValue", player)
  -- Changes The BoolValue's Name To CashDataLoaded
	DataLoaded.Name = "CashDataLoaded"
  -- Sets The BoolValue To False
	DataLoaded.Value = false
  -- Declares The Data Value 
	local data
  -- Declares The Attempts To Try To Load The DB(DataBase)
	local attempts = 10

	repeat
		local success, err = pcall(function()
			data = PlayerCash:GetAsync(player.UserId)
		end)
		if success then
			print("Success!")
			DataLoaded.Value = true
			break
		else
			warn("Was problem with datastore! (Attempts left ", attempts, ")")
		end
		task.wait(1)
		attempts = attempts - 1
	until attempts <= 0
-- If The Value Still Hasn't Loaded Of The Cash After Joining Essentially This Adds A Warn To The Console And Kicks The Player With The Reason Of "Couldn't load data, please try to rejoin later"
	if not DataLoaded.Value then
		warn("Player " .. player.Name .. "'s cash data has not been loaded!")
		player:Kick("Couldn't load data, please try to rejoin later")
		return
	end
-- If The Data Is Loaded Then Every 2 Seconds It Adds 2 To The Cash Value
	if data then
		Cash.Value = data
	end
	while true do
		task.wait(2)
		Cash.Value = Cash.Value + 2
	end
end
-- This Is For When The Player Leaves It Calls A DataStore Save Using A Pcall And Stuff But Im Not Gonna Go Into Detail On This
function OnPlayerRemoving(player: Player)
	if player:FindFirstChild("CashDataLoaded") and player.CashDataLoaded.Value == true then
		local attempts = 10

		repeat
			local success, err = pcall(function()
				PlayerCash:SetAsync(player.UserId, player.leaderstats:FindFirstChild("$").Value)
			end)
			if success then
				print("Success!")
				break
			else
				warn("Was problem with datastore! (Attempts left ", attempts, ")")
			end
			wait(1)
			attempts = attempts - 1
		until attempts <= 0
		if attempts <= 0 then
			warn("Player " .. player.Name .. "'s cash data has not been saved!")
		end
	end
end
-- Connects The Player Joining And Leaving To The Functions
game.Players.PlayerAdded:Connect(OnPlayerAdded)
game.Players.PlayerRemoving:Connect(OnPlayerRemoving)
