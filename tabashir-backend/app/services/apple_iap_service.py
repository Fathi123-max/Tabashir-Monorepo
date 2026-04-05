import jwt
import time
import requests
import logging
from app.config import Config

logger = logging.getLogger(__name__)


class AppleIAPService:
    """
    Handles Apple App Store Server API authentication
    and receipt verification for StoreKit 2 purchases.
    """

    def __init__(self):
        if not all([
            Config.APPLE_KEY_ID,
            Config.APPLE_ISSUER_ID,
            Config.APPLE_TEAM_ID,
            Config.APPLE_BUNDLE_ID,
            Config.APPLE_PRIVATE_KEY_PATH,
        ]):
            logger.warning('Apple IAP config is incomplete')

    APPLE_ROOT_URLS = {
        'Sandbox': 'https://api.storekit-sandbox.itunes.apple.com',
        'Production': 'https://api.storekit.itunes.apple.com',
    }

    def generate_app_store_token(self):
        """
        Generate ES256 JWT token for App Store Server API.
        Returns the JWT string or None if config is incomplete.
        """
        if not all([
            Config.APPLE_KEY_ID,
            Config.APPLE_ISSUER_ID,
            Config.APPLE_TEAM_ID,
            Config.APPLE_BUNDLE_ID,
            Config.APPLE_PRIVATE_KEY_PATH,
        ]):
            logger.warning('Apple IAP config is incomplete -- cannot generate App Store token')
            return None

        now = int(time.time())
        payload = {
            'iss': Config.APPLE_ISSUER_ID,
            'iat': now,
            'exp': now + 3600,
            'aud': 'appstoreconnect-v1',
            'bid': Config.APPLE_BUNDLE_ID,
        }

        headers = {
            'kid': Config.APPLE_KEY_ID,
            'alg': 'ES256',
        }

        try:
            with open(Config.APPLE_PRIVATE_KEY_PATH, 'r') as f:
                private_key = f.read()

            token = jwt.encode(payload, private_key, algorithm='ES256', headers=headers)
            return token
        except Exception as e:
            logger.error(f'Error generating Apple App Store token: {str(e)}')
            return None

    def verify_transaction(self, transaction_id, environment='Sandbox'):
        """
        Verify a StoreKit 2 transaction via App Store Server API.

        Args:
            transaction_id: The transaction ID from StoreKit 2
            environment: 'Sandbox' or 'Production' -- determines which Apple API URL to use

        Returns:
            dict with transaction details, or None on failure
        """
        token = self.generate_app_store_token()
        if not token:
            return None

        base_url = self.APPLE_ROOT_URLS.get(environment, self.APPLE_ROOT_URLS['Sandbox'])
        url = f'{base_url}/inApps/v1/transactions/{transaction_id}'

        headers = {
            'Authorization': f'Bearer {token}',
            'Content-Type': 'application/json',
        }

        try:
            response = requests.get(url, headers=headers, timeout=10)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.HTTPError as e:
            logger.error(f'Apple receipt verification failed (HTTP {response.status_code}): {str(e)}')
            return None
        except requests.exceptions.RequestException as e:
            logger.error(f'Apple receipt verification failed: {str(e)}')
            return None
