# Tabashir Backend - Server Integration Guide

This guide will help you and your friend deploy the Tabashir backend to your server.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Server Requirements](#server-requirements)
3. [Step 1: Prepare Your Server](#step-1-prepare-your-server)
4. [Step 2: Set Up Databases](#step-2-set-up-databases)
5. [Step 3: Deploy Backend Application](#step-3-deploy-backend-application)
6. [Step 4: Configure Environment Variables](#step-4-configure-environment-variables)
7. [Step 5: Set Up External Services](#step-5-set-up-external-services)
8. [Step 6: Test Your Deployment](#step-6-test-your-deployment)
9. [Step 7: Set Up Production Server](#step-7-set-up-production-server)
10. [Step 8: Configure HTTPS](#step-8-configure-https)
11. [Step 9: Set Up Monitoring](#step-9-set-up-monitoring)
12. [Step 10: Maintenance & Updates](#step-10-maintenance--updates)
13. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before starting, ensure you have:

- **Server access** (SSH) with root/sudo privileges
- **Domain name** (e.g., `api.tabashir.ae`)
- **Git repository** access (to clone the backend code)
- **External service accounts**:
  - Neon PostgreSQL (or self-hosted PostgreSQL)
  - Stripe account (https://stripe.com)
  - Apple Developer account (for IAP)
  - OneSignal account (for push notifications)
  - LLM API key (InceptionLabs AI, OpenAI, or DeepSeek)

---

## Server Requirements

### Minimum Specifications

- **OS**: Ubuntu 22.04 LTS (recommended) or similar Linux distribution
- **CPU**: 2 cores minimum, 4 cores recommended
- **RAM**: 2GB minimum, 4GB recommended (AI processing is memory-intensive)
- **Storage**: 20GB minimum (for CV storage, logs, and dependencies)
- **Network**: Public IP address, ports 80/443 open

### Software Requirements

- Python 3.11+
- PostgreSQL (for AI database, or use cloud-hosted)
- Nginx (reverse proxy)
- Certbot (for SSL/TLS)
- Git

---

## Step 1: Prepare Your Server

### 1.1 Update System Packages

```bash
sudo apt update && sudo apt upgrade -y
```

### 1.2 Install Required Packages

```bash
sudo apt install -y \
  python3.11 \
  python3.11-venv \
  python3-pip \
  postgresql \
  nginx \
  certbot \
  python3-certbot-nginx \
  git \
  curl \
  build-essential \
  libpq-dev
```

### 1.3 Create Application User

```bash
sudo useradd -m -s /bin/bash tabashir
sudo usermod -aG sudo tabashir
sudo su - tabashir
```

### 1.4 Clone Repository

```bash
cd ~
git clone <your-repo-url> tabashir-monorepo
cd tabashir-monorepo/tabashir-backend
```

---

## Step 2: Set Up Databases

You have **two options** for databases:

### Option A: Cloud-Hosted (Recommended for Production)

#### Main Database (Neon PostgreSQL)

1. **Sign up for Neon**: https://neon.tech
2. **Create a new project**: `tabashir-main`
3. **Get connection string** from dashboard:
   ```
   postgresql://tabashir_user:password@ep-xxx.region.aws.neon.tech/tabashir?sslmode=require
   ```
4. **Note credentials** for `.env` file

#### AI Database (Self-Hosted or Cloud)

If using a separate cloud provider for AI DB:
1. Create PostgreSQL instance
2. Create database: `tabashir_ai`
3. Create user with full access
4. Note connection details

### Option B: Self-Hosted PostgreSQL

#### Install PostgreSQL

```bash
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

#### Create Databases and Users

```bash
# Switch to postgres user
sudo -i -u postgres

# Create main database
createuser tabashir_user
createdb -O tabashir_user tabashir_main

# Create AI database
createuser tabashir_ai_user
createdb -O tabashir_ai_user tabashir_ai

# Set passwords
psql -c "ALTER USER tabashir_user WITH PASSWORD 'your-secure-password';"
psql -c "ALTER USER tabashir_ai_user WITH PASSWORD 'your-secure-password';"

# Exit
exit
```

#### Configure PostgreSQL for Remote Access (if needed)

Edit `/etc/postgresql/14/main/pg_hba.conf`:
```
# Allow connections from your frontend server
host    tabashir_main    tabashir_user    <frontend-ip>/32    md5
host    tabashir_ai      tabashir_ai_user <frontend-ip>/32    md5
```

Edit `/etc/postgresql/14/main/postgresql.conf`:
```
listen_addresses = 'localhost,*'
```

Restart PostgreSQL:
```bash
sudo systemctl restart postgresql
```

#### Initialize AI Database Schema

The AI database schema is managed by the backend. Run the initialization script:

```bash
cd ~/tabashir-monorepo/tabashir-backend
python init_local_db.py
```

---

## Step 3: Deploy Backend Application

### 3.1 Create Virtual Environment

```bash
cd ~/tabashir-monorepo/tabashir-backend

python3.11 -m venv venv
source venv/bin/activate
```

### 3.2 Install Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt

# Download SpaCy model
python -m spacy download en_core_web_sm
```

### 3.3 Verify Installation

```bash
# Test that Flask can start
python run.py
```

You should see:
```
* Running on http://0.0.0.0:5050
```

Press `Ctrl+C` to stop the server.

---

## Step 4: Configure Environment Variables

### 4.1 Create `.env` File

```bash
cd ~/tabashir-monorepo/tabashir-backend
cp .env.example .env
nano .env
```

### 4.2 Fill in Environment Variables

```bash
# Application
SECRET_KEY=generate-a-random-secure-key-here
DEBUG=False
EMAIL_PASSWORD=your-email-password

# File Upload
UPLOAD_FOLDER=uploads
TEMP_FOLDER=uploads/temp
FORMATTED_FOLDER=uploads/processed/formatted
TRANSLATED_FOLDER=uploads/processed/translated
MAX_CONTENT_LENGTH=16777216
ALLOWED_EXTENSIONS=doc,docx,pdf

# Main Database (Neon or self-hosted)
POSTGRES_HOST=ep-xxx.region.aws.neon.tech
POSTGRES_PORT=5432
POSTGRES_DB=tabashir_main
POSTGRES_USER=tabashir_user
POSTGRES_PASSWORD=your-secure-password
POSTGRES_SSLMODE=require

# AI Database
AI_POSTGRES_HOST=localhost
AI_POSTGRES_PORT=5432
AI_POSTGRES_DB=tabashir_ai
AI_POSTGRES_USER=tabashir_ai_user
AI_POSTGRES_PASSWORD=your-secure-password

# LLM Configuration (InceptionLabs AI)
LLM_API_KEY=your-inceptionlabs-api-key
LLM_BASE_URL=https://api.inceptionlabs.ai/v1
LLM_MODEL=mercury-2

# Stripe (get from https://dashboard.stripe.com)
STRIPE_SECRET_KEY=sk_live_xxx
STRIPE_PUBLISHABLE_KEY=pk_live_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

# Apple IAP (get from Apple Developer Portal)
APPLE_KEY_ID=xxx
APPLE_ISSUER_ID=xxx
APPLE_TEAM_ID=xxx
APPLE_BUNDLE_ID=ae.tabashir
APPLE_PRIVATE_KEY_PATH=/home/tabashir/tabashir-monorepo/tabashir-backend/apple_private_key.p8

# OneSignal (get from https://onesignal.com)
ONESIGNAL_APP_ID=bf2fbe39-0ab0-41e1-a9cb-1ecefe72474c
ONESIGNAL_API_KEY=your-onesignal-api-key
```

### 4.3 Generate Secure Keys

**SECRET_KEY**:
```bash
python -c "import secrets; print(secrets.token_hex(32))"
```

**EMAIL_PASSWORD**: 
- This is the password for `application@tabashirai.com`
- Contact your email provider (Hostinger) to get this

### 4.4 Set File Permissions

```bash
# Create necessary directories
mkdir -p uploads uploads/temp uploads/processed/formatted uploads/processed/translated CVs

# Set permissions
chmod -R 755 ~/tabashir-monorepo/tabashir-backend
chmod 600 .env
chmod 600 apple_private_key.p8  # If using Apple IAP
```

---

## Step 5: Set Up External Services

### 5.1 Stripe Setup

#### 1. Create Stripe Account
- Go to https://stripe.com and sign up
- Complete account verification

#### 2. Get API Keys
- Go to https://dashboard.stripe.com/apikeys
- Copy **Secret Key** and **Publishable Key**
- Add to `.env` file

#### 3. Configure Webhook
```bash
# In Stripe Dashboard: Developers → Webhooks → Add endpoint
```

**For Production**:
- Endpoint URL: `https://api.tabashir.ae/api/v1/payments/webhook`
- Events to listen for:
  - `payment_intent.succeeded`
  - `payment_intent.payment_failed`

**For Local Testing** (use ngrok):
```bash
# Install ngrok
sudo snap install ngrok

# Create tunnel
ngrok http 5050

# Use the ngrok URL in Stripe webhook config
# https://xxxx.ngrok.io/api/v1/payments/webhook
```

#### 4. Test Webhook
```bash
# Stripe CLI for local testing
stripe listen --forward-to localhost:5050/api/v1/payments/webhook
```

### 5.2 Apple IAP Setup

#### 1. Create App Store Connect API Key
- Go to https://appstoreconnect.apple.com
- Navigate to **Users and Access → Keys**
- Create new **App Store Connect API Key**
- Download the `.p8` private key file

#### 2. Get Required IDs
- **Key ID**: Displayed after creating the key
- **Issuer ID**: Displayed on the Keys page
- **Team ID**: Found in Apple Developer Portal → Membership

#### 3. Configure Bundle ID
- Ensure your app bundle ID matches: `ae.tabashir`
- Set up StoreKit 2 in your Flutter app

#### 4. Deploy Private Key
```bash
# Copy the .p8 file to your server
scp /path/to/apple_key.p8 tabashir@your-server:/home/tabashir/tabashir-monorepo/tabashir-backend/apple_private_key.p8

# Set permissions
chmod 600 apple_private_key.p8
```

### 5.3 OneSignal Setup

#### 1. Create OneSignal Account
- Go to https://onesignal.com
- Create new app

#### 2. Get App ID and API Key
- **App ID**: Found in app settings
- **API Key**: Found in Settings → Keys & IDs

#### 3. Configure Mobile App
- Add OneSignal SDK to Flutter app
- Configure push notification permissions

### 5.4 LLM API Setup

#### Option A: InceptionLabs AI (Recommended)
1. Sign up at InceptionLabs
2. Get API key
3. Set in `.env`:
   ```bash
   LLM_API_KEY=your-key
   LLM_BASE_URL=https://api.inceptionlabs.ai/v1
   LLM_MODEL=mercury-2
   ```

#### Option B: OpenAI
1. Sign up at https://platform.openai.com
2. Get API key
3. Set in `.env`:
   ```bash
   OPENAI_API_KEY=sk-xxx
   LLM_PROVIDER=openai
   ```

#### Option C: DeepSeek
1. Sign up at DeepSeek
2. Get API key
3. Set in `.env`:
   ```bash
   DEEPSEEK_API_KEY=sk-xxx
   LLM_PROVIDER=deepseek
   ```

---

## Step 6: Test Your Deployment

### 6.1 Run Development Server

```bash
cd ~/tabashir-monorepo/tabashir-backend
source venv/bin/activate
python run.py
```

### 6.2 Test Endpoints

**Health Check**:
```bash
curl http://localhost:5050/docs
```
Should return Swagger UI HTML

**Authentication Test**:
```bash
curl -X POST http://localhost:5050/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "testpassword123",
    "name": "Test User"
  }'
```

Expected response:
```json
{
  "user": {
    "id": "uuid",
    "name": "Test User",
    "email": "test@example.com",
    "userType": "CANDIDATE"
  },
  "accessToken": "eyJ...",
  "refreshToken": "eyJ..."
}
```

**Login Test**:
```bash
curl -X POST http://localhost:5050/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "testpassword123"
  }'
```

### 6.3 Test Database Connections

```bash
python -c "
from app.database.db import get_db_connection, get_ai_db_connection
print('Testing main DB connection...')
conn = get_db_connection()
print('✓ Main DB connected')
conn.close()

print('Testing AI DB connection...')
ai_conn = get_ai_db_connection()
print('✓ AI DB connected')
ai_conn.close()
"
```

### 6.4 Run Tests

```bash
pytest -v
```

All tests should pass.

---

## Step 7: Set Up Production Server

### 7.1 Install Gunicorn

```bash
source venv/bin/activate
pip install gunicorn
```

### 7.2 Create Gunicorn Systemd Service

```bash
sudo nano /etc/systemd/system/tabashir-backend.service
```

Add the following:

```ini
[Unit]
Description=Tabashir Backend API
After=network.target postgresql.service

[Service]
Type=notify
User=tabashir
Group=tabashir
WorkingDirectory=/home/tabashir/tabashir-monorepo/tabashir-backend
Environment="PATH=/home/tabashir/tabashir-monorepo/tabashir-backend/venv/bin"
ExecStart=/home/tabashir/tabashir-monorepo/tabashir-backend/venv/bin/gunicorn \
    --bind 0.0.0.0:5050 \
    --workers 4 \
    --threads 2 \
    --timeout 120 \
    --access-logfile /var/log/tabashir-backend/access.log \
    --error-logfile /var/log/tabashir-backend/error.log \
    --log-level info \
    run:app

Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
```

### 7.3 Create Log Directory

```bash
sudo mkdir -p /var/log/tabashir-backend
sudo chown tabashir:tabashir /var/log/tabashir-backend
```

### 7.4 Enable and Start Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable tabashir-backend
sudo systemctl start tabashir-backend
```

### 7.5 Check Service Status

```bash
sudo systemctl status tabashir-backend
```

You should see:
```
● tabashir-backend.service - Tabashir Backend API
     Loaded: loaded (/etc/systemd/system/tabashir-backend.service; enabled)
     Active: active (running)
```

### 7.6 View Logs

```bash
# View recent logs
sudo journalctl -u tabashir-backend -f

# View access logs
tail -f /var/log/tabashir-backend/access.log

# View error logs
tail -f /var/log/tabashir-backend/error.log
```

---

## Step 8: Configure HTTPS

### 8.1 Point Domain to Server

Add DNS A record:
```
Type: A
Name: api (or @)
Value: <your-server-ip>
TTL: 3600
```

### 8.2 Configure Nginx

```bash
sudo nano /etc/nginx/sites-available/tabashir-backend
```

Add:

```nginx
server {
    listen 80;
    server_name api.tabashir.ae;

    # Increase client max body size for file uploads
    client_max_body_size 16M;

    # Proxy headers
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;

    # Proxy timeouts
    proxy_connect_timeout 120s;
    proxy_send_timeout 120s;
    proxy_read_timeout 120s;

    location / {
        proxy_pass http://127.0.0.1:5050;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
    }

    # Block access to .env file
    location ~ /\.env {
        deny all;
    }
}
```

Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/tabashir-backend /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### 8.3 Obtain SSL Certificate

```bash
sudo certbot --nginx -d api.tabashir.ae
```

Follow the prompts:
1. Enter email for renewal notices
2. Agree to terms of service
3. Choose whether to share email with EFF
4. **Choose "2" to redirect HTTP to HTTPS**

### 8.4 Verify HTTPS

```bash
curl -I https://api.tabashir.ae/api/v1/auth/login
```

Should return `HTTP/2 200`

### 8.5 Auto-Renew SSL Certificate

Certbot sets up auto-renewal automatically. Verify:

```bash
sudo systemctl status certbot.timer
```

Test renewal:
```bash
sudo certbot renew --dry-run
```

---

## Step 9: Set Up Monitoring

### 9.1 Enable Log Rotation

```bash
sudo nano /etc/logrotate.d/tabashir-backend
```

Add:

```
/var/log/tabashir-backend/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 tabashir tabashir
    sharedscripts
    postrotate
        systemctl reload tabashir-backend
    endscript
}
```

### 9.2 Set Up Health Check Endpoint

Create a simple health check:

```bash
nano ~/tabashir-monorepo/tabashir-backend/app/routes/health.py
```

Add:

```python
from flask import Blueprint, jsonify
from app.database.db import get_db_connection

health_bp = Blueprint('health', __name__)

@health_bp.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint for monitoring"""
    try:
        # Test database connection
        conn = get_db_connection()
        conn.close()
        return jsonify({
            "status": "healthy",
            "database": "connected"
        }), 200
    except Exception as e:
        return jsonify({
            "status": "unhealthy",
            "database": "disconnected",
            "error": str(e)
        }), 503
```

Register in `run_root.py`:
```python
from app.routes.health import health_bp
app.register_blueprint(health_bp)
```

### 9.3 Monitor with Uptime Robot (Free)

1. Sign up at https://uptimerobot.com
2. Add monitor: `https://api.tabashir.ae/health`
3. Check every 5 minutes
4. Get email/SMS alerts on downtime

### 9.4 Set Up Application Monitoring

**Using Sentry** (recommended for error tracking):

```bash
pip install sentry-sdk[flask]
```

Add to `app/__init__.py`:
```python
import sentry_sdk
from sentry_sdk.integrations.flask import FlaskIntegration

sentry_sdk.init(
    dsn="your-sentry-dsn",
    integrations=[FlaskIntegration()],
    traces_sample_rate=1.0,
)
```

---

## Step 10: Maintenance & Updates

### 10.1 Deploy Updates

```bash
# SSH into server
ssh tabashir@your-server

# Navigate to backend
cd ~/tabashir-monorepo/tabashir-backend

# Pull latest changes
git pull origin main

# Activate virtual environment
source venv/bin/activate

# Install any new dependencies
pip install -r requirements.txt

# Restart service
sudo systemctl restart tabashir-backend

# Check status
sudo systemctl status tabashir-backend
```

### 10.2 Database Backups

**For self-hosted PostgreSQL**:

Create backup script:
```bash
nano ~/backup_db.sh
```

Add:
```bash
#!/bin/bash
BACKUP_DIR="/home/tabashir/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup main database
pg_dump -U tabashir_user -h localhost tabashir_main > $BACKUP_DIR/main_$DATE.sql

# Backup AI database
pg_dump -U tabashir_ai_user -h localhost tabashir_ai > $BACKUP_DIR/ai_$DATE.sql

# Compress
gzip $BACKUP_DIR/main_$DATE.sql
gzip $BACKUP_DIR/ai_$DATE.sql

# Delete backups older than 7 days
find $BACKUP_DIR -name "*.sql.gz" -mtime +7 -delete

echo "Backup completed: $DATE"
```

Make executable:
```bash
chmod +x ~/backup_db.sh
```

Add to cron (daily at 2 AM):
```bash
crontab -e
```

Add:
```
0 2 * * * /home/tabashir/backup_db.sh >> /var/log/db_backup.log 2>&1
```

### 10.3 Monitor Disk Space

```bash
# Check disk usage
df -h

# Check log sizes
du -sh /var/log/tabashir-backend/*

# Clean old logs
sudo journalctl --vacuum-time=7d
```

### 10.4 Update Dependencies

```bash
source venv/bin/activate

# Check for outdated packages
pip list --outdated

# Update all packages (be careful!)
pip install --upgrade -r requirements.txt

# Or update specific package
pip install --upgrade flask

# Restart service
sudo systemctl restart tabashir-backend
```

### 10.5 Restart on Crashes

The systemd service already has `Restart=on-failure`, but you can add monitoring:

```bash
# Create a simple monitor script
nano ~/monitor_backend.sh
```

Add:
```bash
#!/bin/bash
if ! systemctl is-active --quiet tabashir-backend; then
    echo "Backend is down, restarting..." | mail -s "Tabashir Backend Alert" your@email.com
    sudo systemctl restart tabashir-backend
fi
```

Add to cron (every 5 minutes):
```
*/5 * * * * /home/tabashir/monitor_backend.sh
```

---

## Troubleshooting

### Issue: Service Won't Start

**Check logs**:
```bash
sudo journalctl -u tabashir-backend -n 100 --no-pager
```

**Common causes**:
- Missing environment variables
- Incorrect database credentials
- Port already in use
- Missing Python dependencies

**Solution**:
```bash
# Check if port is in use
sudo lsof -i :5050

# Verify .env file exists
cat .env | grep -v '^#'

# Test database connection
python app/database/db.py
```

### Issue: Database Connection Fails

**Test connection**:
```bash
# Main database
psql -h <host> -U tabashir_user -d tabashir_main

# AI database
psql -h localhost -U tabashir_ai_user -d tabashir_ai
```

**Check PostgreSQL is running**:
```bash
sudo systemctl status postgresql
```

**Check firewall**:
```bash
sudo ufw status
sudo ufw allow 5432/tcp  # If remote DB
```

### Issue: 502 Bad Gateway

**Check Nginx error log**:
```bash
sudo tail -f /var/log/nginx/error.log
```

**Common causes**:
- Gunicorn not running
- Wrong port in Nginx config
- Permissions issue

**Solution**:
```bash
# Check Gunicorn is running
sudo systemctl status tabashir-backend

# Check Nginx config
sudo nginx -t

# Restart both services
sudo systemctl restart tabashir-backend
sudo systemctl restart nginx
```

### Issue: Stripe Webhook Not Working

**Test webhook locally**:
```bash
# Use Stripe CLI
stripe listen --forward-to localhost:5050/api/v1/payments/webhook

# Trigger test event
stripe trigger payment_intent.succeeded
```

**Check webhook signature**:
- Ensure `STRIPE_WEBHOOK_SECRET` matches Stripe dashboard
- Check webhook endpoint is receiving requests (view logs)

**For production**:
- Ensure HTTPS is configured
- Verify webhook URL is correct in Stripe dashboard
- Check Nginx is proxying correctly

### Issue: Apple IAP Verification Fails

**Check private key**:
```bash
# Verify key file exists and is readable
ls -la apple_private_key.p8
cat apple_private_key.p8 | head -n 1
# Should start with: -----BEGIN PRIVATE KEY-----
```

**Check configuration**:
```bash
# Verify all Apple env vars are set
cat .env | grep APPLE
```

**Test in Sandbox**:
- Ensure `environment='Sandbox'` in verification call
- Use Sandbox Apple ID for testing

### Issue: High Memory Usage

**Monitor memory**:
```bash
free -h
top -p $(pgrep -f gunicorn)
```

**Reduce Gunicorn workers** (if memory is tight):
```bash
sudo nano /etc/systemd/system/tabashir-backend.service
# Change: --workers 4 → --workers 2
sudo systemctl daemon-reload
sudo systemctl restart tabashir-backend
```

### Issue: File Upload Fails

**Check permissions**:
```bash
ls -la uploads/
sudo chown -R tabashir:tabashir uploads/
chmod -R 755 uploads/
```

**Check Nginx client_max_body_size**:
```bash
cat /etc/nginx/sites-available/tabashir-backend | grep client_max_body_size
# Should be: client_max_body_size 16M;
```

**Check Flask MAX_CONTENT_LENGTH**:
```bash
cat .env | grep MAX_CONTENT_LENGTH
# Should be: 16777216 (16MB)
```

---

## Quick Reference Commands

### Service Management

```bash
# Start/stop/restart
sudo systemctl start tabashir-backend
sudo systemctl stop tabashir-backend
sudo systemctl restart tabashir-backend

# Check status
sudo systemctl status tabashir-backend

# View logs
sudo journalctl -u tabashir-backend -f
```

### Database Management

```bash
# Backup
pg_dump -U tabashir_user -h localhost tabashir_main > backup.sql

# Restore
psql -U tabashir_user -h localhost tabashir_main < backup.sql

# Connect to database
psql -U tabashir_user -h localhost tabashir_main
```

### Deployment

```bash
# Pull and deploy
cd ~/tabashir-monorepo/tabashir-backend
git pull
source venv/bin/activate
pip install -r requirements.txt
sudo systemctl restart tabashir-backend
```

### Monitoring

```bash
# Check service
sudo systemctl status tabashir-backend

# Check logs
tail -f /var/log/tabashir-backend/error.log

# Check disk space
df -h

# Check memory
free -h

# Check processes
ps aux | grep gunicorn
```

---

## Security Checklist

- [ ] `.env` file permissions set to `600`
- [ ] Apple private key permissions set to `600`
- [ ] SSL certificate installed and auto-renewing
- [ ] Database passwords are strong (16+ characters)
- [ ] `DEBUG=False` in production
- [ ] Firewall configured (only ports 80, 443, 22 open)
- [ ] Regular backups configured
- [ ] Log rotation enabled
- [ ] Dependencies updated regularly
- [ ] No hardcoded secrets in code

---

## Next Steps

After successful deployment:

1. **Update mobile app** to point to new backend URL
2. **Configure CI/CD** for automated deployments (GitHub Actions, GitLab CI)
3. **Set up staging environment** for testing before production
4. **Add application monitoring** (Sentry, New Relic, etc.)
5. **Configure CDN** if needed for CV file delivery
6. **Set up email delivery** monitoring
7. **Test payment flows** end-to-end in production

---

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review backend logs: `sudo journalctl -u tabashir-backend -f`
3. Test endpoints manually with curl or Postman
4. Check external service dashboards (Stripe, OneSignal, etc.)
5. Review recent git commits for breaking changes

---

**Good luck with your deployment! 🚀**
