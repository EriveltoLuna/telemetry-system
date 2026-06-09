from fastapi import FastAPI
from fastapi.responses import FileResponse
import subprocess
import os

app = FastAPI()

BASE = os.path.expanduser("~/telemetry-system/scripts")

def run(script):
    path = os.path.join(BASE, script)
    return subprocess.check_output(path, shell=True).decode().strip()

@app.get("/stats")
def stats():
    return {
        "cpu": run("cpu.sh"),
        "gpu": run("gpu.sh"),
        "ram": run("ram.sh"),
        "disk": run("disk.sh"),
    }

@app.get("/")
def root():
    return FileResponse("../frontend/index.html")
