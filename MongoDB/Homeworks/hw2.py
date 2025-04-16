from MongoDB.collection import collections

queries = {
    # 1. Коллекция imdb : Используя оператор $size, найдите фильмы, написанные 3 сценаристами (writers) и снятые 2 режиссерами (directors)
    "hw2-task1":
        collections.imdb.find(
            {"writers": {"$size": 3}, "directors": {"$size": 2}})
        .limit(10),

    # 2. Коллекция bookings: Найдите адрес нахождения автомобиля с vin WME4530421Y135045 по самой последней дате (и времени) final_date
    "hw2-task2":
        collections.bookings
        .find({"vin": "WME4530421Y135045"}, )
        .sort("final_date", -1)
        .limit(1),

    # 3. Коллекция bookings: подсчитайте, у скольких автомобилей при окончании аренды закончилось топливо (final_fuel)
    "hw2-task3":
        collections.bookings
        .count_documents({"final_fuel": 0}),

    # 4. Коллекция bookings: найдите номерной знак и vin номер авто, с самым большим километражом (distance)
    "hw2-task4":
        collections.bookings
        .find({}, {"_id": 0, "plate": 1, "vin": 1, "driving.distance": 1})
        .sort("driving.distance", -1)
        .limit(1),

    # 5. Коллекция imdb. Найдите фильм с участием "Brad Pitt" с самым высоким рейтингом (imdb.rating)
    "hw2-task5":
        collections.imdb
        .find({"cast": "Brad Pitt", "imdb.rating": {"$ne": ""}})
        .sort("imdb.rating", -1)
        .limit(1),
}
