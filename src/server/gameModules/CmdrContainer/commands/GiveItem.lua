return {
	Name = "giveItem";
	Aliases = {};
	Description = "Gives a player an item with the specified quantity";
	Group = "Admin";
	Args = {
		{
			Type = "itemId";
			Name = "itemId";
			Description = "Item to give";
		},
		{
			Type = "player";
			Name = "target";
			Description = "Player to give item to";
		},
		{
			Type = "integer";
			Name = "quantity";
			Description = "Ammount of items to give";
			Default = 1;
		},
	};
}