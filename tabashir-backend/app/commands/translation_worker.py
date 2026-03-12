"""
Management command to run the translation worker
Usage: python -m app.commands.translation_worker
"""

import sys
import os
import signal
import fcntl
import time
from pathlib import Path

project_root = Path(__file__).parent.parent.parent
sys.path.insert(0, str(project_root))

from app.services.job_translation_worker import start_translation_worker, stop_translation_worker, get_translation_stats

def signal_handler(signum, frame):
    """Handle shutdown signals"""
    print("Received shutdown signal, stopping translation worker...")
    stop_translation_worker()
    sys.exit(0)

def main():
    """Main function to run the translation worker with process management"""
    
    # Create lock file to prevent multiple instances
    lock_file = '/tmp/translation_worker.lock'
    
    try:
        # Try to acquire lock
        with open(lock_file, 'w') as f:
            fcntl.flock(f.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
            
        print("Starting Job Translation Worker...")
        print(f"Lock file created: {lock_file}")
        
        # Set up signal handlers
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        
        try:
            start_translation_worker()
            
            stats = get_translation_stats()
            print(f"Translation stats: {stats}")
            
            # Check if there's work to do
            pending_jobs = stats.get('pending', 0) + stats.get('failed', 0)
            if pending_jobs == 0:
                print("No pending translations found. Worker will exit.")
                return
            
            # Run for a limited time (30 minutes max) then exit
            max_runtime = 30 * 60  # 30 minutes in seconds
            start_time = time.time()
            
            while time.time() - start_time < max_runtime:
                time.sleep(60)  # Check every minute
                stats = get_translation_stats()
                print(f"Translation stats: {stats}")
                
                pending_jobs = stats.get('pending', 0) + stats.get('failed', 0)
                if pending_jobs == 0:
                    print("All translations completed. Worker will exit.")
                    break
                    
        except KeyboardInterrupt:
            print("Received keyboard interrupt, shutting down...")
        except Exception as e:
            print(f"Unexpected error: {e}")
        finally:
            stop_translation_worker()
            print("Translation worker stopped")
            
    except IOError:
        print("Translation worker already running, exiting...")
        sys.exit(0)
    finally:
        # Clean up lock file
        if os.path.exists(lock_file):
            try:
                os.remove(lock_file)
                print(f"Lock file removed: {lock_file}")
            except:
                pass

if __name__ == "__main__":
    main()
