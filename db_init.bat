@echo on
del fraud.db
sqlite3.exe < db_init.txt
