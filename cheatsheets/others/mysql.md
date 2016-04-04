# MySQL

## Check a general_log when MySQL is running

Current status is

```markdown
mysql> SHOW VARIABLES LIKE "general_log%";
+------------------+------------------------------------+
| Variable_name    | Value                              |
+------------------+------------------------------------+
| general_log      | OFF                                |
| general_log_file | /var/lib/mysql/xxx.log             |
+------------------+------------------------------------+
2 rows in set (0.01 sec)

mysql> SHOW VARIABLES LIKE "log_output";
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| log_output    | FILE  |
+---------------+-------+
1 row in set (0.00 sec)
```

Activate

```markdown
mysql> SET GLOBAL general_log = "ON";
```

When check is done,

```markdown
mysql> SET GLOBAL general_log = "OFF";
```

## Easy search for datetime

```mysql
SELECT * FROM `sample_table` WHERE `sample_time` LIKE '2014-07-26%';
```

See [this](http://pentan.info/sql/mysql/datetime2data_speed.html).

## Reset root password

```markdown
$ service mysqld stop
$ /usr/bin/mysqld_safe --skip-grant-tables
$ mysql -u root
mysql> UPDATE mysql.user SET password=PASSWORD('new_password') WHERE user='root';
mysql> FLUSH PRIVILEGES;
```

See [this](http://qiita.com/is0me/items/91a0af0342c307b94a16).

## Replication

Master: Create a user for replication.

```markdown
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'xxx.xxx.xxx.xxx' IDENTIFIED BY 'password string';
```

Master: Update my.cnf.

```markdown
[mysqld]
log-bin=mysql-bin
server-id=1001
```

Slave: Update my.cnf.

```markdown
[mysqld]
server-id=1002
```

Master: Check MASTER STATUS by terminal 1.

```markdown
mysql > FLUSH TABLES WITH READ LOCK;
mysql > SHOW MASTER STATUS;

+------------------+----------+--------------+------------------+
| File | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 | 123 | | |
+------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
```

Master: Create master data snapshot by terminal 2.

```markdown
mysqldump --all-databases --events --lock-all-tables > dbdump.db
```

Master: Unlock tables.

```markdown
mysql > UNLOCK TABLES;
```

Slave: Update database by dbdump.db.

```markdown
mysql < dbdump.db
```

Slave: Change master infomation.

```markdown
mysql > CHANGE MASTER TO
MASTER_HOST='xxx.xxx.xxx.xxx',
MASTER_USER='repl',
MASTER_PASSWORD='password',
MASTER_LOG_FILE='mysql-bin.000001',
MASTER_LOG_POS=123;
```

Slave: Start slave.

```markdown
mysql > START SLAVE;
```
