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
        
        while True:
            if np.floor(x_start) != np.floor(x_finish):
                x_start += np.sign(x_finish - x_start)
            
            if np.floor(y_start) != np.floor(y_finish):
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
            sent = publisher.publish(topic_path, bytestring_message)
            sent.result()
            
            if  np.floor(x_start)== np.floor(x_finish) and  np.floor(y_start)== np.floor(y_finish):
                break
                
generate_travel_loc([1001], "playground-s-11-dafce21a", "travel_loc")
