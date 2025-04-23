from MongoDB.collection import collections

queries = {
    "43_imdb": lambda: collections.imdb
    .find({"tomatoes": {"$exists": True},
           "tomatoes.viewer.rating": {"$gt": 4.5}})
    .sort("released", -1),

    "43_imdb-count": lambda: collections.imdb
    .count_documents({"tomatoes": {"$exists": True},
                      "tomatoes.viewer.rating": {"$gt": 4.5}}),

    # Для фильмов жанра «Драма» и из США, покажите их сюжет (plot), продолжительность (runtime) и название (title). Упорядочите результаты по убыванию продолжительности.
    "43_imdb-info": lambda: collections.imdb
    .find({"genres": "Drama", "countries": "USA"},
          {"plot": 1, "runtime": 1, "title": 1, })
    .sort([("runtime", -1), ("title", -1)]),

    # Для фильмов жанра «Драма» и из США, покажите их сюжет (plot), продолжительность (runtime) и название (title). Упорядочите результаты по убыванию продолжительности.
    "43_imdb-info2": lambda: collections.imdb
    .find({"genres": "Drama", "countries": "USA"},
          {"plot": 1, "runtime": 1, "title": 1, })
    .sort("runtime", -1),

    "43_imdb-info3": lambda: collections.imdb
    .find({"genres": {"$in": ["Drama", "Fantasy"]}, "countries": "USA"},
          {"genres": 1, "plot": 1, "runtime": 1, "title": 1})
    .sort("runtime", -1),

    # Найдите фильмы, удовлетворяющие всем следующим условиям:
    # ● были опубликованы между 1900 и 1910 годами.
    # ● рейтинг imdb выше 7.0
    # ● имеют награды или номинации.
    # Выведите название, год выхода и длительность и не показывайте идентификатор документа.
    # Отсортируйте результаты по возрастанию рейтинга IMDB.
    "43_imdb-info4": lambda: collections.imdb
    .aggregate([{"$set": {"year_int": {"$toInt": "$year"}}},
                {"$match": {"year_int": {"$gte": 1900, "$lte": 1910},
                            "imdb.rating": {"$gt": 7.0},
                            "awards": {"$exists": True}}},
                {"$project": {"title": 1, "year": 1, "runtime": 1, "imdb.rating": 1, "awards": 1, "_id": 0}},
                {"$sort": {"imdb.rating": 1}},
                {"$limit": 10}
                ]),

    # Вернуть пользователей, чей возраст находится в диапазоне от 22 до 30 лет
    "43_customers-age": lambda: collections.US_Adult_Income
    .find({"$and": [{"age": {"$gte": 22}},
                    {"age": {"$lte": 30}}]})
    .limit(10)
}
