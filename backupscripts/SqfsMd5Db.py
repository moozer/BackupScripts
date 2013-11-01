#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
Created on Nov 2, 2013

@author: moz
'''


import sqlite3 as lite
import sys
        
class Md5Db:
    
    
    def __init__(self, Filename ):
        self._count = 0
        self._con = None
        self._Filename = Filename
        self._initDb(self._Filename)

    def _initDb( self, DbFilename ):
        try:
            self._con = lite.connect('test.db')
            
            cur = self._con.cursor()    
            cur.execute('SELECT SQLITE_VERSION()')
            
            data = cur.fetchone()
            
            print "SQLite version: %s" % data                
            
        except lite.Error, e:
            
            print "Error %s:" % e.args[0]
            sys.exit(1)
 
    
    @property
    def Count(self):
        return self._count
    


if __name__ == '__main__':

    pass