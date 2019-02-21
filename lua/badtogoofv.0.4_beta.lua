--BadToGood by noff
-- v 0.4
-- replace bad words with :)
module("badtogood", package.seeall)
console_exec("set sv_badtogood \"1\"")
warnings=4

mas={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

function onClientCommand(cl)
		i=1
		args = string.lower(argsfrom(0))
		arg2 = string.lower(argsfrom(1))
		if cvar_get("sv_badtogood") ~= "0" and string.sub(arg2, 1, 1) ~="!" and (string.match(args, "say .*") or string.match(args, "say_team .*") or string.match(args, "tell .*")) then
		file = assert(io.open("q3ut4/badwords.txt", "r")) 
		for line in file:lines() do
		    if string.match(arg2, ".*"..line..".*") then
		    for w in string.gmatch(args, "%a+") do
			    if w==line then
				    args=string.gsub (args,line,":)")
					mas[cl.id+1]=mas[cl.id+1]+1
					x=10
				end
			end
        end
		end
		file:close()	
		console_exec("spoof "..cl.id.." "..args.."")
		if x==10 then console_exec("tell "..cl.id.." do not say bad words") x=0 end
		if mas[cl.id+1]==warnings then console_exec("kick "..cl.id.." \"say bad words\" ") mas[cl.id+1]=0 end
		return i end
		
		io.output(io.open("q3ut4/badwords.txt","a+"))
        if string.sub(arg2, 1,8)=="!addword" then
            word=string.sub(arg2, 9,-i)
			io.write(""..word.."\n")
		end
		io.close()
end

function onClientDisconnect(cl)
    mas[cl.id+1]=0
end