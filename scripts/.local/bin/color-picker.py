#!/usr/bin/env python3

import subprocess
import tkinter as tk
import os
import glob
import sys
import shutil
import time

def notify(title, message):
    if shutil.which("notify-send"):
        subprocess.run(["notify-send", title, message])

def copy_to_clipboard(text):
    if shutil.which("wl-copy"):
        subprocess.run(["wl-copy"], input=text.encode('utf-8'))

def get_latest_screenshot():
    # Find the most recent Screenshot png in /tmp
    # We look for files matching the COSMIC pattern: /tmp/Screenshot_YYYY-MM-DD_HH-MM-SS.png
    # But just in case, we look for any recent png created by us.
    
    # Run screenshot command
    # We sleep briefly to ensure we don't pick up an old file if the command is instant?
    # Actually, we can check the file list before and after.
    
    before_files = set(glob.glob('/tmp/Screenshot_*.png'))
    
    subprocess.run(["cosmic-screenshot", "--interactive=false", "--save-dir", "/tmp"], check=True)
    
    # Give fs a moment?
    time.sleep(0.5)
    
    after_files = set(glob.glob('/tmp/Screenshot_*.png'))
    new_files = after_files - before_files
    
    if not new_files:
        # Fallback: just take the newest one
        list_of_files = glob.glob('/tmp/Screenshot_*.png')
        if not list_of_files:
            return None
        return max(list_of_files, key=os.path.getctime)
    
    return list(new_files)[0]

class ColorPicker(tk.Tk):
    def __init__(self, image_path):
        super().__init__()
        
        # Basic setup
        self.title("Color Picker")
        
        # Fullscreen to cover everything
        self.attributes('-fullscreen', True)
        self.config(cursor="crosshair")
        
        # Bind escape to exit
        self.bind("<Escape>", lambda e: self.quit_app())
        
        try:
            self.img = tk.PhotoImage(file=image_path)
        except Exception as e:
            notify("Error", f"Failed to load screenshot: {e}")
            self.destroy()
            return

        # Create canvas
        self.canvas = tk.Canvas(self, width=self.winfo_screenwidth(), height=self.winfo_screenheight(), highlightthickness=0)
        self.canvas.pack(fill="both", expand=True)
        
        # Display image
        self.canvas.create_image(0, 0, image=self.img, anchor="nw")
        
        # Click handler
        self.canvas.bind("<Button-1>", self.on_click)
        
        # Force focus so Escape works
        self.focus_force()

    def on_click(self, event):
        # Coordinates relative to canvas (which matches image if anchored nw)
        x, y = self.canvas.canvasx(event.x), self.canvas.canvasy(event.y)
        x, y = int(x), int(y)
        
        try:
            # PhotoImage.get(x, y) returns a tuple of integers (r, g, b) or string "r g b" depending on version
            # In Python 3 it returns a tuple usually? Let's handle both.
            color_data = self.img.get(x, y)
            
            if isinstance(color_data, str):
                r, g, b = map(int, color_data.split())
            else:
                r, g, b = color_data
                
            hex_color = f"#{r:02x}{g:02x}{b:02x}"
            
            print(hex_color)
            copy_to_clipboard(hex_color)
            notify("Color Picked", hex_color)
        except Exception as e:
            # If we click outside image bounds or something
            print(f"Error picking color: {e}", file=sys.stderr)
            # notify("Error", "Clicked outside image bounds?")
            
        self.quit_app()

    def quit_app(self):
        self.destroy()

def main():
    try:
        shot_path = get_latest_screenshot()
        if not shot_path:
            notify("Error", "Could not take screenshot.")
            sys.exit(1)
            
        app = ColorPicker(shot_path)
        app.mainloop()
        
        # Cleanup
        if os.path.exists(shot_path):
            os.remove(shot_path)
            
    except Exception as e:
        notify("Error", str(e))
        sys.exit(1)

if __name__ == "__main__":
    main()