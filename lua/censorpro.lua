-- CensorPRO by Laggi (laggi.tk/forum)
-- v1.0
-- replace bad words with ****

console_exec("set sv_censorpro \"1\"")

module("censorpro", package.seeall)

words = {
"shit",
"ass",
"gay",
"asshole",
"fuck",
"fuck you",
"fucker",
"idi v shopu",
"xyi",
"xyj",
"huj",
"hui",
"huj tebe",
"hui tebe",
"xyi tebe",
"xuj tebe",
"ne pizdi",
"pisdyat",
"idi v pizdu",
"bla",
"blya",
"blia",
"blad",
"blyad",
"shopa",
"nahuj",
"nahui",
"zaebis",
"3aebic",
"saebis",
"saebza",
"zaebza",
"shuali",
"sxyali",
"gitler kaput",
"otebis",
"otebiska",
"zaebal",
"3aebalo",
"3aebali",
"3aebalsya",
"zaebali",
"zaebalo",
"zaebalsya",
"scheisse",
"fak you",
"fak",
"fak tebe",
"fak",
"faak",
"fuuuuck",
"fuuuck",
"fuuck",
"fuuuuuck",
"fuuuuuuck",
"faaak",
"faaaak",
"faakaa",
"ffuck",
"3aebali vi menya",
"sfigali?",
"fu",
"f u"
"motherfucker",
"cunt",
"moron",
"cock",
"dick",
"bitch",
"biatch",
"fag",
"nigger",
"pussy",
"flikker",
"homo",
"kanker",
"teringlijer",
"kut",
"hoer",
"neuk",
"vittu",
"paskiainen",
"kusipaeae",
"fitte",
"pikk",
"hore",
"fitta",
"knullare",
"kuksugare",
"huora",
"spica",
"piroca",
"caralho",
"puta",
"cabra",
"maricon",
"pinche",
"putin",
"batard",
"negro",
"encule",
"enculer",
"merde",
"putain",
"connard",
"salope",
"bite",
"admincarton",
"petasse",
"scheisse",
"arsch",
"huendin",
"kopulieren",
"fick",
"chuj",
"kutas",
"fiut",
"pedal",
"pizda",
"ciota",
"dupek",
"kurwa",
"skurwysyn",
"zajebac",
"pojebac",
"wyjebac",
"pierdolic",
"rozpierdalac",
"popierdolony",
"wypierdalac",
"nigger",
"cunt",
"nazi",
"jihad",
"hitler",
"asshole",
"mda",
"pff"
}

checknames = 0 -- can be 0 or 1

function onClientCommand(cl)
	i = 1 -- we need to return true value to hook command but i think just returning "true" will also work
	
    args = string.lower(argsfrom(0))
    arg2 = string.lower(argsfrom(1))
    if cvar_get("sv_censorpro") ~= "0" and string.sub(arg2, 1, 1) ~="!" then

		for w = 1, table.getn(words) do
		if string.match(args, "say .*"..words[w]..".*") then
			for w = 1, table.getn(words) do -- check again, maybe we have more words?
			if string.match(args, "say .*"..words[w]..".*") then

			arg2 = string.gsub(arg2, words[w], ':)')
			end end
		console_exec("spoof "..cl.id.." say "..arg2.."")
		return i end 
		if string.match(args, "tell %d+ .*"..words[w]..".*") then -- the same but for /tell
			for w = 1, table.getn(words) do
			if string.match(args, "tell %d+ .*"..words[w]..".*") then

			--arg2 = string.gsub(arg2, words[w], function(test) test = string.gsub(words[w], ".", "*") return test end )
			arg2 = string.gsub(arg2, words[w], ':)')
			end end
		console_exec("spoof "..cl.id.." tell "..arg2.."")
		return i end 
		if string.match(args, "say_team %d+ .*"..words[w]..".*") then -- the same but for /tell
			for w = 1, table.getn(words) do
			if string.match(args, "say_team %d+ .*"..words[w]..".*") then

			arg2 = string.gsub(arg2, words[w], ':)')
			end end
		console_exec("spoof "..cl.id.." say_team "..arg2.."")
		return i end
		end
	end
end

function onClientUserinfoChanged(cl)
	if cvar_get("sv_censorpro") ~= "0" and checknames ~= 0 then
		if (not cl.userinfo or not cl.name) then return end

      		clname = string.lower(cl.name)
      		for w = 1, table.getn(words) do
		if string.match(clname, ""..words[w].."") then
		newname = string.gsub(clname, words[w], function(test) test = string.gsub(words[w], ".", "*") return test end )
            	console_exec("forcecvar "..cl.id.." name "..newname.."")
		end
		end
	end
end
