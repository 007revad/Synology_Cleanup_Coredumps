# How to schedule a script in Synology Task Manager

You can schedule this script in Task Scheduler to run on a schedule or at boot-up.

You can also setup a scheduled task and leave it disabled, so it only runs when you select the task in the Task Scheduler and click on the Run button.

### To schedule this script to run on your Synology at boot-up follow these steps:

1. Go to **Control Panel** > **Task Scheduler** > click **Create** > and select **Triggered Task**.
2. Select **User-defined script**.
3. Enter a task name.
4. Select **root** as the user (The script needs to run as root).
5. Select **Boot-up** as the event that triggers the task.
6. Leave **Enable** ticked.
7. Click **Task Settings**.
8. Optionally you can tick **Send run details by email** and **Send run details only when the script terminates abnormally** then enter your email address.
   - If **Send run details only when the script terminates abnormally** is ticked DSM will only send you an email when this script deletes coredump files.
10. In the box under **User-defined script** type the path to the script. 
    - e.g. If you saved the script to a shared folder on volume1 called "scripts" you'd type: **/volume1/scripts/syno_clean_coredump.sh**
11. Click **OK** to save the settings.


### To schedule this script to run on a schedule on your Synology follow these steps:

1. Go to **Control Panel** > **Task Scheduler** > click **Create** > and select **Scheduled Task**.
2. Select **User-defined script**.
3. Enter a task name.
4. Select **root** as the user (The script needs to run as root).
5. Leave **Enable** ticked.
6. Click **Schedule** and set your schedule.
7. Click **Task Settings**.
8. Optionally you can tick **Send run details by email** and **Send run details only when the script terminates abnormally** then enter your email address.
   - If **Send run details only when the script terminates abnormally** is ticked DSM will only send you an email when this script deletes coredump files.
10. In the box under **User-defined script** type the path to the script. 
    - e.g. If you saved the script to a shared folder on volume1 called "scripts" you'd type: **/volume1/scripts/syno_clean_coredump.sh**
11. Click **OK** to save the settings.


