from MongoDB.collection import collections

queries = {
    # 1. Тестовая коллекция в mongo atlas sample_mflix.theaters
    # Найти все кинотеатры в Калифорнии и посчитать их количество
    "hw5_task1": lambda: collections.theaters
    .count_documents({"location.address.city": "California"}),

    # 2. Тестовая коллекция в mongo atlas sample_airbnb.listingsAndReviews
    # Найти недвижимость с самым большим количеством спален (bedrooms) и напишите ее название
    "hw5_task2_1": lambda: collections.get_collection_via_connection(
        connection_name="atlas",
        db_name="sample_airbnb",
        collection_name="listingsAndReviews"
    ).insert_many(data),

    "hw5_task2_2": lambda: collections.listingsAndReviews
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

data = [
    {
        "_id": "1",
        "name": "Cozy Studio in Downtown",
        "bedrooms": 1,
        "number_of_reviews": 40,
        "review_scores": {"review_scores_rating": 95}
    },
    {
        "_id": "2",
        "name": "Luxury Villa with Pool",
        "bedrooms": 5,  # Максимум спален (задача 2)
        "number_of_reviews": 50,
        "review_scores": {"review_scores_rating": 98}  # Максимальный рейтинг (задача 3)
    },
    {
        "_id": "3",
        "name": "Modern 4-Bed House",
        "bedrooms": 4,
        "number_of_reviews": 60,
        "review_scores": {"review_scores_rating": 97}
    },
    {
        "_id": "4",
        "name": "City Center Loft",
        "bedrooms": 2,
        "number_of_reviews": 55,
        "review_scores": {"review_scores_rating": 90}
    }
]
