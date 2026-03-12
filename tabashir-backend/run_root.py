import os
from flask import Flask
from flask_cors import CORS

# Import existing resume routes namespace
from app.routes.resume_routes import resume_ns
from app.routes.auth_namespace import auth_ns
from app.routes.profile_namespace import profile_ns
from app.routes.home_namespace import home_ns
from app.routes.jobs_namespace import jobs_ns
from flask_restx import Api

def create_app():
    app = Flask(__name__)
    CORS(app)

    # Setup Flask-RESTX API with namespace
    api = Api(
        app,
        version='1.0',
        title='Tabashir API',
        description='HR Consulting Platform API',
        doc='/docs'
    )

    # Register namespaces with API (for Swagger docs)
    api.add_namespace(auth_ns, path='/api/mobile/auth')
    api.add_namespace(profile_ns, path='/api/user')
    # Note: home_ns disabled to avoid conflict with home_bp blueprint
    # api.add_namespace(home_ns, path='/api/mobile/home')
    api.add_namespace(jobs_ns, path='/api')
    api.add_namespace(resume_ns, path='/api/v1/resume')

    # Register blueprints (actual route handlers)
    from app.routes.auth_routes import auth_bp
    from app.routes.profile_routes import profile_bp, mobile_profile_bp
    from app.routes.job_routes import job_bp
    from app.routes.home_routes import home_bp
    from app.routes.resume_routes import resume_bp, home_mobile_bp
    from app.routes.mobile_routes import mobile_bp, candidate_bp, ai_job_apply_bp
    from app.routes.resume_mobile_routes import resume_mobile_bp

    app.register_blueprint(auth_bp)
    app.register_blueprint(profile_bp)
    app.register_blueprint(mobile_profile_bp)
    app.register_blueprint(job_bp)
    app.register_blueprint(home_bp)
    app.register_blueprint(resume_bp)
    app.register_blueprint(home_mobile_bp)
    app.register_blueprint(mobile_bp)
    app.register_blueprint(candidate_bp)
    app.register_blueprint(ai_job_apply_bp)
    app.register_blueprint(resume_mobile_bp)

    return app


if __name__ == '__main__':
    app = create_app()
    port = int(os.getenv("FLASK_PORT", 5001))
    app.run(host='0.0.0.0', port=port, debug=True)
