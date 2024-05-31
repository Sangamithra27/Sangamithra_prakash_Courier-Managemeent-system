# control_flow_statements.py

def check_order_status(status):
    if status == "Processing":
        return "Your order is being processed."
    elif status == "Delivered":
        return "Your order has been delivered."
    elif status == "Cancelled":
        return "Your order has been cancelled."
    else:
        return "Invalid status."

def categorize_parcel(weight):
    if weight < 1.0:
        return "Light"
    elif weight < 5.0:
        return "Medium"
    else:
        return "Heavy"

def user_authentication(users, username, password):
    for user in users:
        if user['username'] == username and user['password'] == password:
            return True
    return False

def assign_couriers(orders, couriers):
    for order in orders:
        for courier in couriers:
            if courier['available']:
                courier['assigned_order'] = order
                courier['available'] = False
                break
