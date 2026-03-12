#!/bin/bash
# Toggle OBS recording using python script
# Uses uv to manage the dependency on obsws-python
$HOME/.cargo/bin/uv run --quiet --with obsws-python python3 $HOME/.local/bin/obs_toggle.py
