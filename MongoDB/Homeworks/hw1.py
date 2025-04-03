queries = {
    # 1. Из коллекции customers выяснить из какого города "Sven Ottlieb"
    "hw1_task1": {
        "query": lambda db: db["customers"].
        find_one({"ContactName": "Sven Ottlieb"},
                 {"_id": 0, "City": 1, "ContactName": 1}),
        "db_name": "ich",
        "connection": "ich1"
    },
    # 2. Из коллекции ich.US_Adult_Income найти возраст самого взрослого человека
    "hw1_task2": {
        "query": lambda db: db["US_Adult_Income"].
        find({},
             {"_id": 0, "age": 1})
        .sort("age", -1)
        .limit(1),
        "db_name": "ich",
        "connection": "ich1"
    },
    # 3. Из 2 задачи выясните, сколько человек имеют такой же возраст
    "hw1_task3": {
        "query": lambda db: db["US_Adult_Income"].count_documents({"age": 90}),
        "db_name": "ich",
        "connection": "ich1"
    },
    "hw1_task3_v2": {
        "query": lambda db: db["US_Adult_Income"].aggregate([
            {"$match": {"age": 90}},
            {"$group": {"_id": None, "count": {"$sum": 1}}},
            {"$project": {"_id": 0, "count": 1}}  # Убираем _id, оставляем count
        ]),
        "db_name": "ich",
        "connection": "ich1"
    },
    # 4. Найти _id ObjectId документа, в котором education " IT-career-hub"
    "hw1_task4": {
        "query": lambda db: db["US_Adult_Income"]
        .find({"education": " IT-career-hub"},
              {"_id": 1}
              ),
        "db_name": "ich",
        "connection": "ich1"
    },
    # 5. Выяснить количество людей в возрасте между 20 и 30 годами
    "hw1_task5": {
        "query": lambda db: db["US_Adult_Income"]
        .count_documents({"age": {"$gte": 20, "$lte": 30}},
                         ),
        "db_name": "ich",
        "connection": "ich1"
    },
}
