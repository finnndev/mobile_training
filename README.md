# NinePlus Mobile Development Training Repository

Welcome to the Mobile Development Team Training Repository. This repository is designed to support the learning, practice, and skill improvement activities for all team members.

## Purpose

- Serve as a **training hub** and activity center for team members
- Provide an environment for members to **practice Git** workflows
- Create a space for **sharing source code** to receive feedback and code reviews
- Foster knowledge sharing and exchange between team members

## Branch Naming Conventions

To maintain consistency and ease of management, please follow this branch naming rule:

```
<action>/<your-name>
```

Where:

- **action**: The action being performed or feature being worked on (e.g., login, signup, profile, bugfix-crash, hotfix-performance, refactor-auth)
- **your-name**: Your name or username

Examples:
- `login/john`
- `push-notification/ducnd`
- `state-management/truongdl`
- `authentication/lisa`

## Git Basics Guide

### Initial Setup

```bash
# Set up your personal information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Clone this repository
git clone https://github.com/your-team/mobile-training.git
cd mobile-training
```

### Basic Git Commands

```bash
# Check the status of your files
git status

# Add files to the staging area
git add filename.dart           # Add a specific file
git add .                       # Add all changed files

# Commit your changes with a descriptive message
git commit -m "action(scope): description of the changes"

# Create and switch to a new branch
git checkout -b new-branch-name

# Switch between branches
git checkout main
git checkout your_branch

# Push your code to the remote repository
git push origin your_branch

# Update your code from the remote repository
git pull origin main

# View commit history
git log
git log --oneline --graph       # View history in graph format
```

### Recommended Workflow

1. **Update the main branch**:
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Create a new branch for your task**:
   ```bash
   git checkout -b your_branch
   ```

3. **Write code and commit frequently**:
   ```bash
   git add .
   git commit -m "action(scope): description of the changes"
   ```

4. **Push your code to the repository**:
   ```bash
   git push origin your_branch
   ```

5. **Create a Pull Request** on GitHub/GitLab for review

6. **Revise your code based on feedback** and push to your branch

7. **Merge** after approval

### Rebase code from main branch or other branch

1. Make sure you are on the correct branch
   ```bash
   git checkout your-branch
   
2. Update changes from remote
   ```bash
   git fetch origin
   
3. Rebase from main branch or other branch
   ```bash
   git rebase origin/main

   or

   git rebase origin/feature/other-member

 
### Handling Conflicts

When encountering conflicts during merge or rebase:

1. Git will mark the files with conflicts
2. Open these files and look for sections marked with `<<<<<<<`, `=======`, and `>>>>>>>`
3. Edit the files to keep the appropriate code
4. After resolving conflicts:
   ```bash
   git add .
   git commit -m "Resolve merge conflicts"
   ```

## Code Review Process

1. Create a Pull Request (PR) when you complete a task
2. Name your PR following the structure: `[Action] Brief description of the feature`
3. Tag at least 2 other members to review your code
4. Respond to and address feedback

---

Happy coding! If you have any questions or suggestions, please create an issue in this repository.
