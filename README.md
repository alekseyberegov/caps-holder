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
./caps_stats.sh 
```
### Using `runit.sh`
```shell script

Usage:
  runit.sh [OPTIONS]

Run CAPS spider/scraper/CATS interrogator

Options:
  -c, --config string       specify config for scraping
  -e, --endpoint string     specify CATS endpoint
  -l, --loglevel string     set log level (default: DEBUG)
  -d, --debug               set debug mode for CATS
  -s, --settings            show default settings
  -h, --help                show help
```

### Using `tunnel_cats.sh`
```shell script

Usage:
  tunnel_cats.sh [OPTIONS]

Setup a SSH channel to CATS service

Options:
  -u, --user string       specify <user>@<host> to log in as on the remote machine
  -s, --service hostname  the hostname of CATS service (default: prod-ds-cats.cubaneddie.k8s.clicktripz.io)
  -p, --port number       the local port for the SSH tunnel (default: 8888)
  -k, --key filename      specify a file from which the identity for public key authentication is read (default: ~/.ssh/id_rsa)
  -h, --help              show help
```