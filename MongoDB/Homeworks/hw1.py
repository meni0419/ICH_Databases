from MongoDB.collection import collections

queries = {
    # 1. Из коллекции customers выяснить из какого города "Sven Ottlieb"
    "hw1_task1": lambda: collections.customers
    .find({"ContactName": "Sven Ottlieb"},
          {"_id": 0, "City": 1, "ContactName": 1}),

    # 2. Из коллекции ich.US_Adult_Income найти возраст самого взрослого человека 
    "hw1_task2": lambda: collections.US_Adult_Income
    .find({},
          {"_id": 0, "age": 1})
    .sort("age", -1)
    .limit(1),

    # 3. Из 2 задачи выясните, сколько человек имеют такой же возраст
    "hw1_task3": lambda: collections.US_Adult_Income.count_documents({"age": 90}),

    "hw1_task3_v2": lambda: collections.US_Adult_Income
    .aggregate([
        {"$match": {"age": 90}},
        {"$group": {"_id": None, "count": {"$sum": 1}}},
        {"$project": {"_id": 0, "count": 1}}
    ]),

    # 4. Найти _id ObjectId документа, в котором education " IT-career-hub"
    "hw1_task4": lambda: collections.US_Adult_Income.find_one(
        {"education": " IT-career-hub"},
        {"_id": 1}
    ),

    # 5. Выяснить количество людей в возрасте между 20 и 30 годами
    "hw1_task5": lambda: collections.US_Adult_Income
    .count_documents({"age": {"$gte": 20, "$lte": 30}})
}
