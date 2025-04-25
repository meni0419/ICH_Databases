from MongoDB.collection import collections

queries = {
    # Коллекция imdb : Используя оператор $size, найдите фильмы, написанные 3 сценаристами (writers) и снятые 2 режиссерами (directors)
    "hw3_task1": lambda: collections.imdb
    .find({"writers": {"$size": 3}, "directors": {"$size": 2}}),

    # Коллекция bookings: Найдите адрес нахождения автомобиля с vin WME4530421Y135045 по самой последней дате (и времени) final_date
    "hw3_task2": lambda: collections.bookings
    .find({"vin": "WME4530421Y135045"}, )
    .sort("final_date", -1)
    .limit(1),

    # Коллекция bookings: подсчитайте, у скольких автомобилей при окончании аренды закончилось топливо (final_fuel)
    "hw3_task3": lambda: collections.bookings
    .count_documents({"final_fuel": 0}),

    # Коллекция bookings: найдите номерной знак и vin номер авто, с самым большим километражом (distance)
    "hw3_task4": lambda: collections.bookings
    .find({}, {"_id": 0, "plate": 1, "vin": 1, "driving.distance": 1})
    .sort("driving.distance", -1)
    .limit(1),

    # Коллекция imdb. Найдите фильм с участием "Brad Pitt" с самым высоким рейтингом (imdb.rating)
    "hw3_task5": lambda: collections.imdb
    .find({"cast": "Brad Pitt", "imdb.rating": {"$ne": ""}})
    .sort("imdb.rating", -1)
    .limit(1),

}
