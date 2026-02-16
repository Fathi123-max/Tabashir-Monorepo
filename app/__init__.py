from flask import Flask
from flask_cors import CORS

def create_app():
    app = Flask(__name__)
    CORS(app)

    # Register blueprints
    from app.routes.auth_routes import auth_bp
    from app.routes.profile_routes import profile_bp
    app.register_blueprint(auth_bp)
    app.register_blueprint(profile_bp)

    return app
