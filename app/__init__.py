from flask import Flask
from flask_cors import CORS
from app.config import Config as _Config
Config = _Config

def create_app():
    app = Flask(__name__)
    CORS(app)

    # Register blueprints
    from app.routes.auth_routes import auth_bp
    from app.routes.profile_routes import profile_bp, mobile_profile_bp
    from app.routes.job_routes import job_bp
    from app.routes.home_routes import home_bp
    from app.routes.mobile_routes import mobile_bp, candidate_bp, ai_job_apply_bp
    from app.routes.resume_mobile_routes import resume_mobile_bp

    app.register_blueprint(auth_bp)
    app.register_blueprint(profile_bp)
    app.register_blueprint(mobile_profile_bp)
    app.register_blueprint(job_bp)
    app.register_blueprint(home_bp)
    app.register_blueprint(mobile_bp)
    app.register_blueprint(candidate_bp)
    app.register_blueprint(ai_job_apply_bp)
    app.register_blueprint(resume_mobile_bp)

    return app
