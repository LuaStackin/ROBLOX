local GetItemListings = game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_net@0.1.0").net:FindFirstChild("RF/TradePlaza/GetItemListings")
local TeleportToListing = game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_net@0.1.0").net:FindFirstChild("RF/TradePlaza/TeleportToListing")
return {
 AttemptPurchase = function(Listing, Player)
    return game.ReplicatedStorage.Packages["_Index"]["sleitnick_net@0.1.0"]["net"]["RF/PurchaseBoothListing"]:InvokeServer({
      ["ListingId"] = Listing, 
      ["Owner"] = Player
    })
 end,
 SnipeData = function(Method, Name, UserId, Item, ListingGUID)
    if Method:lower() == "set" then
        return true, game:GetService("HttpService"):JSONEncode({
            SellerID = UserId,
            SellerName = Name,
            ItemName = Item,
            ListingID = ListingGUID
        })
    elseif Method:lower() == "get" then
        local sd = {}
        local Success, Error = pcall(function(...)
            sd = game:GetService("HttpService"):JSONDecode(readfile("SnipeData.json"))
        end)
        return Success, sd
    else
        return false, {}
    end
 end,
 GetListings = function(Type, Name, Finisher)
    local String = '[["Name","%s"]]'
    if Finisher == true then
        String = '[["Finisher",true],["Name","%s"]]'
    end
    String = string.format(String, tostring(Name))
    return GetItemListings:InvokeServer(Type, String)
 end,
 TeleportToListing = function(Type, Name, Finisher, GUID)
    local String = '[["Name","%s"]]'
    if Finisher == true then
        String = '[["Finisher",true],["Name","%s"]]'
    end
    String = string.format(String, tostring(Name))
    return TeleportToListing:InvokeServer(Type, String, GUID)
 end
}
