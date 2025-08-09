# AutoCommit

**AutoCommit** is a Swift-based command line tool that automatically generates Git commit messages using the **Gemini API**.  
Perfect for developers who want faster, cleaner, and more consistent commit workflows without typing messages manually.

---

## 🚀 Features
- Reads changes from Git (`git diff --cached`)
- Sends the diff to the Gemini API
- Generates concise and descriptive commit messages following best practices
- Automatically commits without manual message input

---

## 📦 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/username/AutoCommit.git
cd AutoCommit
```

### 2. Set Your Gemini API Key
Make sure you have a **Gemini API key**. Store it in an environment variable:
```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```
To make it permanent, add it to `~/.zshrc` or `~/.bashrc`:
```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```
Then reload your shell:
```bash
source ~/.zshrc
```

### 3. Build the Project
```bash
swift build -c release
```

### 4. Install the Command Line Tool
```bash
cp .build/release/AutoCommit /usr/local/bin/auto-commit
```

---

## ⚡ Usage

1. Make sure you are in a Git-initialized project
2. Stage the files you want to commit:
   ```bash
   git add .
   ```
3. Run:
   ```bash
   auto-commit
   ```
4. The tool will:
   - Read changes (`git diff --cached`)
   - Send them to the Gemini API
   - Receive a commit message
   - Automatically run `git commit` with the generated message

---

## 📝 Example Output
```bash
$ git add .
$ auto-commit
✅ Commit successful: feat: add input validation to login form
```

---

## 🔧 Additional Configuration
- **Commit format**: Modify the prompt in `main.swift` to follow formats like [Conventional Commits](https://www.conventionalcommits.org/).
- **Git Hook integration**: Add it to `.git/hooks/commit-msg` to generate commit messages automatically without running `auto-commit` manually.

---

## 📄 License
This project is licensed under the MIT License. Feel free to use and modify it as needed.
