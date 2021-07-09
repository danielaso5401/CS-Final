from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class Elector_has_Candidato(db.Model):
    idElector_Candidato = db.Column(db.Integer, primary_key=True)
    elector_idElector = db.Column(db.Integer,db.ForeignKey('elector.id_elector'),nullable=False)
    candidato_idCandidato = db.Column(db.Integer,db.ForeignKey('candidato.idCandidato'),nullable=False)
    ubigeo_cod_dep= db.Column(db.String(2))
    ubigeo_cod_prov = db.Column(db.String(2))
    ubigeo_cod_dist = db.Column(db.String(2))


    def __init__(self, elector_idElector, candidato_idCandidato,ubigeo_cod_dep,ubigeo_cod_prov,ubigeo_cod_dist):
        self.elector_idElector = elector_idElector
        self.candidato_idCandidato = candidato_idCandidato
        self.ubigeo_cod_dep = ubigeo_cod_dep
        self.ubigeo_cod_prov = ubigeo_cod_prov
        self.ubigeo_cod_dist = ubigeo_cod_dist