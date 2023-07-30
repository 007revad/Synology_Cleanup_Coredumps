#!/usr/bin/env bash
#------------------------------------------------------------
# Cleanup memory core dumps from crashed processes
#
# Optionally set the age in days before deleting a core dump
#   -a #, --age #   where # is number of days
#------------------------------------------------------------

echo -e "Synology_cleanup_coredumps by github.com/007revad\n"

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
for volume in /volume*; do
    if [[ $volume =~ /volume[0-9]{1,2}$ ]] && [[ $volume != /volume0 ]]; then
        if [[ $age =~ [0-9]+ ]]; then
            # Delete core dumps older than $age
            echo "Deleting core dumps older than $age days on ${volume}"
            find "$volume"/@*.core* -mtime +"$age" -delete
        else
            # Delete all core dumps
            echo "Deleting all core dumps on ${volume}"
            find "$volume"/@*.core* -delete
        fi

        # Inform of recent core dumps (those newer than $age)
        #for coredumps in "$volume"/@*.core.gz; do
        for coredumps in "$volume"/@*.core*; do
            if [[ $new != yes ]]; then
                echo -e "\nRecent core dumps less than $age days old:" && new=yes
            fi
            echo "$coredumps"
        done
    fi
done

# Email if new core dumps found (if scheduled task set to email on errors)
if [[ $new == yes ]]; then
    exit 1
fi


