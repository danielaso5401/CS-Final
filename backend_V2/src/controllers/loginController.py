from flask import render_template, redirect, url_for, request, abort
from models.Elector import Elector
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

def login_post():
    username = request.json['usuario']
    password = request.json['contraseña']
    if username is None or password is None:
        print("user or pass is none")
        return "Falta llenar usuario o contraseña"
    if Usuario.query.filter_by(usuario_usuario = username).first() is  None or Usuario.query.filter_by(usuario_contraseña = password).first() is  None:
        print("user or pass is ready")
        rest = {
            'idRoldes': None
        }
        return jsonify(rest)
    user = Usuario.query.filter_by(usuario_usuario = username).first()
    passt = Usuario.query.filter_by(usuario_contraseña = password).first()
    user_auth = user.idusuario
    pass_auth = passt.idusuario
    if user == passt:
        print(passt.roles_idRoles)
        freqs = {
            'idRoldes': passt.roles_idRoles
        }
        return jsonify(freqs)
    else:
        rest = {
            'idRoldes': None
        }
        return jsonify(rest)