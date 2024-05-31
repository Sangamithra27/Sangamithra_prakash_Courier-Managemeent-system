class User:
    def __init__(self, user_id, user_name, email, password, contact_number, address):
        self.user_id = user_id
        self.user_name = user_name
        self.email = email
        self.password = password
        self.contact_number = contact_number
        self.address = address

    def __str__(self):
        return f"User({self.user_id}, {self.user_name}, {self.email}, {self.contact_number}, {self.address})"
