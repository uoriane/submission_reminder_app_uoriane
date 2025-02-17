# Submission Reminder App

This application helps students track and receive alerts about upcoming assignment deadlines.

## Setup Instructions:

1. Clone the repository:
   `git clone <repository_url>`

2. Navigate into the directory:
   `cd submission_reminder_${yourName}`

3. Run the environment creation script:
   `./create_environment.sh`

4. To start the reminder app, execute:
   `./startup.sh`

## Files:
- `config/config.env`: Configuration file containing assignment details.
- `app/reminder.sh`: Script that sends reminders based on submissions.
- `modules/functions.sh`: Helper functions used in the application.
- `assets/submissions.txt`: Student submissions status.
