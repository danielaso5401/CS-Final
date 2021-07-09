from flask import Flask
from flask import request
from flask import jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin
import time
# import schemas
from flask import Blueprint

from controllers.votoController import create_voto, reporte_votos

voto_bp = Blueprint('voto_bp', __name__)

voto_bp.route('/create_voto', methods=['POST'])(create_voto)
voto_bp.route('/get_votos', methods=['GET','POST'])(reporte_votos)
