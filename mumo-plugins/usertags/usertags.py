#!/usr/bin/env python
# -*- coding: utf-8

from mumo_module import (commaSeperatedIntegers,
			 commaSeperatedBool,
                         MumoModule)
import pickle
import re
import string

class usertags(MumoModule):
    default_config = {'usertags':(
                                ('servers', commaSeperatedIntegers, []),
                                ),
                                lambda x: re.match('(all)|(server_\d+)', x):(                                
                                ('clangroup', str, 'clan'),
                                ('clantag', str, 'tag'),
                                ('admingroup', str, 'admin'),
                                ('admintag', str, ''),
                                ('moderatorgroup', str, 'moderator'),
                                ('moderatortag', str, ''),
                                )
                    }
    
    def __init__(self, name, manager, configuration = None):
        MumoModule.__init__(self, name, manager, configuration)
        self.murmur = manager.getMurmurModule()

    def connected(self):
        manager = self.manager()
        log = self.log()
        log.debug("Register for Server callbacks")
    
        servers = self.cfg().usertags.servers
        if not servers:
            servers = manager.SERVERS_ALL
    
        manager.subscribeServerCallbacks(self, servers)

    def disconnected(self): pass
   
    def isexcluded(self, server, userid, session):
        try:
            scfg = getattr(self.cfg(), 'server_%d' % int(server.id()))
        except AttributeError:
            scfg = self.cfg().all
        
        ACL=server.getACL(0)
        
        for group in ACL[1]:
            for ex_for_afk in scfg.clangroup.split(';'):
                if (group.name == ex_for_afk):
                    if (userid in group.members):
                            userstate=server.getState(int(session))
                            userstate.name="[%s] %s"  % (scfg.clantag, userstate.name)
                            server.setState(userstate)
        
        for group in ACL[1]:
            for ex_for_afk in scfg.admingroup.split(';'):
                if (group.name == ex_for_afk):
                    if (userid in group.members):
                            userstate=server.getState(int(session))
                            userstate.name="%s %s"  % (userstate.name, scfg.admintag)
                            server.setState(userstate)


    def userConnected(self, server, state, context = None):
        try:
            scfg = getattr(self.cfg(), 'server_%d' % int(server.id()))
        except AttributeError:
            scfg = self.cfg().all
        
        if self.isexcluded(server, state.userid, state.session):
            return
    
    def userStateChanged(self, server, userid, context = None):pass
    def userTextMessage(self, server, user, message, current=None): pass
    def userDisconnected(self, server, state, context = None): pass
    def channelCreated(self, server, state, context = None): pass
    def channelRemoved(self, server, state, context = None): pass
    def channelStateChanged(self, server, state, context = None): pass     
