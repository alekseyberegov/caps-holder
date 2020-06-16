# CAPS HOLDER
*Keeping CAPS in the right place*

### Quick start
Start a tunnel to CATS service
```shell script
./tunnel_cats.sh -u <your_name>@dev.clicktripz.com
```
From another terminal window run crawler/scarper/CATS invoker
```shell script
./runit.sh
```
Use SQL to analyze data
```
sqlite3 ~/caps_holder_MM_DD_YYYY-HH_MI_SS_.db
select url, title, desc, search, cats from caps_holder;
```

### Getting more from `runit.sh`
```shell script

Usage:
  runit.sh [OPTIONS]

Run CAPS spider/scraper/CATS interrogator

Options:
  -c, --config string       use a given config for scraping
  -e, --endpoint string     specify CATS endpoint
  -l, --loglevel string     set log level (default: DEBUG)
  -d, --debug               set debug mode for CATS
  -s, --settings            show default settings
  -h, --help                show help
```