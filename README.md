# docker-dns-o-matic
Docker Image for running [dns-o-matic](http://dnsomatic.com/)

## Example

```bash
docker run --name dns-o-matic -e USERNAME=foo -e PASSWORD=bar ammmze/dns-o-matic
```

## Volumes

| Path | Description |
| ---- | ----------- |
| `/config` | The directory where we keep configuration files...really just the file the tracks the last known ip address |

## Environment variables

| Name | Default Value | Description |
| ---- | ------------- | ----------- |
| `USERNAME` | *(no value)* | The username used to authenticate with the [dns-o-matic api](http://dnsomatic.com/wiki/api) |
| `PASSWORD` | *(no value)* | The password used to authenticate with the [dns-o-matic api](http://dnsomatic.com/wiki/api) |
| `CONFIG_DIR` | `/config` | The directory where we keep configuration files...really just the file the tracks the last known ip address |
| `DELAY` | `1h` | How long to wait between update checks |
| `HOST` | `all.dnsomatic.com` | The `hostname` parameter passed to the [dns-o-matic api](http://dnsomatic.com/wiki/api). The hostname that should be updated. Or all.dnsomatic.com to update all hosts |
| `WILDCARD` | `NOCNG` | The `wildcard` parameter passed to the [dns-o-matic api](http://dnsomatic.com/wiki/api) |
| `MX` | `NOCNG` | The `mx` parameter passed to the [dns-o-matic api](http://dnsomatic.com/wiki/api) |
| `BACKMX` | `NOCNG` | The `backmx` parameter passed to the [dns-o-matic api](http://dnsomatic.com/wiki/api) |
| `IP_ADDR_PROVIDER` | http://myip.dnsomatic.com/ | Web API that provides the current public IP address to the client. Manually modify if default provider does not respond with 200 OK. Example alternative values: https://api.ipify.org and https://bot.whatismyipaddress.com |
