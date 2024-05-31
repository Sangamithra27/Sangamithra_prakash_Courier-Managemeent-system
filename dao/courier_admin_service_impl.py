from dao.courier_user_service_impl import CourierUserServiceImpl
from dao.icourier_admin_service import ICourierAdminService
from exceptions.invalid_employee_id_exception import InvalidEmployeeIdException

class CourierAdminServiceImpl(CourierUserServiceImpl, ICourierAdminService):
    def add_courier_staff(self, employee_obj):
        query = """
        INSERT INTO employees (employee_id, employee_name, email, contact_number, role, salary)
        VALUES (?, ?, ?, ?, ?, ?)
        """
        cursor = self.db_connection.cursor()
        cursor.execute(query, (
            employee_obj.get_employee_id(),
            employee_obj.get_employee_name(),
            employee_obj.get_email(),
            employee_obj.get_contact_number(),
            employee_obj.get_role(),
            employee_obj.get_salary()
        ))
        self.db_connection.commit()
        print("Courier staff added successfully.")
