# Synology Cleanup Coredumps
Cleanup memory core dumps from crashed processes

Whenever process crashes or restarts unexpectedly DSM creates a memory dump of the memory the process was using for debugging. Unless you intend debugging why the process crashed you don't need to keep them. 

<p align="left">I found 92 coredump files (300MB), dating back to 2021 and DSM 6, on volume 1 of my Synology</p>
<p align="left"><img src="/images/syno_cleanup_coredumps.png"></p>

<p align="left">Output of the script</p>
<p align="left"><img src="/images/Image-1.png"></p>

### Download the script

See <a href=images/how_to_download_generic.png/>How to download the script</a> for the easiest way to download the script.

### Scheduling the script in Synology's Task Scheduler

See <a href=how_to_schedule.md/>How to schedule a script in Synology Task Scheduler</a>

### Running the script via SSH

You run the script in a shell with sudo -i or as root.

```YAML
sudo -i /volume1/scripts/syno_clean_coredump.sh
```

**Note:** Replace /volume1/scripts/ with the path to where the script is located.

### Options:

The script has an to set the age in days so that only coredumps older than that age are deleted. 

You can use -a or --age followed by a space then the number of days.
```YAML
sudo -i /volume1/scripts/syno_clean_coredump.sh -a 7
```

```YAML
sudo -i /volume1/scripts/syno_clean_coredump.sh --age 7
```

**Note:** Replace /volume1/scripts/ with the path to where the script is located.
