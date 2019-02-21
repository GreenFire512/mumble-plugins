-- AfkToSpec by keyn (ut-ukraine.org.ua)
-- v 0.1
-- MOD "afktospec" implementation on Lua
--dbdrdrn

module("afktospec", package.seeall)

console_exec("set sv_afktospec \"1\"")

way = "cp" -- "cp" for bigtext, "chat" for msg in chat
timeout = 60 -- seconds before player forced to spectator

utime = os.time();
players_pos = {}

maxclients = cvar_get('sv_maxclients') - 1

function onSVFrame(msecs)

    if os.time() > utime then
        id = 0
        print ()
        while id <= maxclients do
            cl = getClient(id);
            if cl.name ~= nil and cl.team ~= nil then
                x, y, z = cl:getLocation(id);
                pos = x.." "..y.." "..z;

                if players_pos[id] ~= nil then
                    if players_pos[id] ~= pos then
                        --print(cleanstr(cl.name)..' moved');
                        players_pos[id] = pos;
                    else
                        --print(cleanstr(cl.name)..' afk?')
                        console_exec('forceteam '..id..' spectator');
                        console_exec("scc "..id.." "..way.." \"^1You forced to spectator after "..timeout.."sec of inactivity\"")
                    end
                else
                    players_pos[id] = pos;
                end
            end

            id = id + 1
        end
        utime = os.time() + timeout;
    end
end

function onSVMapLoad(mapName)
    players_pos = {}
end

function onSVMapRestart()
    players_pos = {}
end
	