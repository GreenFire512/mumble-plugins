-- Teamspeak 3 script by Laggi (laggi.tk) [Making advertisments on the server like who connected and disconnected with reason]
-- v 1.1 Fixed long disconnect message, reasons for got kicked and banned.
-- You have to edit path and make your own messages (find console_exec)
-- At first start script prints last user connected to teamspeak (if he still there)
-- SHOULD work fine with huge logs

module("ts3", package.seeall)

path = [[/home/username/teamspeak3-server-folder/logs/any_logfile.log]]
-- full path to teamspeak server log


-- Script starts here. Do not modify.
i = 0
timer = 0.5 -- Check ts log every 0.5sec. Do not edit or the script will miss events.
nicknames_data ={}

function onConnectTs3(nick,id)
	if nicknames_data[id] == nick then return
	else nicknames_data[id] = nick
		console_exec("say ^3"..nick.." connected to teamspeak") -- Connect message. You can edit it.
	end
end

function onDisconnectTs3(nick,id,msg)
	if nicknames_data[id] == nick then nicknames_data[id] = nil
		if string.match(msg, "invokerid=.*invokername=.*invokeruid=.*reasonmsg.*bantime.*") then msg = "reasonmsg=banned" end
		if string.match(msg, "invokerid=.*invokername=.*invokeruid=.*") then msg = "reasonmsg=kicked" end
		if msg == "reasonmsg" then msg = "none" else 
			_,_,msg = string.find(msg, "reasonmsg=(.*)") end
		console_exec("say ^3"..nick.." disconnected from teamspeak ("..msg.."^3) ") -- Disconnect message with reason. You can edit it.
	else return end
end

function checkTs3()
	local f = io.open(path, "r")-- If you are on Windows and the script doesnt work then change "r" to "rb" (path, "rb")
	if f ~= nil and f ~= ""  and f ~= " " then 
		f:seek('end', -1024) -- Lua cant directly get the last line. We grab 1024 symbols from the end. Its enough
		local text = f:read("*a")
		local b = string.match(text, ".*VirtualServer(.*)")
		f:close()
		if string.match(b, "client connected") then 
			local _,_,nick,id = string.find(b, "client connected '(.*)'.id:(%d+).") 
			onConnectTs3(nick,id)
			return end
		if string.match(b, "client disconnected") then
			local _,_,nick,id,msg = string.find(b, "client disconnected '(.*)'.id:(%d+). reason '(.*)'") 
			onDisconnectTs3(nick,id,msg)
			return end
	else f:close() return end
end

function onSVFrame(msecs) -- "Tricky" timer based on SvFrame
    i = i + 0.5
    if cvar_get("sv_teamspeak") ~= "0" and i == timer*10 then
	checkTs3()
	i = 0
    end
	if cvar_get("sv_teamspeak") == "0" then i = 0 end
end