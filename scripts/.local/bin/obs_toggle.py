import obsws_python as obs
import sys

def main():
    try:
        # Connect to OBS WebSocket
        # Password matches global.ini
        cl = obs.ReqClient(host='localhost', port=4455, password='w8ydkyGWgISJ9vgr')
        
        # Toggle recording
        resp = cl.toggle_record()
        
        # obsws-python doesn't always return the new state in the response of toggle,
        # but if it didn't raise an exception, it worked.
        print("Toggle Record Request Sent")
        
    except Exception as e:
        print(f"Failed to toggle recording: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
