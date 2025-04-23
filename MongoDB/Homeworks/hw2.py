from MongoDB.collection import collections

queries = {
    # 1. Коллекция imdb : Используя оператор $size, найдите фильмы, написанные 3 сценаристами (writers) и снятые 2 режиссерами (directors)
    "hw2_task1": lambda:
    collections.imdb.find(
        {"writers": {"$size": 3}, "directors": {"$size": 2}})
    .limit(10),

    # 2. Коллекция bookings: Найдите адрес нахождения автомобиля с vin WME4530421Y135045 по самой последней дате (и времени) final_date
    "hw2_task2": lambda:
    collections.bookings
    .find({"vin": "WME4530421Y135045"}, )
    .sort("final_date", -1)
    .limit(1),

    # 3. Коллекция bookings: подсчитайте, у скольких автомобилей при окончании аренды закончилось топливо (final_fuel)
    "hw2_task3": lambda:
    collections.bookings
    .count_documents({"final_fuel": 0}),

    # 4. Коллекция bookings: найдите номерной знак и vin номер авто, с самым большим километражом (distance)
    "hw2_task4": lambda:
    collections.bookings
    .find({}, {"_id": 0, "plate": 1, "vin": 1, "driving.distance": 1})
    .sort("driving.distance", -1)
    .limit(1),

    # 5. Коллекция imdb. Найдите фильм с участием "Brad Пит" с самым высоким рейтингом (imdb.rating)
    "hw2_task5": lambda:
    collections.imdb
    .find({"cast": "Brad Pitt", "imdb.rating": {"$ne": ""}})
    .sort("imdb.rating", -1)
    .limit(1),
}
