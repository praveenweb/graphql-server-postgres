from locust import FastHttpUser, task
import random

query_with_limit_order = "query { carts { id is_complete cart_items_filter(limit: 5, orderBy: \"desc\") { id cart_id quantity } } }"

class Quickstart(FastHttpUser):
    @task
    def benchmark_pk_join_query(self):
        payload = {"query": query_with_limit_order}
        self.client.post("/?test=federation", json=payload)