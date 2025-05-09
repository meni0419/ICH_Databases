from MongoDB.collection import collections

queries = {
    # Из коллекции sample_airbnb.listingsAndReviews найдите среднюю цену за сутки проживания на Гавайских островах.
    # Островов несколько, поэтому либо используем {'address.location': {$geoWithin: { $centerSphere ….
    # Либо перечисляем все возможные острова в поле market
    # Подсказка - нам понадобится 2 этапа агрегации : $match и $group
    "hw6_task1": lambda: collections.listingsAndReviews
    .aggregate([
        {"$match": {
            "address.location": {
                "$geoWithin": {
                    # Координаты центра Гавайев и радиус ~500 км
                    "$centerSphere": [[-157.858, 21.306], 500 / 6378.1]
                }
            }
        }},
        {"$group": {"_id": None, "avg_price": {"$avg": "$price"}}}
    ]),
    # {"$match": {"market": {"$in": ["Hawaii", "Oahu", "Maui"]}}}

    # 2.Подсчитайте в коллекции sample_mflix.movies, сколько фильмов имеют imdb рейтинг выше 8 и выходили в период с 2015 до 2023 года (используем year) Какой из них имеет самый высокий рейтинг ?
    "hw6_task2": lambda: collections.movies
    .count_documents({"imdb.rating": {"$gt": 8}, "year": {"$gte": 2015, "$lte": 2023}}),
}
