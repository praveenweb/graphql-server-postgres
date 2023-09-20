from locust import HttpLocust, TaskSet, task

class UserBehavior(TaskSet):
    @task(1)
    def index(self):
        query = '''query {
        carts {
            id
            is_complete
            cart_items_filter(limit: 4, orderBy: "desc") {
            id
            cart_id
            quantity
            }
        }
        }'''
        result = self.client.execute("cart", query)

class WebsiteUser(GraphQLLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000

