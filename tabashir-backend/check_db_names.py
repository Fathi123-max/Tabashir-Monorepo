from app.config import Config
import os

print(f"Main DB Name: {Config.POSTGRES_DB}")
print(f"AI DB Name: {Config.AI_POSTGRES_DB}")
print(f"Main DB Host: {Config.POSTGRES_HOST}")
print(f"AI DB Host: {Config.AI_POSTGRES_HOST}")
