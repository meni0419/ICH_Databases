from db_connect import get_db

# Конфигурация для всех баз и коллекций
CONFIGS = {
    "ich": {
        "connection": "ich1",
        "db_name": "ich",
        "collections": {
            "Spotify_Youtube": {},
            "UK_used_cars": {},
            "US_Adult_Income": {},
            "bookings": {},
            "credit_cards": {},
            "customers": {},
            "imdb": {},
            "order_details": {},
            "orders": {},
            "parkings": {},
            "sample_training": {},
            "companies": {},
            "neighborhoods": {},
            "restaurants": {},
            "sales": {},
            "shipwrecks": {}
        }
    },
    "sample_data": {
        "connection": "ich1",
        "db_name": "sample_data",
        "collections": {
            "trips": {},
            "companies": {},
            "neighborhoods": {},
            "restaurants": {},
            "sales": {},
            "shipwrecks": {},
            "test": {}
        }
    }
}


class CollectionManager:
    _connections_cache = {}

    def __getattr__(self, name):
        # Ищем коллекцию во всех конфигах
        for config_name, config in CONFIGS.items():
            if name in config["collections"]:
                # Кэшируем подключения
                if config_name not in self._connections_cache:
                    self._connections_cache[config_name] = get_db(
                        config["connection"],
                        config["db_name"]
                    )
                return self._connections_cache[config_name][name]

        raise AttributeError(f"Collection '{name}' not defined in any config")


collections = CollectionManager()