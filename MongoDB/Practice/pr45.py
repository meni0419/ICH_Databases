from rich.console import group

from MongoDB.collection import collections

queries = {
    "pr45_task1": lambda: collections.trips
    .aggregate([
        {"$group":
             {"_id": "$bikeid",
              "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 1}
    ]),

    "pr45_task2": lambda: collections.imdb
    .find({"imdb.rating": {"$exists": True, "$type": "number"},
           "type": "movie", "year": "1989"},
          {"_id": 0, "title": 1, "type": 1, "imdb.rating": 1})
    .sort("imdb.rating", -1)
    .limit(10),

    "pr45_task3": lambda: collections.parkings
    .aggregate([
        {"$group": {"_id": "$vendor", "count": {"$sum": 1}}},
    ]),

    "pr45_task4": lambda: collections.parkings
    .aggregate([
        {"$group": {"_id": "$engineType", "count": {"$avg": "$fuel"}}},
    ]),

    "pr45_task5": lambda: collections.parkings
    .aggregate([
        {"$set": {"duration": {"$subtract": ["$final_time", "$init_time"]}}},
        {"$match": {"duration": {"$gt": 300}}},
        {"$count": "count_doc"},
    ]),

    "pr45_task6": lambda: collections.parkings
    .aggregate([
        {"$group": {"_id": {"city": "$city", "interior": "$interior"}, "count": {"$sum": 1}}}
    ]),

    "pr45_task7": lambda: collections.parkings
    .aggregate([
        {"$sort": {"fuel": -1}},
        {"$limit": 10}
    ]),

    "pr45_task8": lambda: collections.parkings
    .aggregate([
        {"$addFields": {"year": {"$year": "$init_date"}}},
        {"$sort": {"year": -1}},
        {"$limit": 10}
    ]),

    "pr45_task9": lambda: collections.parkings
    .aggregate([
        {"$project": {"plate": 1, "loc.coordinates": 1, "_id": 0}},
        {"$limit": 10}
    ]),

    "pr45_task10": lambda: collections.parkings
    .aggregate([
        {"$match": {"engineType": {"$exists": True}}},
        {"$group": {"_id": "$engineType"}},
        {"$count": "count_doc"},
    ]),

    "pr45_task11": lambda: collections.parkings
    .aggregate([
        {"$match": {"smartPhoneRequired": True}},
        {"$count": "count_doc"},
    ])
}

"""Отображать только поля `plate` и `loc.coordinates`.
10. Найти уникальные значения в поле `engineType`.
Подсчитать количество машин, у которых `smartPhoneRequired: true`"""
