return {
	Name = "takeItem";
	Aliases = {};
	Description = "Removes quantity of item from players inventory";
	Group = "Admin";
	Args = {
		{
			Type = "itemId";
			Name = "itemId";
			Description = "Item to remove";
		},
		{
			Type = "player";
			Name = "target";
			Description = "Player to remove item from";
		},
		{
			Type = "integer";
			Name = "quantity";
			Description = "Ammount to remove";
			Default = 999;
		},
	};
}