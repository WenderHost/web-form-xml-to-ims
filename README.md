# Web Form XML to IMS Script

This is a [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) script which moves web form XML files to another server via `lftp`.

## Installation

1. Download the [latest release](https://github.com/WenderHost/web-form-xml-to-ims/releases/latest) to a sub-folder on your server.
2. Copy `config-sample.sh` to `config.sh`, and set your environment variables.
3. Add a cron to run `./web-form-to-ims/web-form-to-ims.sh` at a regular interval. Example:

`*/10 * * * * bash /path/to/script/web-form-to-ims/web-form-to-ims.sh -d >/dev/null/ 2>&1`

*Note: The `-d` option deletes the XML files after FTPing them to the other server.*

## Options

- `-d` delete XML files after FTP

## Changelog

### 1.0.0

- Initial release