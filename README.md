# CAPS HOLDER

### Quick start
Start a tunnel to CATS service
```shell script
./tunnel_cats.sh -u <your_name>@dev.clicktripz.com
```
From another terminal window run crawler/scarper/CATS invoker
```shell script
./runit.sh
```
Use your SQL skills to analyze data
```
sqlite3 ~/caps_holder_MM_DD_YYYY-HH_MI_SS_.db
select * from caps_holder;
```