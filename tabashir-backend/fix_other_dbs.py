import re
import os

# fix job_translation_worker.py
f1 = 'app/services/job_translation_worker.py'
if os.path.exists(f1):
    with open(f1, 'r') as f:
        content = f.read()
    content = content.replace("from app.database.db import get_ai_db_connection", "from app.database.db import get_ai_db_connection, release_ai_db_connection")
    content = content.replace("conn.close()", "release_ai_db_connection(conn)")
    with open(f1, 'w') as f:
        f.write(content)

# fix payment_fulfillment_service.py
f2 = 'app/services/payment_fulfillment_service.py'
if os.path.exists(f2):
    with open(f2, 'r') as f:
        content = f.read()
    content = content.replace("from app.database.db import get_ai_db_connection", "from app.database.db import get_ai_db_connection, release_ai_db_connection")
    content = content.replace("ai_conn.close()", "release_ai_db_connection(ai_conn)")
    with open(f2, 'w') as f:
        f.write(content)

# fix notification_service.py
f3 = 'app/services/notification_service.py'
if os.path.exists(f3):
    with open(f3, 'r') as f:
        content = f.read()
    content = content.replace("from app.database.db import get_db_connection", "from app.database.db import get_db_connection, release_db_connection")
    content = content.replace("conn.close()", "release_db_connection(conn)")
    with open(f3, 'w') as f:
        f.write(content)

# fix db_utils.py
f4 = 'app/utils/db_utils.py'
if os.path.exists(f4):
    with open(f4, 'r') as f:
        content = f.read()
    content = content.replace("from app.database.db import get_db_connection", "from app.database.db import get_db_connection, release_db_connection")
    content = content.replace("conn.close()", "release_db_connection(conn)")
    with open(f4, 'w') as f:
        f.write(content)

print("Fixed other services")
