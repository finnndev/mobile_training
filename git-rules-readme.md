# Git Rules

## Branch Naming Conventions

### Format
```
<type>/<action>
```

### Types
- `feat`: A new feature or functionality
- `bugfix`: A Bug or error correction
- `hotfix`: Urgent bug fix
- `release`: Release version
- `docs`: Documentation updates
- `refactor`: Code improvements without adding new features
- `test`: Adding or modifying tests
- `chore`: Maintenance tasks
- `perf`: Performance improvements
- `style`: Code formatting, style improvements, or cosmetic changes
- `build`: Changes related to build tools, dependencies, or configurations

### Actions
- Short description of the change content
- Use lowercase and hyphens to separate words

### Examples
```
feature/add-login-page
bugfix/fix-authentication-error
docs/update-api-documentation
refactor/optimize-database-queries
```

## Git Commit Style Guidelines

### Commit Message Structure
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Scope
- (Optional) Describes the scope or component of the project affected by the commit

### Description
- Briefly describes the changes made in the commit

### Optional Body
- Provides detailed information about the changes, rationale, or other relevant context

### Optional Footer
- Can be used for signatures, references to issues, documentation links, build encodings, and more

### Example
```
feat(user): add profile picture upload feature

- Allow users to upload profile pictures.
- Implement image resizing for improved performance.
- Update user settings to include image options.

Closes #123
```

## Workflow

1. Create a new branch from `main`/`master` following the naming convention
2. Make changes and commit according to style guidelines
3. Push branch to remote repository
4. Create Pull Request
5. Code review
6. Merge into main branch after approval
