from MongoDB.collection import collections

queries = {
    "pr56_task1": lambda: collections.UK_used_cars
    .find_one({}),

    # Выберите документы, в которых общественный транспорт был быстрее автомобиля.
    "pr56_task2": lambda: collections.bookings
    .count_documents({
        "$expr": {
            "$lt": ["$public_transport.duration", "$driving.duration"]
        }
    }),

    # add fields
    "pr56_task3": lambda: collections.bookings
    .aggregate([
    {
        '$addFields': {
            'total_distance': {
                '$add': [
                    '$driving.distance', '$walking.distance', '$public_transport.distance'
                ]
            },
            'avg_distance': {
                '$avg': [
                    '$driving.distance', '$walking.distance', '$public_transport.distance'
                ]
            }
        }
    },
        {"$limit": 10}
])
}
