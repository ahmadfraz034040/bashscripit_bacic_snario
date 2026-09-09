# # 🚀 Real-Time Bash Scripting Scenarios

![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)
![AWS](https://img.shields.io/badge/Cloud-AWS%20EC2-FF9900?style=flat&logo=amazonaws&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner--Intermediate-blue)
![Status](https://img.shields.io/badge/Status-Completed-success)

Hands-on shell scripting exercises used by **cloud administrators** to automate routine tasks on real-world environments like **AWS EC2 Linux servers**.

---

## 🎯 Objective

To provide hands-on experience with shell scripting used by cloud administrators to automate routine tasks in real-world environments like AWS EC2 Linux servers.

By completing this project, you will be able to:

- ✅ Automate **user management** and **backup operations**
- ✅ Understand **loops**, **conditional statements**, and **functions**

---

## 🧰 Prerequisites

- An AWS EC2 instance (Amazon Linux / Ubuntu)
- Basic Linux command-line familiarity
- `sudo` / root access for user management tasks

---

## 📂 Project Structure

```
real-time-bash-scenarios/
├── scripts/
│   ├── user_management.sh
│   ├── backup_operations.sh
│   └── server_health_check.sh
└── README.md
```

---

## 🧑‍💻 Scenario 1: Automate User Management

**Use case:** Onboard multiple new employees on an EC2 server in one shot — instead of creating each user manually.

```bash
#!/usr/bin/env bash
# user_management.sh
# Bulk creates users from a list and sets a temporary password

set -euo pipefail

users_file="new_users.txt"   # one username per line

if [ ! -f "$users_file" ]; then
    echo "❌ User list not found: $users_file"
    exit 1
fi

create_user() {
    local username=$1

    if id "$username" &>/dev/null; then
        echo "⚠️  User '$username' already exists — skipping."
    else
        useradd -m "$username"
        echo "${username}:Welcome@123" | chpasswd
        chage -d 0 "$username"   # force password change on first login
        echo "✅ Created user: $username"
    fi
}

while read -r user; do
    create_user "$user"
done < "$users_file"
```

**What it demonstrates:** `while` loop, `if/else` conditional, function, file existence check.

---

## 💾 Scenario 2: Automate Backup Operations

**Use case:** Nightly backup of `/var/www` (or any app directory), rotate old backups, and log the result.

```bash
#!/usr/bin/env bash
# backup_operations.sh
# Backs up a directory, timestamps it, and removes backups older than 7 days

set -euo pipefail

source_dir="/var/www"
backup_dir="/backup"
retention_days=7
timestamp=$(date +%Y-%m-%d_%H-%M-%S)

run_backup() {
    if [ -d "$source_dir" ]; then
        mkdir -p "$backup_dir"
        tar -czf "${backup_dir}/backup_${timestamp}.tar.gz" "$source_dir"
        echo "✅ Backup successful: backup_${timestamp}.tar.gz"
    else
        echo "❌ Source directory not found: $source_dir"
        exit 1
    fi
}

cleanup_old_backups() {
    echo "🧹 Removing backups older than $retention_days days..."
    find "$backup_dir" -name "backup_*.tar.gz" -mtime +$retention_days -exec rm {} \;
}

run_backup
cleanup_old_backups

echo "🎉 Backup process completed at $(date)"
```

**What it demonstrates:** functions, conditional checks, real system automation (`tar`, `find`).

---

## 🩺 Scenario 3: Server Health Check (Loops + Conditionals + Functions Combined)

**Use case:** Continuously monitor disk usage on an EC2 instance and alert when it crosses a threshold.

```bash
#!/usr/bin/env bash
# server_health_check.sh

threshold=80

check_disk_usage() {
    local usage
    usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

    if [ "$usage" -ge "$threshold" ]; then
        echo "🚨 ALERT: Disk usage is at ${usage}% (threshold: ${threshold}%)"
    else
        echo "✅ Disk usage OK: ${usage}%"
    fi
}

# Until loop: keep monitoring until manually stopped
attempts=0
until [ "$attempts" -ge 5 ]; do
    check_disk_usage
    ((attempts++))
    sleep 5
done

echo "Health check completed after $attempts checks."
```

**What it demonstrates:** `until` loop, function with local variable, real-time monitoring pattern.

---

## 🧠 Core Concepts Covered

| Concept | Applied In |
|---|---|
| `for` / `while` loop | Reading user lists, iterating files |
| `until` loop | Server health monitoring |
| Conditional statements (`if / elif / else`) | User existence checks, disk threshold alerts |
| Functions | `create_user()`, `run_backup()`, `check_disk_usage()` |
| Real AWS EC2 use case | User onboarding & backup automation for cloud servers |

---

## ▶️ How to Run

```bash
chmod +x scripts/*.sh
./scripts/user_management.sh
./scripts/backup_operations.sh
./scripts/server_health_check.sh
```

---

## 📌 Key Takeaway

> Shell scripting isn't just syntax — it's the backbone of daily cloud administration. Mastering loops, conditionals, and functions turns repetitive manual work into reliable, one-command automation.

---

⭐ If this helped you, consider starring the repo!

*#Bash #ShellScripting #AWS #DevOps #CloudComputing #100DaysOfCode*
