#!/bin/bash
# Toggle OBS recording using python script
# Uses uv to manage the dependency on obsws-python
/home/crim/.cargo/bin/uv run --quiet --with obsws-python python3 /home/crim/.local/bin/obs_toggle.py
