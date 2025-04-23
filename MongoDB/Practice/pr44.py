from MongoDB.collection import collections

queries = {
    "pr44_task1": lambda: collections.US_Adult_Income
    .count_documents({"$or": [{"education": " Bachelors"},
                              {"age": {"$lt": 30}}]}),

    "pr44_task2": lambda: collections.imdb
    .count_documents({"directors": {"$exists": False}}),

    "pr44_task3": lambda: collections.imdb
    .count_documents({"countries": {"$all": ["USA", "France"]}}),

    "pr44_task3_1": lambda: collections.imdb
    .count_documents({"countries": ["USA", "France"]}),

    "pr44_task3_2": lambda: collections.imdb
    .count_documents({"$and": [{"countries": "USA"},
                               {"countries": "France"}]}),

    "pr44_task4": lambda: collections.imdb
    .find_one({"languages": "Chinese"}),

    "pr44_task5": lambda: collections.imdb
    .count_documents({"$or": [{"languages": "Chinese"},
                              {"languages": "French"}]}),

    "pr44_task5_1": lambda: collections.imdb
    .count_documents({"languages": {"$in": ["Chinese", "French"]}}),

    "pr44_task6": lambda: collections.imdb
    .count_documents({"$or": [{"genres": "Mystery"},
                              {"genres": "Sci-Fi"}]}),

    "pr44_task7": lambda: collections.imdb
    .find(
        {"$or": [{"imdb.rating": {"$exists": False}},
                 {"imdb.rating": {"$eq": ""}}]})
    .sort("released", -1)
    .limit(1),

    "pr44_task8": lambda: collections.imdb
    .find({"title": "Berlin Alexanderplatz"},
          {"title": 1, "type": 1, "runtime": 1, "_id": 0}),

    "pr44_task9": lambda: collections.imdb
    .find({"type": "series"}, {"_id": 0, "title": 1, "type": 1, "runtime": 1})
    .sort("runtime", -1)
    .limit(1),

    "pr44_task10": lambda: collections.imdb.find({
        "$and": [
            {"imdb.rating": {"$exists": True, "$type": "number"}},
            {"$or": [{"type": "series"}, {"type": "movie"}]}
        ]
    }, {"_id": 0, "title": 1, "type": 1, "imdb.rating": 1})
    .sort("imdb.rating", -1)
    .limit(1),

    "pr44_task10_1": lambda: collections.imdb.find({
        "$and": [
            {"imdb.rating": {"$gte": 0}},
            {"$or": [{"type": "series"}, {"type": "movie"}]}
        ]
    }, {"_id": 0, "title": 1, "type": 1, "imdb.rating": 1})
    .sort("imdb.rating", -1)
    .limit(1),

    "pr44_task10_2": lambda: collections.imdb.find({
        "$and": [
            {"$and": [{"imdb.rating": {"$exists": True}}, {"imdb.rating": {"$ne": ""}}]},
            {"$or": [{"type": "series"}, {"type": "movie"}]}
        ]
    }, {"_id": 0, "title": 1, "type": 1, "imdb.rating": 1})
    .sort("imdb.rating", -1)
    .limit(1),

    "pr44_task10_3": lambda: collections.imdb
    .find({"imdb.rating": {"$exists": True, "$type": "number"},
           "type": {"$in": ["series", "movie"]}}, {"_id": 0, "title": 1, "type": 1, "imdb.rating": 1})
    .sort("imdb.rating", -1)
    .limit(1),
}

"""Найти сериал или фильм с самым высоким рейтингом. В коллекции есть документы без рейтинга или с пустым значением. Попробовать несколько вариантов, в том числе не оптимальный"""
