# unifi-db-prune.sh-wrapper
A wrapper for [mongo_prune_js.js](https://help.ubnt.com/hc/en-us/articles/204911424-UniFi-Remove-prune-older-data-and-adjust-mongo-database-size#3.%20How to Prune Linux).

Logs to syslog. On error, it also logs to stdout, which is ideal for use in crontab.

## Installation

1. `cd /usr/lib/unifi && sudo git clone https://github.com/bennettp123/unifi-db-prune.sh-wrapper.git prune-script`
2. (optional) create `config.sh`
3. Fetch the latest version of `mongo_prune_js.js` from [here](https://help.ubnt.com/hc/en-us/articles/204911424-UniFi-Remove-prune-older-data-and-adjust-mongo-database-size#3.%20How to Prune Linux), and modify it as desired&mdash;especially `var days=7;` and `var dryrun=false;`.
4. `[sudo -u <unifi_user>] ./unifi-db-prune.sh`
5. (optional) add script to crontab
    
## Configuration

Configuration settings can be modified using in `config.sh`. See `config.sh.example` for details.

