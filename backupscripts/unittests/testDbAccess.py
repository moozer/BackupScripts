'''
Created on Nov 2, 2013

@author: moz
'''
import unittest
from SqfsMd5Db import Md5Db

DataDir = "testdata/"
Md5File = DataDir + "Md5FiveEntries.txt"
Md5FileEntriesCount = 5

class Test(unittest.TestCase):


    def setUp(self):
        self.Md5Db = Md5Db( ":memory: ")


    def tearDown(self):
        pass


    def testAddMd5File(self):
        EntriesCount = self.Md5Db.Count
        
        self.Md5Db.Add( Md5File )
        self.assertEqual( Md5Db.Count, EntriesCount+Md5FileEntriesCount )


if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()