"""
Из базы данных ich работаем с коллекцией ich.Spotify_Youtube:

1. Найдите трек с наивысшими показателями  Danceability и Energy.
2. У какого трека (но не compilation) самая большая длительность?
3. В каком одном альбоме самое большее количество треков?
4. Сколько просмотров видео на YouTube у трека с самым высоким количеством прослушиваний на spotify (Stream)?
5. Экспортируйте 20 самых популярных (прослушивания или просмотры) треков по версиям YouTube и spotify и импортируйте в базу ich_edit их с именами top20youtube и top20spotify, и добавьте им свои имена для уникальности.
"""

from MongoDB.collection import collections
import json

queries = {
    # Найдите трек с наивысшими показателями  Danceability и Energy.
    "hw7_task1": lambda: collections.Spotify_Youtube
    .aggregate([
        {"$addFields": {"dance_energy":
                            {"$multiply": ["$Danceability", "$Energy"]}
                        }
        },
        {"$sort": {"dance_energy": -1}},
        {"$limit": 1}
    ]),

    # У какого трека (но не compilation) самая большая длительность?
    "hw7_task2": lambda: collections.Spotify_Youtube
    .find({})
    .sort("duration_ms", -1)
    .limit(1),

    # В каком одном альбоме самое большее количество треков?
    "hw7_task3": lambda: collections.Spotify_Youtube
    .aggregate([
        {"$group": {"_id": "$Album", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 1}
    ]),

    # Сколько просмотров видео на YouTube у трека с самым высоким количеством прослушиваний на spotify (Stream)?
    "hw7_task4": lambda: collections.Spotify_Youtube
    .find({},
          {"_id": 0, "Stream": 1, "Views": 1, "Title": 1})
    .sort("Stream", -1)
    .limit(1),

    # Экспортируйте 20 самых популярных (прослушивания или просмотры) треков по версиям YouTube и spotify и импортируйте в базу ich_edit их с именами top20youtube и top20spotify, и добавьте им свои имена для уникальности.
    "hw7_task5_spotify": lambda: collections.Spotify_Youtube
    .find({},
          {"_id": 0, "Title": 1, "Stream": 1, "Views": 1, "Album": 1, "Artist": 1})
    .sort("Stream", -1)
    .limit(20),

    "hw7_task5_spotify_export": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="top20spotify_max"
    ).insert_many(hw7_data),

    "hw7_task5_youTube": lambda: collections.Spotify_Youtube
    .find({},
          {"_id": 0, "Title": 1, "Views": 1, "Stream": 1, "Album": 1, "Artist": 1})
    .sort("Views", -1)
    .limit(20),

    "hw7_task5_youTube_export": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="top20youtube_max"
    ).insert_many(hw7_data)
}

with open("/home/mm/PycharmProjects/ICH_Databases/result.json", "r") as f:
    hw7_data = json.load(f)
