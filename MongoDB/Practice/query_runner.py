queries = {
    "trips": {
        "query": lambda db: db["trips"]
        .find(
            {},
            {"tripduration": 1,
             "bikeid": 1,
             "_id": 0}
        )
        .sort("tripduration", -1)
        .limit(1),
        "db_name": "sample_data",
        "connection": "ich1"
    },
    "find_taylor": {
        "query": lambda db: db["Spotify_Youtube"]
        .find(
            {"Artist": "Taylor Swift",
             "Danceability": {"$gt": 0.7}
             }
        ),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Отображать только «Title», «Artist» и «Views» для всех песен.
    "find_songs": {
        "query": lambda db: db["Spotify_Youtube"]
        .find(
            {},
            {"_id": 0, "Title": 1, "Artist": 1, "Views": 1}
        )
        .limit(10),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Показать все данные, кроме «Описание», «Url_youtube» и _id
    "find_songs_all": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({},
              {"Description": 0, "Url_youtube": 0, "_id": 0}
              )
        .limit(10),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Список всех песен, отсортированных по 'Stream' в порядке убывания
    "pr2_find_songs_stream": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({})
        .sort("Stream", -1)
        .limit(10),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Сортировать по «Artist» в алфавитном порядке, а затем по «Likes» в порядке убывания
    "pr2_find_songs_Artist_Likes": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({}, {"_id": 0, "Artist": 1, "Likes": 1})
        .sort([("Artist", 1), ("Likes", -1)])
        .limit(100),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Показать 10 самых просматриваемых песен
    "pr2_find_songs_top10": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({},
              {"Album": 1, "Artist": 1, "Track": 1, "_id": 0, "Views": 1})
        .sort("Views", -1)
        .limit(10),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Найдите 5 самых популярных песен "official_video" группы "The Weeknd".
    "pr2_find_songs_top5": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({"Artist": "The Weeknd", "official_video": True},
              {"Album": 1, "A rtist": 1, "Track": 1, "_id": 0, "Likes": 1})
        .sort("Likes", -1)
        .limit(5),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Показывать песни в исполнении «Adele», «Drake» или «Doja Cat»
    "pr2_find_songs_by_artist": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({"Artist": {"$in": ["Adele", "Drake", "Doja Cat"]}},
              {"_id": 0, "Title": 1, "Artist": 1, "Views": 1}),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Найти треки с: «Licensed» установлена на false, Более 5 миллионов просмотров. Показать только «Название», «Исполнитель» и «Просмотры».
    "pr2_find_songs_licensed": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({"Licensed": False, "Views": {"$gt": 5000000}},
              {"_id": 0, "Title": 1, "Artist": 1, "Views": 1, "Licensed": 1}),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Найти песни, в названии которых есть слово «love» (без учета регистра).
    "pr2_find_songs_love": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({"Track": {"$regex": "love", "$options": "i"}},
              {"_id": 0, "Track": 1, "Artist": 1, "Views": 1}),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Найти официальные видео с: "Tempo" от 100 до 130, "Valence" выше 0,6, "official_video" — true. Сортировать по "Валентности" по убыванию.
    "pr2_find_songs_official_video": {
        "query": lambda db: db["Spotify_Youtube"]
        .find({"Tempo": {"$gte": 100, "$lte": 130}, "Valence": {"$gt": 0.6}, "official_video": True},
              {"_id": 0, "Title": 1, "Artist": 1, "Views": 1, "Valence": 1, "Likes": 1, "Official_video": 1,
               "Comments": 1})
        .sort("Valence", -1),
        "db_name": "ich",
        "connection": "ich1"
    },
    # Какой велосипед брали наиболее количество раз
    "pr2_find_bike_most_trips": {
        "query": lambda db: db["trips"]
        .aggregate([
            {"$group":
                 {"_id": "$bikeid",
                  "count": {"$sum": 1}
                  }},
            {"$sort": {"count": -1}},
            {"$limit": 1}
        ]),
        "db_name": "sample_data",
        "connection": "ich1"
    }
}
