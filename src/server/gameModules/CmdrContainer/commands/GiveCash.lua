return {
	Name = "giveCash";
	Aliases = {};
	Description = "Gives a player cash";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "Player to give cash to";
		},
		{
			Type = "integer";
			Name = "amount";
			Description = "Amount of cash to give";
			Default = 100;
		},
	};
}