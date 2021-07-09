from flask import Flask
from flask import request
from flask import jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin
import time
# import schemas
from flask import Blueprint

from controllers.ubigeoController import create_ubigeo, ubigeos,ubigeos_fit, ubigeos_prov, ubigeos_dis

ubigeo_bp = Blueprint('ubigeo_bp', __name__)

ubigeo_bp.route('/create_ubigeo', methods=['POST'])(create_ubigeo)
ubigeo_bp.route('/get_ubigeo', methods=['GET'])(ubigeos)
ubigeo_bp.route('/get_dep', methods=['GET'])(ubigeos_fit)
ubigeo_bp.route('/get_prov/<ide>', methods=['GET'])(ubigeos_prov)
ubigeo_bp.route('/get_dis/<ide>/<ide2>', methods=['GET'])(ubigeos_dis)
