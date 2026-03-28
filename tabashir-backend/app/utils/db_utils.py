from app.database.db import get_db_connection

def user_exists(user_id):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT 1 FROM users WHERE id = %s LIMIT 1;', (user_id,))
        exists = cur.fetchone() is not None
        cur.close()
        return exists
    except Exception as e:
        print(f"Error checking user existence: {e}")
        return False
    finally:
        if conn:
            conn.close()

def insert_user_resume_document(user_id, unformatted_file_path=None, raw_cv_text=None, formatted_file_path=None, translated_file_path=None, file_type=None, output_language=None, status=None, error_message=None):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        insert_query = """
            INSERT INTO user_resume_documents (
                user_id,
                unformatted_file_path,
                raw_cv_text,
                formatted_file_path,
                translated_file_path,
                file_type,
                output_language,
                status,
                error_message,
                created_at,
                updated_at
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
            RETURNING id;
        """

        cur.execute(insert_query, (
            user_id,
            unformatted_file_path,
            raw_cv_text,
            formatted_file_path,
            translated_file_path,
            file_type,
            output_language,
            status,
            error_message,
        ))
        print("Inserted user resume document")
        inserted_id = cur.fetchone()['id']
        conn.commit()
        cur.close()
        return inserted_id

    except Exception as e:
        if conn:
            conn.rollback()
        print(f"Error inserting user_resume_document: {e}")
        raise
    finally:
        if conn:
            conn.close()
