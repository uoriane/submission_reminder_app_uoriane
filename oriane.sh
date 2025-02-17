#!/bin/bash

# Prompt user for their name to create the directory
read -p "Enter your name: " userName

# Define the main directory name based on the user's name
main_dir="submission_reminder_${uoriane}"

# Create the main directory and subdirectories
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"

# Create the required files inside the directories
touch "$main_dir/config/config.env"
touch "$main_dir/app/reminder.sh"
touch "$main_dir/modules/functions.sh"
touch "$main_dir/assets/submissions.txt"
touch "$main_dir/README.md"

# Populate the README.md file with basic instructions
cat << EOF > "$main_dir/README.md"
# Submission Reminder App

This application helps students track and receive alerts about upcoming assignment deadlines.

## Setup Instructions:

1. Clone the repository:
   \`git clone <repository_url>\`

2. Navigate into the directory:
   \`cd submission_reminder_\${yourName}\`

3. Run the environment creation script:
   \`./create_environment.sh\`

4. To start the reminder app, execute:
   \`./startup.sh\`

## Files:
- \`config/config.env\`: Configuration file containing assignment details.
- \`app/reminder.sh\`: Script that sends reminders based on submissions.
- \`modules/functions.sh\`: Helper functions used in the application.
- \`assets/submissions.txt\`: Student submissions status.
EOF

# Populate config.env with environment variables
cat << EOF > "$main_dir/config/config.env"
# Assignment details
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Populate reminder.sh with its contents
cat << EOF > "$main_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print assignment details
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

# Call the function to check submissions
check_submissions \$submissions_file
EOF

# Populate functions.sh with the required function
cat << EOF > "$main_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOF

# Populate submissions.txt with sample student data (5 records)
cat << EOF > "$main_dir/assets/submissions.txt"
student,assignment,status
Chinemerem,Shell Navigation,not submitted
Chiagoziem,Git,submitted
Divine,Shell Navigation,not submitted
Anissa,Shell Basics,submitted
Alex,Shell Navigation,not submitted
EOF

# Create the startup.sh file that starts the app
cat << EOF > "$main_dir/startup.sh"
#!/bin/bash

# Load environment variables and functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Check if the submissions file exists
if [ ! -f "\$submissions_file" ]; then
    echo "Error: Submissions file not found at \$submissions_file"
    exit 1
fi

# Display assignment details from the environment variables
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "----------------------------------------------"

# Call the function to check submissions
check_submissions "\$submissions_file"

# Final message
echo "Reminder app started successfully!"
EOF

# Make the startup.sh script executable
chmod +x "$main_dir/startup.sh"

# Display success message
echo "Environment setup for 'submission_reminder_${userName}' is complete."

