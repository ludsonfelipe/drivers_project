import numpy as np
from google.cloud import pubsub_v1
from time import sleep
import os

def generate_user_loc(user_list, seed, topic, project):
    np.random.seed(seed)

    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project, topic)

    for user in user_list:
        sleep(1)
        x_loc = np.random.uniform(0, 100)
        y_loc = np.random.uniform(0, 100)

        message = f"'user':{user},'x_loc': {x_loc}, 'y_loc': {y_loc}"
        future = publisher.publish(topic_path, message.encode("utf-8"))      
        print(f"User {user} location added to topic '{topic}'")

def generate_loc(pending_users, active_drivers):
    project_id = "playground-s-11-dafce21a"
    user_topic = "users_loc"
    driver_topic =  "drivers_loc"
    generate_user_loc(pending_users, seed=1, topic=user_topic, project=project_id)
    generate_user_loc(active_drivers, seed=2, topic=driver_topic, project=project_id)

pending_users = [915, 769, 916, 768, 735, 732, 948, 957, 899, 878, 801, 879, 782, 985, 700, 917, 819, 839, 935]

active_drivers = [2,  3,  6,  9,  10, 11, 12, 13, 15, 16, 17, 18, 19, 22, 23, 24, 25, 26, 29, 30, 32, 33, 36, 37, 39, 40, 41, 42, 43, 44, 47, 48, 50, 52, 53, 54, 59, 61, 64, 69, 70, 71, 73, 75, 77, 78, 87, 91, 92, 95, 97, 98]

generate_loc(pending_users, active_drivers)