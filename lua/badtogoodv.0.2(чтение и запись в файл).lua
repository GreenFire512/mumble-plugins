--BadToGood by noff
-- v 0.2
-- replace bad words with :)
module("badtogood", package.seeall)

console_exec("set sv_badtogood \"1\"")

function onClientCommand(cl)
		i=1
		args = string.lower(argsfrom(0))
		arg2 = string.lower(argsfrom(1))
		if cvar_get("sv_badtogood") ~= "0" and string.sub(arg2, 1, 1) ~="!" then
		file = assert(io.open("q3ut4/badwords.txt", "r")) 
		for line in file:lines() do
		    args=string.gsub (args,line,":)")
        end
		file:close()		
		console_exec("spoof "..cl.id.." "..args.."")
		return i end
		
		io.output(io.open("q3ut4/badwords.txt","a+"))
        if string.sub(arg2, 1,8)=="!addword" then
            word=string.sub(arg2, 9,-i)
			io.write(""..word.."\n")
		end
		io.close()
end