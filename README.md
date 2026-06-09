📊 Telemetry System

A lightweight real-time system telemetry dashboard that exposes CPU, GPU, RAM and disk usage from a Linux machine to any device (tablet, phone or browser) via a FastAPI backend.

The system is designed to be lightweight, network-accessible, mobile/tablet friendly, easy to extend with custom metrics and installable with a single command.

🏗️ Architecture

Scripts → FastAPI Backend → JSON API → Web Frontend → Tablet/Browser

✨ Features
Real-time system metrics
CPU usage and temperature
GPU usage, temperature, power and VRAM (NVIDIA via nvidia-smi)
RAM usage (used/total/percentage)
Disk usage
Web dashboard accessible from any device on the network
Systemd service for auto-start on boot
📁 Project Structure

telemetry-system/
├── backend/
│ └── server.py
├── frontend/
│ ├── index.html
│ ├── app.js
│ └── style.css
├── scripts/
│ ├── cpu.sh
│ ├── gpu.sh
│ ├── ram.sh
│ └── disk.sh
├── telemetry.service
├── install.sh
├── .gitignore
└── README.md

🚀 Quick Install (Recommended)

git clone https://github.com/YOUR_USER/telemetry-system.git
cd telemetry-system
./install.sh

This will automatically create a Python virtual environment, install dependencies, configure systemd service, enable auto-start on boot and launch the API.

🌐 Access Dashboard

Local access:
http://localhost:5050

From another device (tablet/phone):
http://<PC_IP>:5050

To find your IP:
ip a

⚙️ Requirements
Linux (tested on Pop!_OS / Ubuntu)
Python 3.10+
NVIDIA GPU (optional, for GPU metrics)
nvidia-smi available (for GPU stats)
📡 API Endpoint

GET /stats

Returns system telemetry in the format:

{
"cpu": "12|45",
"gpu": "5|42|12|985|12288",
"ram": "11776|32016|37",
"disk": "79|0|33"
}

🎛️ Customization Guide
Modify metrics

Each metric is defined in the scripts folder:

cpu.sh → CPU usage and temperature
gpu.sh → GPU usage, temperature, power, VRAM
ram.sh → RAM usage
disk.sh → Disk usage

Script output format

All scripts MUST output pipe-separated values only:

value1|value2|value3

No extra text is allowed.

Example:
12|45|67

Modify backend logic

File: backend/server.py

You can add or remove metrics by editing:

return {
"cpu": run("cpu.sh"),
"gpu": run("gpu.sh"),
"ram": run("ram.sh"),
"disk": run("disk.sh"),
}

Modify frontend

Located in frontend/:

index.html → layout
app.js → API calls and update logic
style.css → design and appearance
Change refresh rate

Inside frontend/app.js:

setInterval(update, 1000)

1000 = 1 second
5000 = 5 seconds
10000 = 10 seconds

🔧 Systemd Service

The service is installed automatically by install.sh.

Manual control:

sudo systemctl status telemetry
sudo systemctl restart telemetry
sudo systemctl stop telemetry

Logs:
journalctl -u telemetry -f

🧪 Development Mode

To run manually:

cd backend
uvicorn server:app --host 0.0.0.0 --port 5050

📱 Use Cases
Home lab monitoring
Gaming PC dashboard
Remote system monitoring
Lightweight Grafana alternative
Tablet-mounted live dashboard
🧩 Extending the system

To add a new metric:

Create a new script inside scripts/
Ensure output is pipe-separated
Register it in backend/server.py
Display it in frontend
🚀 Roadmap
Graphs and historical data
WebSocket real-time updates
Mobile-first UI redesign
Plugin system for metrics
Docker support
📜 License

MIT License — free to use, modify and distribute.

👨‍💻 Author

Built as a lightweight real-time telemetry system for personal hardware monitoring across multiple devices via network dashboard.
