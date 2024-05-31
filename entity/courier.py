class Courier:
    tracking_number_counter = 1000

    def __init__(self, courier_id, sender_name, sender_address, receiver_name, receiver_address, weight, status, delivery_date, user_id):
        self.courier_id = courier_id
        self.sender_name = sender_name
        self.sender_address = sender_address
        self.receiver_name = receiver_name
        self.receiver_address = receiver_address
        self.weight = weight
        self.status = status
        self.tracking_number = Courier.tracking_number_counter
        self.delivery_date = delivery_date
        self.user_id = user_id
        Courier.tracking_number_counter += 1

    def __str__(self):
        return f"Courier({self.courier_id}, {self.sender_name}, {self.receiver_name}, {self.weight}, {self.status}, {self.tracking_number}, {self.delivery_date})"
