-- Standard melee fighter AI
-- 5 states
-- -- idle
-- -- pursuit
-- -- attack
-- -- return
-- -- dead

return {
    {name = "chase", from = {"idle", "attacking"}, to = "pursuit"},
    {name = "calm", from = {"pursuit", "attacking"}, to = "return"},
    {name = "fight", from = {"idle", "pursuit"}, to = "attack"},
    {name = "die", from = "*", to = "dead"},
}