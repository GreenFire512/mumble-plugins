-- KilledBy by Laggi (laggi.tk/forum)
-- v 0.1
-- MOD "killed by" implementation on Lua

console_exec("set sv_killedby \"1\"")

module("killedby", package.seeall)

way = "cp" -- "cp" for bigtext, "chat" for msg in chat

msgs = {
"^7Killed by ^2$killer",
"^2$killer^7 killed you",
"You was killed by ^2$killer"
}

-- end of cfg

msgn = 1
function onFSWrite(filename, data)
	if cvar_get("sv_killedby") == "0" then return end
	if msgn > table.getn(msgs) then msgn = 1 end
	if string.match(data, "Kill: %d+%s%d+%s%d+:.*") then
		_,_,klr,kld,klrn = string.find(data, "Kill: (%d+)%s(%d+)%s%d+: (.*) killed")
		if klr == kld or klr == "1022" or klr == 1022 then return end
		msgf = msgs[msgn]
		if string.match(msgf, "$killer") then
			_,_,p1,p2 = string.find(msgf, "(.*)$killer(.*)")
			msgf = p1..klrn..p2
			console_exec("scc "..kld.." "..way.." \""..msgf.."\"")
			msgn = msgn + 1
		else print("Lua [KilledBy]: Incorrect message in settings") msgn = msgn + 1 end

	end
end
