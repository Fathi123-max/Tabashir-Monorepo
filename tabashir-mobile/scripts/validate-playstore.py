import sys
import os
from google.oauth2 import service_account
from googleapiclient.discovery import build

def validate_playstore_access(json_key_path, package_name):
    print(f"Validating Play Store access for {package_name}...")
    
    if not os.path.exists(json_key_path):
        print(f"Error: JSON key file not found at {json_key_path}")
        return False

    try:
        credentials = service_account.Credentials.from_service_account_file(
            json_key_path, 
            scopes=['https://www.googleapis.com/auth/androidpublisher']
        )
        service = build('androidpublisher', 'v3', credentials=credentials)
        
        # Try to get app info to verify access
        app_info = service.edits().insert(packageName=package_name, body={}).execute()
        edit_id = app_info['id']
        print(f"Success! Successfully authenticated and created edit session: {edit_id}")
        
        # Clean up (discard the edit)
        service.edits().delete(packageName=package_name, editId=edit_id).execute()
        return True
        
    except Exception as e:
        print(f"Error: Failed to authenticate or access package. {str(e)}")
        print("\nPossible reasons:")
        print("1. Service account doesn't have permissions in Play Console.")
        print("2. Package name is incorrect.")
        print("3. App hasn't been created in Play Console yet.")
        print("4. Google Play Developer API is not enabled in Google Cloud.")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 validate-playstore.py <path_to_json_key> <package_name>")
        sys.exit(1)
    
    json_key = sys.argv[1]
    package = sys.argv[2]
    
    if validate_playstore_access(json_key, package):
        sys.exit(0)
    else:
        sys.exit(1)
