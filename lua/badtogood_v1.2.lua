--BadToGood by noff
-- v 1.2 
-- replace bad words with good word

module("badtogood", package.seeall)
console_exec("set sv_badtogood \"1\"")
standart=":)"

function maksgsub (s, pat, repl)
    pat = string.gsub (pat, '(%a)',
                function (v) return '['..string.upper(v)..string.lower(v)..']' end)
    return string.gsub (s, pat, repl)
end

function ololo(file,stq)
	fil = assert(io.open("q3ut4/"..file..".txt", "r"))
		for line in fil:lines() do
			aser=string.find(line,";")
			st1=string.sub(line,1,aser-1)
			st2=string.sub(line,aser+1,-i)
			if st2=="" then st2=" "..standart else st2=" "..st2.." " end 
			zx=stq.." "
			stq=maksgsub(zx,st1,st2)
			aser=0
		end
	fil:close()
	return stq
end

function onClientCommand(cl)
    i=1
	args =argsfrom(0)
	arg2 =argsfrom(1)
	
	if cvar_get("sv_badtogood") ~= "0" and string.sub(arg2, 1, 1) ~="!" and (string.match(args, "say .*") or string.match(args, "say_team .*") or string.match(args, "tell .*")) then	
        args=ololo("badwords",args)
		args=ololo("words",args)
		console_exec("spoof "..cl.id.." "..args.."")
		return i 
	end
	
	if cvar_get("sv_badtogood") ~= "0" and string.sub(arg2, 1, 1) =="!" and (string.match(args, "say .*") or string.match(args, "tell .*")) then
		args=ololo("cmdb3",args)
		console_exec("spoof "..cl.id.." "..args.."")
		return i
	end	
end