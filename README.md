# AutoCommit

**AutoCommit** is a Swift-based command-line tool that automatically generates Git commit messages using the **Gemini API**.  
Perfect for developers who want faster, cleaner, and more consistent commit workflows without typing messages manually.

---

## 🚀 Features
- Reads staged changes from Git (`git diff --cached`)
- Sends the diff to the Gemini API
- Generates concise and descriptive commit messages following best practices
- Automatically commits without manual message input

---

## 📦 Installation

### 1. Create the Command-Line Tool Project
```bash
# Go to your desired directory
mkdir AutoCommit
cd AutoCommit
swift package init --type executable
```

### 2. Replace main.swift
	1.	Open the Sources/AutoCommit/main.swift file in Xcode or your editor.
	2.	Replace its contents with the updated AutoCommit code.

### 3. Set Your Gemini API Key
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

### 4. Build the Project
```bash
swift build -c release
```

### 5. Install the Command Line Tool
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
   or
   
   ```bash
   ./AutoCommit/.build/release/AutoCommit
   ```
5. The tool will:
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
