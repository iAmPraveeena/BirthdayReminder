from locust import HttpUser, between, task

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)
    host="https://lx8ssktxx9.execute-api.eu-west-1.amazonaws.com"

    @task
    def about(self):
        self.client.get("/Prod/next-birthday?dateofbirth=1990-10-30&unit=hour")