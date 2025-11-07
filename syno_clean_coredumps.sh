#!/usr/bin/env bash
#------------------------------------------------------------
# Cleanup memory core dumps from crashed processes
#
# Optionally set the age in days before deleting a core dump
#   -a #, --age #   where # is number of days
#------------------------------------------------------------

scriptver="v1.2.4"
script=Synology_Cleanup_Coredumps
repo="007revad/Synology_Cleanup_Coredumps"
scriptname=syno_cleanup_coredumps

echo -e "Synology_cleanup_coredumps $scriptver by github.com/007revad\n"

ding(){ 
    printf \\a
}

# Check script is running on a Synology NAS
if ! /usr/bin/uname -a | grep -i synology >/dev/null; then
    ding
    echo "This script is NOT running on a Synology NAS!"
    echo "Copy the script to a folder on the Synology"
    echo "and run it from there."
    exit 1
fi

# Check script is running as root
if [[ $( whoami ) != "root" ]]; then
    ding
    echo -e "${Error}ERROR${Off} This script must be run as sudo or root!"
    exit 1
fi

# Check for age option
if [[ $1 ]]; then
    if [[ $1 == "-a" ]] || [[ "$1" == "--age" ]]; then
        if [[ $2 =~ [0-9]+ ]]; then
            age=$2
        else
            echo "age argument is invalid: $2"
            exit 1
        fi
    else
        echo "Invalid option: $1"
        exit 1
    fi
fi

# Check all /volume# volumes for @*.core.gz files
shopt -s nullglob
for volume in /volume*; do
    if [[ $volume =~ /volume[0-9]{1,2}$ ]] && [[ $volume != /volume0 ]]; then
        new=""
        # Check volume is not missing
        if synostgvolume --get-device-path "$volume" >/dev/null 2>&1; then
            if [[ $age =~ [0-9]+ ]]; then
                # Delete core dumps older than $age
                echo -e "Deleting core dumps older than $age days on ${volume}"
            else
                # Delete all core dumps
                echo -e "Deleting all core dumps on ${volume}"
            fi

            # Find and delete old .core files, then report how many and total size deleted
            #find "$volume" -maxdepth 1 -mtime +"$age" \( -name "@*.core" -o -name "@*.core.gz" \) -type f -printf '%s\n' 2>/dev/null \
            find "$volume" -maxdepth 1 -mmin +$((60*24*age)) \( -name "@*.core" -o -name "@*.core.gz" \) -type f -printf '%s\n' 2>/dev/null \
            | awk '{count++; sum+=$1} END {printf "%d %.0f\n", count, sum}' \
            | {
                read -r count sum
                if [[ $count -gt 0 ]]; then
                    # Delete the files
                    if find "$volume" -maxdepth 1 -mmin +$((60*24*age)) \( -name "@*.core" -o -name "@*.core.gz" \) -type f -delete; then

                        # Print summary
                        total_mb=$(echo "$sum" | awk '{ megabytes = $1 / 1024 / 1024; printf "%.2f", megabytes }')
                        #printf "Deleted %d files (total %.2f MB) on %s\n\n" "$count" "$total_mb" "$volume"
                        printf "Deleted %d files (total %.2f MB)\n\n" "$count" "$total_mb"
                    else
                        echo ""
                    fi
                else
                    echo -e "No files to delete.\n"
                fi
            }
        fi
        #echo ""

        # Inform of recent core dumps (those newer than $age)
        for coredumps in "$volume"/@*.core*; do
            # Check volume is not missing
            if synostgvolume --get-device-path "$volume" >/dev/null 2>&1; then
                if [[ $age =~ [0-9]+ ]]; then
                    if [[ -f "$coredumps" ]] && [[ $new != yes ]]; then
                        echo -e "Recent core dumps less than $age days old:" && new=yes
                    fi
                    echo "$coredumps"
                fi
            fi
        done 2>/dev/null
        if [[ $new == yes ]]; then echo ""; fi
    fi
done
shopt -u nullglob

# Email if new core dumps found (if scheduled task set to email on errors)
if [[ $new == yes ]]; then
    exit 1
fi


