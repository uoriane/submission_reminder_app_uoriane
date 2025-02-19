
# Populate README.md with basic instructions
cat << EOF > "$main_dir/README.md"
# Submission Reminder App

This application helps students track and receive alerts about upcoming assignment deadlines.

## Setup Instructions:
1. Run the setup script:
   \`\`\`
   chmod +x create_environment.sh
   ./create_environment.sh
   \`\`\`
2. Navigate to the created directory and start the app:
   \`\`\`
   cd submission_reminder_${userName}/scripts
   chmod +x startup.sh
   ./startup.sh
   \`\`\`

## Project Structure:
- \`config.env\` → Stores environment variables
- \`submissions.txt\` → Contains student assignment records
- \`reminder.sh\` → Handles reminder notifications
- \`functions.sh\` → Includes helper functions
- \`startup.sh\` → Starts the application

## Author:
Created by **${userName}**
EOF

echo "Project structure for $main_dir has been created successfully!"
