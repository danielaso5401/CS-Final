from flask import Flask, render_template
from flask_restful import Resource, Api
# from flask_migrate import Migrate
from flask_misaka import Misaka
from models.Usuario import db
from flask_marshmallow import Marshmallow
from app import *

ma = Marshmallow(app)

class Elector_has_CandidatoSchema(ma.Schema):
    class Meta:
        fields = ('idElector_Candidato','elector_idElector','candidato_idCandidato','ubigeo_cod_dep','ubigeo_cod_prov','ubigeo_cod_dist')

electorCandidato_schema = Elector_has_CandidatoSchema()
electorCandidato_schemas = Elector_has_CandidatoSchema(many=True)

class RolesSchema(ma.Schema):
    class Meta:
        fields = ('idroles','roles_descripcion')

roles_schema = RolesSchema()
roles_schemas = RolesSchema(many=True)

class UsuarioSchema(ma.Schema):
    class Meta:
        fields = ('idusuario','usuario_name','usuario_usuario','usuario_contrasena',"roles_idRoles")

usuario_schema = UsuarioSchema()
usuario_schemas = UsuarioSchema(many=True)

class ElectorSchema(ma.Schema):
    class Meta:
        fields = ('id_elector',"elector_name","elector_dni","elector_image","ubigeo_idUbigeo")

elector_schema = ElectorSchema()
elector_schemas = ElectorSchema(many=True)

class UbigeoSchema(ma.Schema):
    class Meta:
        fields = ("id_ubigeo","cod_dep","cod_prov","cod_dist","des_dep","des_prov","des_dist")

ubigeo_schema = UbigeoSchema()
ubigeo_schemas = UbigeoSchema(many=True)

class CandidatoSchema(ma.Schema):
    class Meta:
        fields = ("idCandidato","candidato_name", "candidato_dni", "candidato_partpol", "candidato_fotocant", "candidato_fotopart")

candidato_schema = CandidatoSchema()
candidato_schemas = CandidatoSchema(many=True)