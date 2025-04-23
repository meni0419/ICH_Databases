from MongoDB.collection import collections
from MongoDB.Practice.pr47_script import user_data

queries = {
    "pr47_task1": lambda: collections["010724_Max"].count_documents({}),

    "pr47_task2": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="091224_users_Max"
    ).insert_many(user_data),

    "pr47_task3": lambda: collections["091224_users_Max"].count_documents({}),
}