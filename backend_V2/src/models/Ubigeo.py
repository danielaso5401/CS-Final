from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()
import models.Elector

class Ubigeo(db.Model):
    id_ubigeo = db.Column(db.VARCHAR, primary_key=True)
    cod_dep = db.Column(db.String(2))
    cod_prov = db.Column(db.String(2))
    cod_dist = db.Column(db.String(2))
    des_dep= db.Column(db.String(45))
    des_prov= db.Column(db.String(45))
    des_dist= db.Column(db.String(45))
    electores = db.relationship('Elector', backref='ubigeo', lazy=True)

    def __init__(self,cod_dep,cod_prov,cod_dist,des_dep,des_prov,des_dist):
        self.cod_dep = cod_dep
        self.cod_prov = cod_prov
        self.cod_dist = cod_dist
        self.des_dep = des_dep
        self.des_prov = des_prov
        self.des_dist = des_dist