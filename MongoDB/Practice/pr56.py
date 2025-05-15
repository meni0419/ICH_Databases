from MongoDB.collection import collections

queries = {
    # Найти среднее количество городов в штате
    "pr56_task1": lambda: collections.sample_training
    .aggregate([
        {'$group':
             {'_id': '$state',
              'count_cities': {'$sum': 1}}},
        {'$sort': {'count_cities': -1}},
        {'$limit': 1}
    ]),
}