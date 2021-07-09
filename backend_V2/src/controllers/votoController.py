from flask import render_template, redirect, url_for, request, abort
from models.Usuario import Usuario
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()
# cors = CORS(app)

def create_voto():
    print(request.json)

    elector_idElector=request.json['elector_idElector']
    candidato_idCandidato=request.json['candidato_idCandidato']
    ubigeo_idUbigeo=request.json['ubigeo_idUbigeo']
    str = ubigeo_idUbigeo
    n = 2
    chunks = [str[i:i+n] for i in range(0, len(str), n)]
    ubigeo_cod_dep = chunks[0]
    ubigeo_cod_prov = chunks[1]
    ubigeo_cod_dist = chunks[2]

    new_voto = Elector_has_Candidato(elector_idElector,candidato_idCandidato,ubigeo_cod_dep,ubigeo_cod_prov,ubigeo_cod_dist)

    db.session.add(new_voto)
    db.session.commit()

    return electorCandidato_schema.jsonify(new_voto)

def reporte_votos():
    print(request.json)
    if request.method == "POST":
        print(request.json)
        ubigeo_cod_dep_ = request.json["ubigeo_cod_dep"]
        ubigeo_cod_prov_ = request.json["ubigeo_cod_prov"]
        ubigeo_cod_dist_ = request.json["ubigeo_cod_dist"]

        candidatos = Candidato.query.all()
     
        if ubigeo_cod_prov_ != None and ubigeo_cod_dist_ != None and ubigeo_cod_dep_ != None:
            print("distrito")
            freqs = {}
            for candidato in candidatos:
                val = Elector_has_Candidato.query.filter_by(candidato_idCandidato = candidato.idCandidato,ubigeo_cod_dep = ubigeo_cod_dep_,ubigeo_cod_prov = ubigeo_cod_prov_,ubigeo_cod_dist = ubigeo_cod_dist_).all()
                freqs[candidato.candidato_name]=len(val)
            return jsonify(freqs)

        if ubigeo_cod_prov_ == None and ubigeo_cod_dist_ == None and not ubigeo_cod_dep_ is None  :
            print("departamento")
            freqs = {}
            for candidato in candidatos:
                val = Elector_has_Candidato.query.filter_by(candidato_idCandidato = candidato.idCandidato,ubigeo_cod_dep = ubigeo_cod_dep_).all()
                freqs[candidato.candidato_name]=len(val)
            return jsonify(freqs)

        if ubigeo_cod_dist_ == None and not ubigeo_cod_dep_ is None and not ubigeo_cod_prov_ is None:
            print("provincia")
            freqs = {}
            for candidato in candidatos:
                val = Elector_has_Candidato.query.filter_by(candidato_idCandidato = candidato.idCandidato,ubigeo_cod_dep = ubigeo_cod_dep_,ubigeo_cod_prov = ubigeo_cod_prov_).all()
                freqs[candidato.candidato_name]=len(val)
            return jsonify(freqs)

        if ubigeo_cod_prov_ == None and ubigeo_cod_dist_ == None and ubigeo_cod_dep_ == None:
            print("pais")
            freqs = {}
            for candidato in candidatos:
                val = Elector_has_Candidato.query.filter_by(candidato_idCandidato = candidato.idCandidato).all()
                freqs[candidato.candidato_name]=len(val)
            return jsonify(freqs)

    all_votos = Elector_has_Candidato.query.all()
    result = electorCandidato_schemas.dump(all_votos)
    return jsonify(result)  