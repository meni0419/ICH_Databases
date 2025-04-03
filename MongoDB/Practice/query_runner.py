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
    }
}
