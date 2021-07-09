from flask import render_template, redirect, url_for, request, abort
from models.Ubigeo import Ubigeo
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()
# cors = CORS(app)

def create_ubigeo():
    print(request.json)
    ("id_ubigeo","cod_dep","cod_prov","cod_dist","des_dep","des_prov","des_dist")

    id_ubigeo = request.json["id_ubigeo"]
    cod_dep = request.json["cod_dep"]
    cod_prov = request.json["cod_prov"]
    cod_dist = request.json["cod_dist"]
    des_dep = request.json["des_dep"]
    des_prov = request.json["des_prov"]
    des_dist = request.json["des_dist"]
    new_ubigeo = Ubigeo(id_ubigeo,cod_dep,cod_prov,cod_dist,des_dep,des_prov,des_dist)
    db.session.add(new_ubigeo)
    db.session.commit()

    return ubigeo_schema.jsonify(new_ubigeo)

def ubigeos():
    all_ubigeos = Ubigeo.query.all()
    result = ubigeo_schemas.dump(all_ubigeos)
    return jsonify(result)

def ubigeos_fit():
    all_ubigeos = Ubigeo.query.filter_by(cod_prov="")
    result = ubigeo_schemas.dump(all_ubigeos)
    return jsonify(result)

def ubigeos_prov(ide):
    all_ubigeos = Ubigeo.query.filter_by(cod_dep=ide,cod_dist="")
    result = ubigeo_schemas.dump(all_ubigeos)
    return jsonify(result)

def ubigeos_dis(ide, ide2):
    all_ubigeos = Ubigeo.query.filter_by(cod_dep=ide,cod_prov=ide2)
    result = ubigeo_schemas.dump(all_ubigeos)
    return jsonify(result)