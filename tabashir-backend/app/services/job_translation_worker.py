"""
Background Job Translation Worker
Handles translation of existing jobs and new jobs using DeepSeek API
"""

import time
import threading
from typing import Dict, List
from app.database.db import get_ai_db_connection
from app.services.translation_service import JobTranslationService

class JobTranslationWorker:
    """Background worker for translating jobs"""
    
    def __init__(self, batch_size: int = 20):
        """
        Initialize the translation worker
        
        Args:
            batch_size: Number of jobs to process in each batch
        """
        self.batch_size = batch_size
        self.translation_service = JobTranslationService()
        self.is_running = False
        self.worker_thread = None
        
    def start(self):
        """Start the background translation worker"""
        if self.is_running:
            print("Translation worker is already running")
            return
            
        self.is_running = True
        self.worker_thread = threading.Thread(target=self._run_worker, daemon=True)
        self.worker_thread.start()
        print("Translation worker started")
    
    def stop(self):
        """Stop the background translation worker"""
        self.is_running = False
        if self.worker_thread:
            self.worker_thread.join(timeout=10)
        print("Translation worker stopped")
    
    def _run_worker(self):
        """Main worker loop"""
        while self.is_running:
            try:
                self.translate_pending_jobs()
                time.sleep(10)  # Wait 10 seconds between batches
            except Exception as e:
                print(f"Error in translation worker: {e}")
                time.sleep(300)  # Wait 5 minutes on error
    
    def translate_pending_jobs(self):
        """Translate jobs that need translation"""
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute("""
                SELECT * FROM jobs 
                WHERE translation_status = 'pending' 
                   OR translation_status IS NULL
                   OR translation_status = 'failed'
                ORDER BY job_date DESC
                LIMIT %s
            """, (self.batch_size,))
            
            jobs = cursor.fetchall()
            if not jobs:
                print("No jobs need translation")
                return
            
            print(f"Processing {len(jobs)} jobs for translation")
            
            columns = [desc[0] for desc in cursor.description]
            
            translated_count = 0
            for job_row in jobs:
                try:
                    job_data = dict(zip(columns, job_row))
                    
                    if not self.translation_service.is_translation_needed(job_data):
                        cursor.execute("""
                            UPDATE jobs 
                            SET translation_status = 'completed', translation_updated_at = NOW()
                            WHERE id = %s
                        """, (job_data['id'],))
                        continue
                    
                    self._translate_single_job(job_data, cursor)
                    translated_count += 1
                    
                    time.sleep(1)
                    
                except Exception as e:
                    print(f"Failed to translate job {job_data.get('id', 'unknown')}: {e}")
                    cursor.execute("""
                        UPDATE jobs 
                        SET translation_status = 'failed', translation_updated_at = NOW()
                        WHERE id = %s
                    """, (job_data['id'],))
            
            conn.commit()
            print(f"Successfully translated {translated_count} jobs")
            
        except Exception as e:
            conn.rollback()
            print(f"Error in batch translation: {e}")
        finally:
            cursor.close()
            conn.close()
    
    def _translate_single_job(self, job_data: Dict, cursor) -> bool:
        """
        Translate a single job and update database
        
        Args:
            job_data: Job data dictionary
            cursor: Database cursor
            
        Returns:
            True if successful, False otherwise
        """
        try:
            translated_fields = self.translation_service.translate_job_fields(job_data)
            
            if not translated_fields:
                print(f"No fields translated for job {job_data['id']}")
                return False
            
            update_fields = list(translated_fields.keys()) + ['translation_status', 'translation_updated_at']
            set_clause = ', '.join([f"{field} = %s" for field in update_fields])
            
            values = list(translated_fields.values()) + ['completed', 'NOW()']
            values.append(job_data['id'])
            
            cursor.execute(f"""
                UPDATE jobs 
                SET {set_clause}
                WHERE id = %s
            """, values)
            
            print(f"Translated job {job_data['id']}: {list(translated_fields.keys())}")
            return True
            
        except Exception as e:
            print(f"Failed to translate job {job_data['id']}: {e}")
            return False
    
    def translate_job_immediately(self, job_id: int) -> bool:
        """
        Translate a specific job immediately (for new jobs)
        
        Args:
            job_id: ID of the job to translate
            
        Returns:
            True if successful, False otherwise
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute("SELECT * FROM jobs WHERE id = %s", (job_id,))
            job_row = cursor.fetchone()
            
            if not job_row:
                print(f"Job {job_id} not found")
                return False
            
            columns = [desc[0] for desc in cursor.description]
            job_data = dict(zip(columns, job_row))
            
            if not self.translation_service.is_translation_needed(job_data):
                cursor.execute("""
                    UPDATE jobs 
                    SET translation_status = 'completed', translation_updated_at = NOW()
                    WHERE id = %s
                """, (job_id,))
                conn.commit()
                return True
            
            success = self._translate_single_job(job_data, cursor)
            conn.commit()
            
            return success
            
        except Exception as e:
            conn.rollback()
            print(f"Error translating job {job_id}: {e}")
            return False
        finally:
            cursor.close()
            conn.close()
    
    def get_translation_stats(self) -> Dict:
        """
        Get translation statistics
        
        Returns:
            Dictionary with translation statistics
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute("""
                SELECT 
                    translation_status,
                    COUNT(*) as count
                FROM jobs 
                GROUP BY translation_status
            """)
            
            stats = {}
            for status, count in cursor.fetchall():
                stats[status or 'pending'] = count
            
            return stats
            
        except Exception as e:
            print(f"Error getting translation stats: {e}")
            return {}
        finally:
            cursor.close()
            conn.close()

translation_worker = JobTranslationWorker()

def start_translation_worker():
    """Start the global translation worker"""
    translation_worker.start()

def stop_translation_worker():
    """Stop the global translation worker"""
    translation_worker.stop()

def translate_job_now(job_id: int) -> bool:
    """Translate a specific job immediately"""
    return translation_worker.translate_job_immediately(job_id)

def get_translation_stats() -> Dict:
    """Get translation statistics"""
    return translation_worker.get_translation_stats()
