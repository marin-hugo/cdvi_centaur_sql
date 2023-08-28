# CDVI Centaur - Server query

This script allows to extract data from a Centaur CDVI database which is otherwise long and complicated to obtain.

## Installation
```
git clone https://github.com/marin-hugo/cdvi-centaur-sql.git
```

## How to use
In an administrator powershell session:
```
.\centaur_sql.ps1
```

In case of security execution policy blocking the script, use the following:
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
.\centaur_sql.ps1
```
