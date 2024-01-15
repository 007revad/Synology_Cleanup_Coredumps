# Synology Cleanup Coredumps

<a href="https://github.com/007revad/Synology_Cleanup_Coredumps/releases"><img src="https://img.shields.io/github/release/007revad/Synology_Cleanup_Coredumps.svg"></a>
<a href="https://hits.seeyoufarm.com"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2F007revad%2FSynology_Cleanup_Coredumps&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=views&edge_flat=false"/></a>
[![](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/007revad)
[![committers.top badge](https://user-badge.committers.top/australia/007revad.svg)](https://user-badge.committers.top/australia/007revad)

### Description

Cleanup memory core dumps from crashed processes

Whenever a process crashes or restarts unexpectedly DSM creates a memory dump of the memory the process was using for debugging. Unless you intend debugging why the process crashed you don't need to keep them. 

If you schedule the script to run in Task Scheduler with **Send run details by email** and **Send run details only when the script terminates abnormally** task scheduler will send you an email whenever the script deletes core dump files.

<p align="left">I found 92 coredump files (300MB), dating back to 2021 and DSM 6, on volume 1 of my Synology</p>
<p align="left"><img src="/images/syno_cleanup_coredumps.png"></p>

<p align="left">Output of the script</p>
<p align="left"><img src="/images/Image-1.png"></p>

### Download the script

1. Download the latest version _Source code (zip)_ from https://github.com/007revad/Synology_Cleanup_Coredumps/releases
2. Save the download zip file to a folder on the Synology.
3. Unzip the zip file.

### Scheduling the script in Synology's Task Scheduler

See <a href=how_to_schedule.md/>How to schedule a script in Synology Task Scheduler</a>

### Running the script via SSH

[How to enable SSH and login to DSM via SSH](https://kb.synology.com/en-global/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)

You run the script in a shell with sudo -i or as root.

```YAML
sudo -i /volume1/scripts/syno_clean_coredumps.sh
```

**Note:** Replace /volume1/scripts/ with the path to where the script is located.

### Options:

The script has an to set the age in days so that only coredumps older than that age are deleted. 

You can use -a or --age followed by a space then the number of days.
```YAML
sudo -i /volume1/scripts/syno_clean_coredumps.sh -a 7
```

```YAML
sudo -i /volume1/scripts/syno_clean_coredumps.sh --age 7
```

**Note:** Replace /volume1/scripts/ with the path to where the script is located.
