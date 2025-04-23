from db_connect import get_db
from pymongo.errors import OperationFailure


class CollectionManager:
    _connections_cache = {}
    _collection_cache = {}  # Новый кэш для коллекций
    _connection_order = ["ich_editor", "ich1"]

    def __getitem__(self, collection_name):
        return self.__getattr__(collection_name)

    def get_collection_via_connection(self, connection_name, db_name, collection_name):
        if connection_name not in self._connections_cache:
            self._connections_cache[connection_name] = get_db(connection_name, "admin").client
        client = self._connections_cache[connection_name]
        db = client[db_name]
        return db[collection_name]

    def __getattr__(self, collection_name):
        # Проверяем кэш первым делом
        if collection_name in self._collection_cache:
            return self._collection_cache[collection_name]

        # Если нет в кэше - ищем
        for connection_name in self._connection_order:
            try:
                if connection_name not in self._connections_cache:
                    self._connections_cache[connection_name] = get_db(
                        connection_name,
                        "admin"
                    ).client

                client = self._connections_cache[connection_name]

                for db_name in client.list_database_names():
                    if db_name in ["admin", "local", "config"]:
                        continue

                    db = client[db_name]

                    if collection_name in db.list_collection_names():
                        # Сохраняем в кэш
                        self._collection_cache[collection_name] = db[collection_name]
                        return self._collection_cache[collection_name]

            except OperationFailure as e:
                print(f"Warning: No access to {connection_name} - {str(e)}")
                continue

        raise AttributeError(f"Collection '{collection_name}' not found")


collections = CollectionManager()


def clear_cache(self):
    self._collection_cache.clear()
    self._connections_cache.clear()
