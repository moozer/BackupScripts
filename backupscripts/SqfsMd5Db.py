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
        self._con = lite.connect(DbFilename)
        
        cur = self._con.cursor()    
        cur.execute('SELECT SQLITE_VERSION()')
        
        data = cur.fetchone()
        
        print "SQLite version: %s" % data                
        
        try:
            cur.execute('''CREATE TABLE md5value(md5set, md5, filename)''') 
        except lite.Error, e:
            print "Db already initialized"
            

 
    
    @property
    def Count(self):
        cur = self._con.cursor()    
        cur.execute('SELECT count(*) from md5value')
        
        data = cur.fetchone()        
        self._count = data[0]
        return self._count
    

    
    def Add(self, Md5Filename ):
        f = open( Md5Filename, "r")
        cur = self._con.cursor()    
        
#        for md5, fileentry in f:
        for entry in f:
            md5, fileentry = entry.split(' ', 1 );
            cur.execute("insert into md5value(md5set, md5, filename) values (?,?,?)",( Md5Filename, md5, fileentry));
        pass


if __name__ == '__main__':
    if len( sys.argv ) < 2:
        print "usage: SqfsMd5Db <db file> <md5 file to add>"
        exit( -1) 

    md5Db = Md5Db( sys.argv[0])
    md5Db.Add( sys.argv[1] )
    
    pass