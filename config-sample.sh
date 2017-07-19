#!/usr/bin/env bash

# FTPS credentials
FTPSSERVER=192.0.2.0
FTPSUSER=username
FTPSPASS=PaSsWoRd

# name of this server
SERVER=web1.example.com

# administrative email used for sending messages/alerts
ADMIN=admin@example.com

# location of sites (no trailing slash)
SITESTORE=/path/to/your/vhost/root/dir

# sub-directory under $SITESTORE where XML files are stored
# (no preceeding or trailing slashes)
XMLFILES=htdocs/subfolder/xml_files