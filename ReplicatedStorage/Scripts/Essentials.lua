local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VoiceChatService = game:GetService("VoiceChatService")
local VoiceChatInternal = game:GetService("VoiceChatInternal")
local VRService = game:GetService("VRService")
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")
local RunService = game:GetService("RunService")

-- Module
local Essentials = {}

-- Players Functions
function Essentials.IsPlayerVerified(player: Player)
	-- If player IsVerified then return true
	if player:IsVerified() then
		return true
	end
	
end

function Essentials.IsPlayerBadgeVerified(player: Player, setAttribute: boolean, debugging: boolean)
	if player.HasVerifiedBadge then
		return true
	end
	
	if setAttribute == true and player.HasVerifiedBadge then
		player:SetAttribute("HasVerifiedBadge", true)
	end
	
	if debugging == true and player.HasVerifiedBadge then
		print("Essentials:", player.Name, "has the Verified Badge")
		
	elseif debugging == true and not player.HasVerifiedBadge then
		print("Essentials:", player.Name, "does not have the Verified Badge")
	end
	
end

function Essentials.IsGameCreator(player: Player, setAttribute: boolean, debugging: boolean)
	if game.CreatorType == Enum.CreatorType.User and player.UserId == game.CreatorId then
		return true
	end
	
	if setAttribute == true and player.UserId == game.CreatorId then
		player:SetAttribute("Creator", true)
	end

	if debugging == true and player.UserId == game.CreatorId then
		print("Essentials:", player.Name, "is the Game Creator/Developer")
		
	elseif debugging == true and player.UserId ~= game.CreatorId then
		print("Essentials:", player.Name, "is not the Game Creator/Developer")
	end
	
end

function Essentials.IsGroupCreator(player: Player, groupId: number, setAttribute: boolean, debugging: boolean)
	if game.CreatorType == Enum.CreatorType.Group and GroupService:GetGroupInfoAsync(groupId).Owner.Id then
		return true
	end

	if setAttribute == true and GroupService:GetGroupInfoAsync(groupId).Owner.Id then
		player:SetAttribute("Creator", true)
	end

	if debugging == true and GroupService:GetGroupInfoAsync(groupId).Owner.Id then
		print("Essentials:", player.Name, "is the Group Creator")

	elseif debugging == true and not GroupService:GetGroupInfoAsync(groupId).Owner.Id then
		print("Essentials:", player.Name, "is not the Group Creator")
	end
	
end

function Essentials.IsInGroup(player: Player, groupId: number, setAttribute: boolean, debugging: boolean)
	if player:IsInGroup(groupId) then
		return true
	end
	
	if setAttribute == true and player:IsInGroup(groupId) then
		player:SetAttribute("IsInGroup", true)
	end
	
	if debugging == true and player:IsInGroup(groupId) then
		print("Essentials:", player.Name, "is in the group! groupId:", groupId)
		
	elseif debugging == true and not player:IsInGroup(groupId) then
		print("Essentials:", player.Name, "is not in the group! groupId", groupId)
	end
	
end

function Essentials.IsFriendsWith(player: Player, friendsWithPlayerUserId: number, setAttribute: boolean, debugging: boolean)
	if player:IsFriendsWith(friendsWithPlayerUserId) then
		return true
	end
	
	if setAttribute == true and player:IsFriendsWith(friendsWithPlayerUserId) then
		player:SetAttribute("Friends", true)
	end
	
	if debugging == true and player:IsFriendsWith(friendsWithPlayerUserId) then
		print("Essentials:", player.Name, "is friends with", Players:GetNameFromUserIdAsync(friendsWithPlayerUserId))
		
	elseif debugging == true and not player:IsFriendsWith(friendsWithPlayerUserId) then
		print("Essentials:", player.Name, "is not friends with", Players:GetNameFromUserIdAsync(friendsWithPlayerUserId))
	end
	
end

-- VRService Functions
function Essentials.VRAutomaticScaling(player: Player, setAutomaticScaling: boolean, setAttribute: boolean, debugging: boolean)
	if UserInputService.VREnabled or VRService.VREnabled then
		
		if setAutomaticScaling == true then
			VRService.AutomaticScaling = Enum.VRScaling.World
		else
			VRService.AutomaticScaling = Enum.VRScaling.Off
		end
		
		if setAttribute == true and Enum.VRScaling.World then
			player:SetAttribute("VR_WorldScaling", true)
		elseif setAttribute == true and Enum.VRScaling.Off then
			player:SetAttribute("VR_WorldScaling", false)
		end
		
		if debugging == true and setAutomaticScaling == true then
			print("Essentials:", player.Name, "is in VR and the scaling is set to World")
			
		elseif debugging == true and setAutomaticScaling == false then
			print("Essentials:", player.Name, "is in VR and the scaling is set to Off")
		end
		
	end
