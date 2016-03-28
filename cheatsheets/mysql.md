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
