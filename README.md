# dotfiles

## Install

Install git & curl

```bash
sudo apt install git curl
```

Clone repository to home directory.

```bash
cd
git clone https://github.com/gladevise/dotfiles
```

Run `install.sh`.

```bash
cd dotfiles
./install.sh
```

## Update packages

Update all packages.

```bash
upg
```

Update packages each package manager.

```bash
./scripts/upgrade_<package manager name>.sh
```