end

function Essentials.VRSafetyBubbleMode(noone: boolean, friends: boolean, anyone: boolean, debugging: boolean)
	if UserInputService.VREnabled or VRService.VREnabled then
		
		if noone == true then
			Enum.VRSafetyBubbleMode = Enum.VRSafetyBubbleMode.NoOne
			
			if debugging == true then
				print("Essentials: VRSafetyBubbleMode is set to NoOne")
			end
			
		elseif friends == true then
			Enum.VRSafetyBubbleMode = Enum.VRSafetyBubbleMode.OnlyFriends
			
			if debugging == true then
				print("Essentials: VRSafetyBubbleMode is set to Friends")
			end
			
		elseif anyone == true then
			Enum.VRSafetyBubbleMode = Enum.VRSafetyBubbleMode.Anyone
			
			if debugging == true then
				print("Essentials: VRSafetyBubbleMode is set to Anyone")
			end
		end
		
	end
	
end

-- VoiceChatService Functions
function Essentials.IsVoiceEnabledForUserIdAsync(player: Player, setAttribute: boolean, debugging: boolean)
	local success, enabled = pcall(VoiceChatService.IsVoiceEnabledForUserIdAsync, VoiceChatService, player.UserId)
	
	if success and enabled then
		return true
	end
	
	if setAttribute == true and success and enabled then
		player:SetAttribute("HasVoice", true)
	end
	
	if debugging == true and not success or success == false or not enabled then
		warn("Error fetching", player.Name .. "'s Voice Permissions or", player.Name .. "'s Voice is disabled")
		warn("For more information, please visit https://www.roblox.com/info/spatial-voice")
		
	elseif debugging == true and success and enabled then
		print("Fetched", player.Name .. "'s Voice permissions, Voice is enabled")
	end
	
end

-- MarketplaceService Functions
function Essentials.PromptPurchase(player: Player, assetId: number, debugging: boolean)
	local success, errorMessage = pcall(MarketplaceService.PromptPurchase, MarketplaceService, player, assetId)
	
	if debugging == true and not success or success == false then
		warn("PromptPurchaseError:", errorMessage)
		return
			
	elseif debugging == true and success then
		print("Prompted Purchase for", player.Name, "with the assetId of", assetId)
	end
	
end

function Essentials.PromptProductPurchase(player: Player, productId: number, debugging: boolean)
	local success, errorMessage = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, player, productId)
	
	if debugging == true and not success or success == false then
		warn("PromptProductPurchaseError:", errorMessage)
		return
			
	elseif debugging == true and success then
		print("Prompted Product Purchase for", player.Name, "with the productId of", productId)
	end
	
end

function Essentials.PromptGamePassPurchase(player: Player, gamePassId: number, debugging: boolean)
	local success, errorMessage = pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, player, gamePassId)
	
	if debugging == true and not success or success == false then
		warn("PromptGamePassPurchaseError:", errorMessage)
		return
			
	elseif debugging == true and success then
		print("Prompted GamePass Purchase for", player.Name, "with the gamePassId of", gamePassId)
	end
	
end

function Essentials.UserOwnsGamepassAsync(player: Player, gamePassId: number, debugging: boolean)
	local success, errorMessage = pcall(function()
		MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassId)
	end)
	
	if debugging == true and not success or success == false then
		warn("UserOwnsGamepassAsyncError:", errorMessage)
		return
	
	elseif debugging == true and success then
		return true
	end
	
end

function Essentials.PlayerOwnsAsset(player: Player, assetId: number, debugging: boolean)
	local success, errorMessage = pcall(MarketplaceService.PlayerOwnsAsset, MarketplaceService, player, assetId)
	
	if debugging == true and not success or success == false then
		warn("PlayerOwnsAssetError:", errorMessage)
		return
			
	elseif debugging == true and success then
		return true
	end
	
end

function Essentials.PromptPremiumPurchase(player: Player, debugging: boolean)
	local success, errorMessage = pcall(MarketplaceService.PromptPremiumPurchase, MarketplaceService, player)
	
	if debugging == true and not success or success == false then
		warn("PromptPremiumPurchaseError:", errorMessage)
		return
			
	elseif debugging == true and success then
		print("Prompted Premium Purchase for", player.Name)
	end
	
end

return Essentials