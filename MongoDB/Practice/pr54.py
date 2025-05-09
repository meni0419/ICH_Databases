from MongoDB.collection import collections

queries = {
    # Найти среднее количество городов в штате
    "pr54_task1": lambda: collections.sample_training
    .aggregate([
        {'$group':
             {'_id': '$state',
              'count_cities': {'$sum': 1}}},
        {'$sort': {'count_cities': -1}},
        {'$limit': 1}
    ]),

    # 6. Добавить новое поле Credit_Usage_Rate, которое рассчитывается как Total_Revolving_Bal / Credit_Limit, и отсортировать клиентов по этому полю по убыванию.
    "pr54_task6": lambda: collections.BankChurners
    .aggregate([
        {"$addFields": {"Credit_Usage_Rate": {"$divide": ["$Total_Revolving_Bal", "$Credit_Limit"]}}},
        {"$sort": {"Credit_Usage_Rate": -1}},
        {"$limit": 10},
    ]),

    # 7. Группировать клиентов по полям Gender и Dependent_count и посчитать среднее значение Total_Trans_Amt.
    "pr54_task7": lambda: collections.BankChurners
    .aggregate([
        {"$group": {"_id": {"Gender": "$Gender", "Dependent_count": "$Dependent_count"},
                    "Total_Trans_Amt": {"$avg": "$Total_Trans_Amt"}}},
    ]),

    # 8. Группировать клиентов по Attrition_Flag и посчитать среднее значение Months_Inactive_12_mon и Contacts_Count_12_mon в каждой группе.
    "pr54_task8": lambda: collections.BankChurners
    .aggregate([
        {"$group": {"_id": "$Attrition_Flag",
         "avg_mi_12m": {"$avg": "$Months_Inactive_12_mon"},
         "avg_cc_12m": {"$avg": "$Contacts_Count_12_mon"}}},
        {"$project": {"avg_mi_12m": {"$round": ["$avg_mi_12m", 2]},"avg_cc_12m": {"$round": ["$avg_cc_12m", 2]}}},
    ]),

    # 9. Найти значение Card_Category, которое встречается чаще всего среди всех клиентов.

}
