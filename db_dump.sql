PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DROP TABLE IF EXISTS 'domainlist_by_group';
DROP TABLE IF EXISTS 'group';
DROP TABLE IF EXISTS 'domainlist';
DROP TABLE IF EXISTS 'adlist';
CREATE TABLE IF NOT EXISTS "group"
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    name TEXT UNIQUE NOT NULL,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    description TEXT
);
INSERT INTO "group" VALUES(0,1,'Default',1748690792,1748690792,'The default group');
CREATE TABLE domainlist
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type INTEGER NOT NULL DEFAULT 0,
    domain TEXT NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    comment TEXT,
    UNIQUE(domain, type)
);
CREATE TABLE adlist
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    address TEXT NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    comment TEXT,
    date_updated INTEGER,
    number INTEGER NOT NULL DEFAULT 0,
    invalid_domains INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 0,
    abp_entries INTEGER NOT NULL DEFAULT 0,
    type INTEGER NOT NULL DEFAULT 0,
    UNIQUE(address, type)
);
INSERT INTO adlist VALUES(1,'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',1,1748690792,1748690792,'Migrated from /etc/pihole/adlists.list',1748690792,184937,1,2,0,0);
INSERT INTO adlist VALUES(3,'https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/multi.txt',1,1748692719,1748692719,NULL,1748692938,167135,0,2,167135,0);
INSERT INTO adlist VALUES(4,'https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt',1,1748693152,1748693152,'PRO+',1748693159,204423,0,1,204423,0);
CREATE TABLE domainlist_by_group
(
    domainlist_id INTEGER NOT NULL REFERENCES domainlist (id) ON DELETE CASCADE,
    group_id INTEGER NOT NULL REFERENCES "group" (id) ON DELETE CASCADE,
    PRIMARY KEY (domainlist_id, group_id)
);
COMMIT;
