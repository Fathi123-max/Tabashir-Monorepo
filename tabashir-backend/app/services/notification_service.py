import requests
import json
import uuid
from datetime import datetime
from app.config import Config
from app.database.db import get_db_connection

class NotificationService:
    @staticmethod
    def create_notification(user_id, title, message, notification_type='job_match', data=None):
        """
        Creates an in-app notification and sends a push notification via OneSignal.
        
        Args:
            user_id (str): The ID of the user to notify.
            title (str): Notification title.
            message (str): Notification message.
            notification_type (str): Type of notification (e.g., 'job_match').
            data (dict, optional): Additional metadata for the notification.
        """
        # 1. Create in-app notification in Database
        NotificationService._insert_to_db(user_id, title, message, notification_type, data)
        
        # 2. Send Push Notification via OneSignal
        NotificationService._send_push_notification(user_id, title, message, data)

    @staticmethod
    def _insert_to_db(user_id, title, message, notification_type, data=None):
        conn = None
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            
            # Generate a unique ID (Prisma uses CUID, but for raw SQL we use UUID string)
            notif_id = str(uuid.uuid4())
            
            # Prepare data as JSON string if it exists
            data_json = json.dumps(data) if data else None
            
            # Insert query - matching Prisma's Notification model
            query = """
                INSERT INTO "Notification" (
                    id, "userId", title, message, type, "isRead", "data", "createdAt", "updatedAt"
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            """
            
            cur.execute(query, (
                notif_id,
                user_id,
                title,
                message,
                notification_type,
                False, # isRead
                data_json
            ))
            
            conn.commit()
            print(f"Successfully inserted in-app notification for user {user_id}")
            cur.close()
            
        except Exception as e:
            if conn:
                conn.rollback()
            print(f"Error inserting notification into DB: {e}")
        finally:
            if conn:
                conn.close()

    @staticmethod
    def _send_push_notification(user_id, title, message, data=None):
        """Sends a push notification using OneSignal REST API."""
        if not Config.ONESIGNAL_API_KEY:
            print("OneSignal API Key not found. Skipping push notification.")
            return

        url = "https://onesignal.com/api/v1/notifications"
        
        headers = {
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": f"Basic {Config.ONESIGNAL_API_KEY}"
        }
        
        payload = {
            "app_id": Config.ONESIGNAL_APP_ID,
            "include_external_user_ids": [user_id],
            "headings": {"en": title},
            "contents": {"en": message},
            "data": data or {}
        }
        
        try:
            response = requests.post(url, headers=headers, data=json.dumps(payload))
            if response.status_code == 200:
                print(f"Successfully sent OneSignal push notification to user {user_id}")
            else:
                print(f"Failed to send OneSignal push notification: {response.status_code} - {response.text}")
        except Exception as e:
            print(f"Error calling OneSignal API: {e}")
