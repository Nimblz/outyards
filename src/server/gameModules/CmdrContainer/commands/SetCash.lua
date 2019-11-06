return {
	Name = "setCash";
	Aliases = {};
	Description = "Sets a player's cash";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "Player to set";
		},
		{
			Type = "integer";
			Name = "value";
			Description = "Value to set cash to";
			Default = 100;
		},
	};
}