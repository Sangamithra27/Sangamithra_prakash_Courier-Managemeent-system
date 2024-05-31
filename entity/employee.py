class Employee:
    def __init__(self, employee_id, employee_name, email, contact_number, role, salary):
        self.employee_id = employee_id
        self.employee_name = employee_name
        self.email = email
        self.contact_number = contact_number
        self.role = role
        self.salary = salary

    def __str__(self):
        return f"Employee({self.employee_id}, {self.employee_name}, {self.email}, {self.contact_number}, {self.role}, {self.salary})"
