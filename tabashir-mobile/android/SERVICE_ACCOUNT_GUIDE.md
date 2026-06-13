# Google Play Service Account Setup Guide

To enable automated deployment via Fastlane and GitHub Actions, you need to create a Google Service Account.

## Step 1: Create a Google Cloud Project
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project (e.g., "Tabashir-Mobile-Deploy").
3. Enable the **Google Play Developer API**.

## Step 2: Create a Service Account
1. Go to **IAM & Admin** > **Service Accounts**.
2. Click **Create Service Account**.
3. Name: `fastlane-deploy`.
4. Grant access: **Service Account User**.
5. Click **Done**.

## Step 3: Create a JSON Key
1. Click on the newly created service account.
2. Go to the **Keys** tab.
3. Click **Add Key** > **Create new key**.
4. Select **JSON** and click **Create**.
5. Save the downloaded file securely. **DO NOT COMMIT THIS FILE.**

## Step 4: Link to Google Play Console
1. Go to the [Google Play Console](https://play.google.com/console/).
2. Go to **Setup** > **API access**.
3. You should see the service account you created under **Service accounts**.
4. Click **Manage Play Console permissions**.
5. Grant the following permissions:
   - View app information and download reports (Read-only)
   - Manage releases, individual tracks, and rollout (Production, Testing)
6. Click **Invite user**.

## Step 5: Add to GitHub Secrets
Copy the content of the JSON key file and add it to GitHub as a secret named:
`SERVICE_ACCOUNT_JSON_PLAINTEXT`
