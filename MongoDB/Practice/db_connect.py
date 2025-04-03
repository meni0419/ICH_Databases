from pymongo import MongoClient

CONNECTIONS = {
    "ich1": {
        "uri": "mongodb://ich1:password@mongo.edu.itcareerhub.de:27017",
        "auth_source": "ich",
        "uri_params": "?readPreference=primary&ssl=false&authMechanism=DEFAULT"
    },
    "ich_editor": {
        "uri": "mongodb://ich_editor:verystrongpassword@mongo.edu.itcareerhub.de:27017",
        "auth_source": "ich_edit",
        "uri_params": "?readPreference=primary&ssl=false&authMechanism=DEFAULT"
    }
}

def get_db(connection_name, db_name):
    config = CONNECTIONS[connection_name]
    full_uri = f"{config['uri']}{config['uri_params']}&authSource={config['auth_source']}"
    client = MongoClient(full_uri)
    return client[db_name]