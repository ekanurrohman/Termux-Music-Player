# TermuxMP 🎶

Automated installer for **MPD**, **Ncmpcpp**, **PulseAudio**, **Tmux**, and **Cava** on Termux.  
This script will also backup and deploy your custom configuration files.

---

## 📂 Project Structure
```
TermuxMP/
├── mpd.conf      # My MPD configuration
├── cava.conf     # My CAVA configuration
├── setup.sh      # Installer script
└── backups/      # Backup folder (auto-created)
```

---

## 🚀 Installation

1. Clone or copy this repo into your Termux storage:
   ```bash
   git clone https://github.com/ekanurrohman/Termux-Music-Player.git
   cd Termux-Music-Player
   ```

2. Make the setup script executable:
   ```bash
   chmod +x setup.sh
   ```

3. Run the installer:
   ```bash
   ./setup.sh
   ```

---

## 🛠️ Options

When you run `setup.sh`, you will get a menu:

```
1) Install MPD + Ncmpcpp + Pulseaudio + Cava
2) Restore MPD config
3) Restore Cava config
```

- **Option 1** → Installs all packages, backs up old configs, and deploys the new ones.  
- **Option 2** → Restores your previous `mpd.conf` from backup.  
- **Option 3** → Restores your previous `cava.conf` from backup.  

⚠️ *Choosing Install will overwrite your configs, but the script automatically creates backups in `backups/`.*

---

## 🎵 Usage

- Start **PulseAudio** and **MPD**:
  ```bash
  pulseaudio --start
  mpd
  ```

- Launch **Ncmpcpp** (MPD client):
  ```bash
  ncmpcpp
  ```

- Launch **Cava** (audio visualizer):
  ```bash
  cava
  ```

---

## ✨ Features
- Fully automated Termux setup.  
- Backup & restore system for configs.  
- Works out of the box with PulseAudio.  

---

Run `ncmpcpp` + `cava` inside `tmux` for a full music + visualizer experience in Termux 🎶  
```
tmux new -s music
ncmpcpp
# (open new pane with CTRL+B % or CTRL+B ")
cava
```

---

