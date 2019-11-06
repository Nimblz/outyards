return {
	Name = "giveAllItems";
	Aliases = {};
	Description = "Gives a player all items in the game";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "Player to give all items to";
		},
		{
			Type = "integer";
			Name = "quantity";
			Description = "Quantity of each item to give";
			Default = 1;
		},
	};
}