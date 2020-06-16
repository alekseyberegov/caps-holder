# CAPS HOLDER

### Quick start
Start a tunnel to CATS service
```shell script
./tunnel_cats.sh -u <your_name>@dev.clicktripz.com
```
From another terminal window
```shell script
./runit.sh
sqlite3 ~/caps_holder_MM_DD_YYYY-HH_MI_SS_.db
```
Use your SQL skills to analyze data
```
select * from caps_holder;
```