from pymongo import MongoClient
from dotenv import load_dotenv
import os

# Load environment variables from the .env file
load_dotenv()

CONNECTIONS = {
    "ich1": {
        "uri": f"mongodb://{os.getenv('ICH1_USERNAME')}:{os.getenv('ICH1_PASSWORD')}@{os.getenv('MONGO_HOST')}:{os.getenv('MONGO_PORT')}",
        "auth_source": "ich",
        "uri_params": "?readPreference=primary&ssl=false&authMechanism=DEFAULT"
    },
    "ich_editor": {
        "uri": f"mongodb://{os.getenv('ICH_EDITOR_USERNAME')}:{os.getenv('ICH_EDITOR_PASSWORD')}@{os.getenv('MONGO_HOST')}:{os.getenv('MONGO_PORT')}",
        "auth_source": "ich_edit",
        "uri_params": "?readPreference=primary&ssl=false&authMechanism=DEFAULT"
    }
}


def get_db(connection_name, db_name):
    config = CONNECTIONS[connection_name]
    full_uri = f"{config['uri']}{config['uri_params']}&authSource={config['auth_source']}"
    client = MongoClient(full_uri)
    return client[db_name]
