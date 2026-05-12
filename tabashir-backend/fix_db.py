import re

with open('app/routes/resumes_namespace.py', 'r') as f:
    content = f.read()

# Fix the conn.close() inside finally blocks
# We are looking for:
#        finally:
#            cursor.close()
#            conn.close()

pattern = r"(finally:\s+cursor\.close\(\)\s+)conn\.close\(\)"
replacement = r"\1release_ai_db_connection(conn)"

new_content = re.sub(pattern, replacement, content)

with open('app/routes/resumes_namespace.py', 'w') as f:
    f.write(new_content)
print("Replaced all standard finally blocks.")
