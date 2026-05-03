📌 Overview

This lab demonstrates how to configure Role-Based Authorization in Jenkins by:

Creating users
Defining roles
Assigning permissions
🧑‍💻 Users Created
User	Role	Description
user1	Admin	Full access
user2	Read-only	View access only
🔧 Step 1: Install Role-Based Authorization Plugin

Navigate to:

Manage Jenkins → Plugins → Available Plugins

Search for:

Role-based Authorization Strategy
Install and restart Jenkins

📸 Screenshot:

vscode-remote://ssh-remote%2Bmy-vm/home/messi/Ivolve-intern/lab-21/fierst.PNG

Navigate to:

Manage Jenkins → Manage Users → Create User
Create:
user1
user2


Navigate to:

Manage Jenkins → Configure Global Security

Under Authorization, select:

Role-Based Strategy

📸 Screenshot:

lab-21/second.PNG


Navigate to:

Manage Jenkins → Manage and Assign Roles → Manage Roles
🔹 Create Global Roles:
Admin Role:
Name: admin
Permissions:
Overall → Administer (Full access)
Read-only Role:
Name: readonly
Permissions:
Overall → Read
Job → Read


Navigate to:

Manage Jenkins → Manage and Assign Roles → Assign Roles
Assign:
user1 → admin
user2 → readonly


user1 (Admin):
Full control over Jenkins
Can create, configure, and manage jobs
user2 (Read-only):
Can only view jobs and build history
Cannot modify or trigger builds
📁 Project Structure
jenkins-role-based-auth/
│
├── README.md
└── screenshots/
    ├── install-plugin.png
    ├── create-user1.png
    ├── create-user2.png
    ├── enable-role-strategy.png
    ├── manage-roles.png
    └── assign-roles.png
🚀 Notes
Always ensure at least one user has Admin access
Avoid locking yourself out of Jenkins
Role-based access improves security in CI/CD environments
🎯 Conclusion

This lab provides a foundational understanding of access control in Jenkins, which is essential for managing teams in real-world CI/CD pipelines.