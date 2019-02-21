--BadToGood by noff
-- v 1.0 
-- replace bad words with good word
module("badtogood", package.seeall)
console_exec("set sv_badtogood \"1\"")
standart=":)"

function onClientCommand(cl)
    i=1
	args = string.lower(argsfrom(0))
	arg2 = string.lower(argsfrom(1))
	if cvar_get("sv_badtogood") ~= "0" and string.sub(arg2, 1, 1) ~="!" and (string.match(args, "say .*") or string.match(args, "say_team .*") or string.match(args, "tell .*")) then
		file = assert(io.open("q3ut4/badwords.txt", "r"))
			for line in file:lines() do
				aser=string.find(line,";")
				st1=string.sub(line,1,aser-1)
				st1=" "..st1.." "
				st2=string.sub(line,aser+1,-i)
				if st2=="" then st2=" "..standart else st2=" "..st2.." " end
				zx=args.." "
				args=string.gsub (zx,st1,st2)
				aser=0
			end
		file:close()	
		console_exec("spoof "..cl.id.." "..args.."")
		return i
	end
end