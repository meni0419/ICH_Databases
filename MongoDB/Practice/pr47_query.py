from MongoDB.collection import collections
from MongoDB.Practice.pr47_script import user_data

queries = {
    "pr47_task1": lambda: collections["010724_Max"].count_documents({}),

    "pr47_task2": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="091224_users_Max"
    ).insert_many(user_data),

    "pr47_task3": lambda: collections["091224_users_Max"].count_documents({}),

    "pr47_task4": lambda: collections.imdb.aggregate([
        {"$set": {"year_int": {"$toInt": "$year"}}},
        {"$group": {"_id": "$year_int", "count": {"$sum": 1}}},
        {"$match": {"_id": {"$gte": 1980, "$lte": 1990}}},
        {"$sort": {"_id": -1}},
    ]),

    "pr47_task5": lambda: collections.imdb.aggregate([
        {"$group": {"_id": "$countries", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 3}
    ]),

    "pr47_task6": lambda: collections.imdb.aggregate([
        {"$group": {"_id": "$countries", "avg_rating": {"$avg": "$imdb.rating"}}},
        {"$sort": {"avg_rating": -1}},
        {"$limit": 3},
    ]),

    "pr47_task7": lambda: collections.imdb.aggregate([
        {"$group": {"_id": "$countries", "avg_rating": {"$avg": "$imdb.rating"}}},
        {"$sort": {"avg_rating": -1}},
        {"$unwind": "$_id"},
        {"$limit": 3}
    ]),

    "pr47_task8": lambda: collections.imdb.aggregate([
        {"$unwind": "$countries"},
        {"$group": {"_id": "$countries", "avg_rating": {"$avg": "$imdb.rating"}}},
        {"$sort": {"avg_rating": -1}},
        {"$limit": 3}
    ]),

    "pr47_task9": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="planets_091224_max"
    ).insert_many(planet_data),

    "pr47_task10": lambda: collections.planets_091224_max
    .find({"name": "Mercury"}),

    "pr47_task11": lambda: collections.planets_091224_max
    .find({"orderFromSun": {"$gte": 1, "$lte": 3}}),

    "pr47_task12": lambda: collections.planets_091224_max
    .aggregate([
        {"$group": {"_id": "$hasRings", "count": {"$sum": 1}}},
    ]),

    "pr47_task13": lambda: collections.planets_091224_max
    .find(),

    "pr47_task14": lambda: collections.planets_091224_max
    .find({"surfaceTemperatureC": {"$gt": 50}}),

    "pr47_task15": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="planets_091224_hard"
    ).insert_many(planet_data),

    "pr47_task16": lambda: collections.planets_091224_hard
    .find({"$and": [{"hasRings": False}, {"surfaceTemperatureC": {"$lt": 0}}]},
          {"_id": 0, "name": 1}),

    "pr47_task17": lambda: collections.planets_091224_hard
    .aggregate([
        {"$group": {"_id": "$system", "count": {"$sum": 1}, "planets": {"$push": "$name"}}},
        {"$sort": {"orderFromStar": 1}}
    ])
}
planet_data = [
    # Солнечная система (8 планет + 2 колонии)
    {
        "id": 1,
        "name": "Меркурий",
        "system": "Солнечная",
        "orderFromSun": 1,
        "type": "пустынная",
        "hasRings": False,
        "surfaceTemperatureC": 430,
        "population": 120,
        "foundingYear": 2085,
        "dominantRace": "шахтёры-синтетики",
        "waterPercentage": 0,
        "techLevel": "низкий",
        "moons": 0,
        "capital": "Гелиополис",
        "exports": ["редкие металлы"]
    },
    {
        "id": 2,
        "name": "Венера",
        "system": "Солнечная",
        "orderFromSun": 2,
        "type": "парниковая",
        "hasRings": False,
        "surfaceTemperatureC": 464,
        "population": 850,
        "foundingYear": 2120,
        "dominantRace": "облачные жители",
        "waterPercentage": 0,
        "techLevel": "средний",
        "moons": 0,
        "capital": "Нептуния",
        "exports": ["кислотные ферменты"]
    },
    {
        "id": 3,
        "name": "Земля",
        "system": "Солнечная",
        "orderFromSun": 3,
        "type": "землеподобная",
        "hasRings": False,
        "surfaceTemperatureC": 14,
        "population": 7800,
        "foundingYear": 1969,
        "dominantRace": "люди",
        "waterPercentage": 71,
        "techLevel": "высокий",
        "moons": 1,
        "capital": "Нью-Атлантида",
        "exports": ["нанотехнологии"]
    },
    {
        "id": 4,
        "name": "Марс",
        "system": "Солнечная",
        "orderFromSun": 4,
        "type": "терраформированная",
        "hasRings": False,
        "surfaceTemperatureC": -63,
        "population": 2400,
        "foundingYear": 2103,
        "dominantRace": "марсиане-гибриды",
        "waterPercentage": 40,
        "techLevel": "высокий",
        "moons": 2,
        "capital": "Олимпус Сити",
        "exports": ["генетические модификации"]
    },
    {
        "id": 5,
        "name": "Церера",
        "system": "Солнечная",
        "orderFromSun": 4.5,
        "type": "карликовая",
        "hasRings": False,
        "surfaceTemperatureC": -106,
        "population": 600,
        "foundingYear": 2145,
        "dominantRace": "кристаллические формы",
        "waterPercentage": 25,
        "techLevel": "средний",
        "moons": 0,
        "capital": "Ледяной Куб",
        "exports": ["космический лёд"]
    },
    {
        "id": 6,
        "name": "Юпитер",
        "system": "Солнечная",
        "orderFromSun": 5,
        "type": "газовый гигант",
        "hasRings": True,
        "surfaceTemperatureC": -145,
        "population": 1800,
        "foundingYear": 2150,
        "dominantRace": "киборги",
        "waterPercentage": 0,
        "techLevel": "средний",
        "moons": 95,
        "capital": "Облачный город-5",
        "exports": ["гелиевые изотопы"]
    },
    {
        "id": 7,
        "name": "Европа",
        "system": "Солнечная",
        "orderFromSun": 5.2,
        "type": "океаническая",
        "hasRings": False,
        "surfaceTemperatureC": -160,
        "population": 950,
        "foundingYear": 2167,
        "dominantRace": "европейские кальмароиды",
        "waterPercentage": 99,
        "techLevel": "высокий",
        "moons": 0,
        "capital": "Абиссополис",
        "exports": ["биолюминесцентные организмы"]
    },

    # Альфа Центавра (6 планет)
    {
        "id": 8,
        "name": "Кентавра Прайм",
        "system": "Альфа Центавра",
        "orderFromStar": 2,
        "type": "океаническая",
        "hasRings": False,
        "surfaceTemperatureC": 28,
        "population": 4200,
        "foundingYear": 2245,
        "dominantRace": "центаврианцы",
        "waterPercentage": 94,
        "techLevel": "средний",
        "moons": 3,
        "capital": "Акваполис",
        "exports": ["подводные кристаллы"]
    },
    {
        "id": 9,
        "name": "Хелион-6",
        "system": "Альфа Центавра",
        "orderFromStar": 4,
        "type": "вулканическая",
        "hasRings": True,
        "surfaceTemperatureC": 890,
        "population": 80,
        "foundingYear": 2301,
        "dominantRace": "лаваны",
        "waterPercentage": 0,
        "techLevel": "низкий",
        "moons": 0,
        "capital": "Пирокласт",
        "exports": ["плазменные руды"]
    },
    {
        "id": 10,
        "name": "Нимбус-9",
        "system": "Альфа Центавра",
        "orderFromStar": 3,
        "type": "газовая карликовая",
        "hasRings": False,
        "surfaceTemperatureC": -200,
        "population": 300,
        "foundingYear": 2290,
        "dominantRace": "эфирные существа",
        "waterPercentage": 0,
        "techLevel": "экзотический",
        "moons": 12,
        "capital": "Вихревая Башня",
        "exports": ["антиматерия"]
    },

    # Сириус (5 планет + 1 искусственная)
    {
        "id": 11,
        "name": "Сириус-Вета",
        "system": "Сириус",
        "orderFromStar": 1,
        "type": "кристаллическая",
        "hasRings": False,
        "surfaceTemperatureC": -180,
        "population": 1500,
        "foundingYear": 2289,
        "dominantRace": "кристаллиды",
        "waterPercentage": 12,
        "techLevel": "высокий",
        "moons": 2,
        "capital": "Фацет-Сити",
        "exports": ["оптические процессоры"]
    },
    {
        "id": 12,
        "name": "Тенебрис",
        "system": "Сириус",
        "orderFromStar": 3,
        "type": "темная материя",
        "hasRings": True,
        "surfaceTemperatureC": -273,
        "population": 0,
        "foundingYear": None,
        "dominantRace": "теневые формы",
        "waterPercentage": 0,
        "techLevel": "неизвестен",
        "moons": 7,
        "capital": None,
        "exports": ["чёрные алмазы"]
    },
    {
        "id": 13,
        "name": "Люмен-Омега",
        "system": "Сириус",
        "orderFromStar": 2,
        "type": "световая аномалия",
        "hasRings": False,
        "surfaceTemperatureC": 10000,
        "population": 200,
        "foundingYear": 2345,
        "dominantRace": "фотонные существа",
        "waterPercentage": 0,
        "techLevel": "трансцендентный",
        "moons": 0,
        "capital": "Плазменный Собор",
        "exports": ["квантовые батареи"]
    }
]