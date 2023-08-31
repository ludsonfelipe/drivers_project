import numpy as np
from google.cloud import pubsub_v1
from time import sleep

in_progress = [1001]

def generate_travel_loc(in_progress, project, topic):
    np.random.seed(34)
    
    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project, topic)
    
    for travel in in_progress:
        x_start = np.random.uniform(0, 100)
        y_start = np.random.uniform(0, 100)
        x_finish = np.random.uniform(0, 100)
        y_finish = np.random.uniform(0, 100)
        
        while (round(x_start) != round(x_finish)) or (round(y_start) != round(y_finish)):
            if round(x_start) != round(x_finish):
                if x_start < x_finish:
                    x_start += 1
                else:
                    x_start -= 1
            
            if round(y_start) != round(y_finish):
                if y_start < y_finish:
                    y_start += 1
                else:
                    y_start -= 1
            
            message = {"travel":travel,"actual_pos_x":x_start, "actual_pos_y":y_start, "final_pos_x":x_finish, "final_pos_y":y_finish}
        
generate_travel_loc(in_progress)

import numpy as np
from google.cloud import pubsub_v1
import json

def generate_travel_loc(in_progress, project, topic):
    np.random.seed(34)
    
    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project, topic)
    
    for travel in in_progress:
        x_start = np.random.uniform(0, 100)
        y_start = np.random.uniform(0, 100)
        x_finish = np.random.uniform(0, 100)
        y_finish = np.random.uniform(0, 100)
        
        while round(x_start) != round(x_finish) or round(y_start) != round(y_finish):
            x_start += np.sign(x_finish - x_start)
            y_start += np.sign(y_finish - y_start)
        
        data = {
            'travel': travel,
            'actual_pos_x': x_start,
            'actual_pos_y': y_start,
            'final_pos_x': x_finish,
            'final_pos_y': y_finish
        }

        json_message = json.dumps(data)
        bytestring_message = json_message.encode("utf-8")
        print(bytestring_message)
        sent = publisher.publish(topic_path, bytestring_message)
        sent.result()
                
generate_travel_loc([1001], "playground-s-11-f2dc78d5", "travel_loc")
