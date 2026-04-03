from flask_restx import Namespace, Resource, fields
from flask import request
from http import HTTPStatus
import json
from app.database.db import execute_query
from app.routes.middleware import jwt_required

notifications_ns = Namespace('notifications', description='Mobile Notification Endpoints')

# Response models
notification_model = notifications_ns.model('Notification', {
    'id': fields.String(required=True, description='Notification ID'),
    'title': fields.String(required=True, description='Notification title'),
    'message': fields.String(required=True, description='Notification message'),
    'type': fields.String(required=True, description='Notification type (e.g., job_match, application_update)'),
    'createdAt': fields.String(required=True, description='Creation timestamp'),
    'isRead': fields.Boolean(required=True, description='Whether the notification has been read'),
    'senderId': fields.String(description='ID of the sender'),
    'senderName': fields.String(description='Name of the sender'),
    'data': fields.Raw(description='Additional metadata payload')
})

notifications_list_model = notifications_ns.model('NotificationsList', {
    'notifications': fields.List(fields.Nested(notification_model), required=True)
})

notification_count_model = notifications_ns.model('NotificationCount', {
    'unreadCount': fields.Integer(required=True, description='Number of unread notifications'),
    'hasUnread': fields.Boolean(required=True, description='Whether there are any unread notifications')
})


@notifications_ns.route('/')
class NotificationsList(Resource):
    @notifications_ns.doc(security='Bearer')
    @notifications_ns.response(200, 'Success', notifications_list_model)
    @notifications_ns.response(401, 'Unauthorized')
    @jwt_required
    def get(self):
        """Fetch notifications for the authenticated user"""
        user_id = request.user_id

        try:
            # Get pagination params
            limit = int(request.args.get('limit', 50))
            offset = int(request.args.get('offset', 0))

            # Fetch notifications
            query = '''
                SELECT id, title, message, type, "isRead", "senderId", "senderName", 
                       data, "createdAt"
                FROM "Notification"
                WHERE "userId" = %s
                ORDER BY "createdAt" DESC
                LIMIT %s OFFSET %s
            '''
            
            notifications = execute_query(query, (user_id, limit, offset), fetch_all=True)

            # Format timestamps and parse data JSON
            formatted_notifications = []
            for notif in notifications:
                # Parse data field if it's a JSON string
                data = notif.get('data')
                if isinstance(data, str):
                    try:
                        data = json.loads(data)
                    except (json.JSONDecodeError, TypeError):
                        data = None

                formatted_notifications.append({
                    'id': notif['id'],
                    'title': notif['title'],
                    'message': notif['message'],
                    'type': notif['type'],
                    'createdAt': notif['createdAt'].isoformat() if hasattr(notif['createdAt'], 'isoformat') else str(notif['createdAt']),
                    'isRead': notif['isRead'],
                    'senderId': notif.get('senderId'),
                    'senderName': notif.get('senderName'),
                    'data': data
                })

            return {'notifications': formatted_notifications}, HTTPStatus.OK

        except Exception as e:
            print(f"[NOTIFICATIONS] GET error: {e}")
            return {'error': 'Internal Server Error'}, HTTPStatus.INTERNAL_SERVER_ERROR

    @notifications_ns.doc(security='Bearer')
    @notifications_ns.response(200, 'Success')
    @notifications_ns.response(401, 'Unauthorized')
    @jwt_required
    def patch(self):
        """Mark a specific notification or all notifications as read"""
        user_id = request.user_id

        try:
            body = request.get_json(silent=True) or {}
            notification_id = body.get('notificationId')

            if notification_id:
                # Mark specific notification as read
                execute_query(
                    '''
                    UPDATE "Notification"
                    SET "isRead" = true
                    WHERE id = %s AND "userId" = %s
                    ''',
                    (notification_id, user_id)
                )
                return {'success': True, 'message': 'Notification marked as read'}, HTTPStatus.OK
            else:
                # Mark all notifications as read
                execute_query(
                    '''
                    UPDATE "Notification"
                    SET "isRead" = true
                    WHERE "userId" = %s AND "isRead" = false
                    ''',
                    (user_id,)
                )
                return {'success': True, 'message': 'All notifications marked as read'}, HTTPStatus.OK

        except Exception as e:
            print(f"[NOTIFICATIONS] PATCH error: {e}")
            return {'error': 'Internal Server Error'}, HTTPStatus.INTERNAL_SERVER_ERROR


@notifications_ns.route('/count')
class NotificationCount(Resource):
    @notifications_ns.doc(security='Bearer')
    @notifications_ns.response(200, 'Success', notification_count_model)
    @notifications_ns.response(401, 'Unauthorized')
    @jwt_required
    def get(self):
        """Get unread notification count"""
        user_id = request.user_id

        try:
            result = execute_query(
                'SELECT COUNT(*) as count FROM "Notification" WHERE "userId" = %s AND "isRead" = false',
                (user_id,), fetch_one=True
            )
            
            unread_count = int(result.get('count', 0)) if result else 0
            
            return {
                'unreadCount': unread_count,
                'hasUnread': unread_count > 0
            }, HTTPStatus.OK

        except Exception as e:
            print(f"[NOTIFICATIONS] Count error: {e}")
            return {'unreadCount': 0, 'hasUnread': False}, HTTPStatus.OK
