from util.db_connection import DBConnection
from entity.user import User
from entity.courier import Courier
from entity.employee import Employee
from dao.courier_user_service_impl import CourierUserServiceImpl
from dao.courier_admin_service_impl import CourierAdminServiceImpl
from exceptions.tracking_number_not_found_exception import TrackingNumberNotFoundException
from exceptions.invalid_employee_id_exception import InvalidEmployeeIdException

def main():
    db_connection = DBConnection.get_connection()
    user_service = CourierUserServiceImpl(db_connection)
    admin_service = CourierAdminServiceImpl(db_connection)

    while True:
        print("\nCourier Management System")
        print("1. Place Order")
        print("2. Check Order Status")
        print("3. Cancel Order")
        print("4. Add Courier Staff")
        print("5. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            # Example input for placing an order
            courier = Courier(1, "John Doe", "123 Elm St", "Jane Smith", "456 Oak St", 2.5, "Processing", "2023-06-01", 1)
            user_service.place_order(courier)
        elif choice == '2':
            tracking_number = input("Enter tracking number: ")
            try:
                status = user_service.get_order_status(tracking_number)
                print(f"Order status: {status}")
            except TrackingNumberNotFoundException as e:
                print(e)
        elif choice == '3':
            tracking_number = input("Enter tracking number to cancel: ")
            try:
                user_service.cancel_order(tracking_number)
            except TrackingNumberNotFoundException as e:
                print(e)
        elif choice == '4':
            # Example input for adding a courier staff
            employee = Employee(1, "Alice Brown", "alice@example.com", "555-1234", "Courier", 50000)
            admin_service.add_courier_staff(employee)
        elif choice == '5':
            break
        else:
            print("Invalid choice, please try again.")

if __name__ == "__main__":
    main()
