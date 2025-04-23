from random import choice, randint

from faker import Faker

fake = Faker()

user_data = []
for i in range(1, 1001):
    user_data.append(
        {
            "id": i,
            "name": fake.name(),
            "age": randint(18, 100),
            "gender": choice(["m", "f"]),
        }
    )