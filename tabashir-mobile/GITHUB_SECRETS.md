# GitHub Secrets for Tabashir Mobile Deployment

To enable automated deployment to the Google Play Store, add the following secrets to your GitHub repository:

| Secret Name | Description |
|-------------|-------------|
| `SIGNING_KEY_STORE_BASE64` | Base64 encoded `production-release.jks` file |
| `SIGNING_KEY_ALIAS` | `upload` |
| `SIGNING_STORE_PASSWORD` | `tabashir123` (or your chosen password) |
| `SIGNING_KEY_PASSWORD` | `tabashir123` (or your chosen password) |
| `SERVICE_ACCOUNT_JSON_PLAINTEXT` | The entire content of your Google Service Account JSON key file |

## How to get the Base64 Keystore
Run this command in your terminal:
```bash
openssl base64 -in tabashir-mobile/android/keystores/production-release.jks -A
```
Copy the output and paste it into the GitHub Secret.

## How to add Secrets
1. Go to your repository on GitHub.
2. Click **Settings** > **Secrets and variables** > **Actions**.
3. Click **New repository secret** for each item above.
