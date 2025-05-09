from MongoDB.collection import collections

queries = {
    # 1. Тестовая коллекция в mongo atlas sample_mflix.theaters
    # Найти все кинотеатры в Калифорнии и посчитать их количество
    "hw5_task1": lambda: collections.theaters
    .count_documents({"location.address.city": "California"}),

    # 2. Тестовая коллекция в mongo atlas sample_airbnb.listingsAndReviews
    # Найти недвижимость с самым большим количеством спален (bedrooms) и напишите ее название
    "hw5_task2": lambda: collections.listingsAndReviews
    .find({}, {"name": 1, "bedrooms": 1})
    .sort({"bedrooms": -1})
    .limit(1),

    # 3. Тестовая коллекция в mongo atlas  sample_airbnb.listingsAndReviews
    # Найти недвижимость с самым высоким рейтингом  review_scores_rating при минимальном количестве отзывов 50 (number_of_reviews) и напишите ее название
    "hw5_task3": lambda: collections.listingsAndReviews
    .aggregate([
        {"$match": {
            "number_of_reviews": {"$gte": 50},
            "review_scores.review_scores_rating": {"$exists": True}
        }},
        {"$sort": {"review_scores.review_scores_rating": -1}},
        {"$limit": 1},
        {"$project": {"_id": 0, "name": 1, "rating": "$review_scores.review_scores_rating"}}
    ])
}
