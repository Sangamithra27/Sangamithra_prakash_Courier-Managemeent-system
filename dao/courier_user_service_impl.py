# dao/courier_user_service_impl.py

import sqlite3
from dao.icourier_user_service import ICourierUserService
from exceptions.tracking_number_not_found_exception import TrackingNumberNotFoundException

class CourierUserServiceImpl(ICourierUserService):
    def __init__(self, db_connection):
        self.db_connection = db_connection

    def place_order(self, courier_obj):
        query = """
        INSERT INTO couriers (courierid, sendername, senderaddress, receivername, receiveraddress, weight, status, trackingnumber, deliverydate, userid)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor = self.db_connection.cursor()
        cursor.execute(query, (
            courier_obj.get_courier_id(),
            courier_obj.get_sender_name(),
            courier_obj.get_sender_address(),
            courier_obj.get_receiver_name(),
            courier_obj.get_receiver_address(),
            courier_obj.get_weight(),
            courier_obj.get_status(),
            courier_obj.get_tracking_number(),
            courier_obj.get_delivery_date(),
            courier_obj.get_user_id()
        ))
        self.db_connection.commit()
        print("Order placed successfully.")

    def get_order_status(self, tracking_number):
        query = "SELECT status FROM couriers WHERE tracking_number =  %s"
        cursor = self.db_connection.cursor()
        cursor.execute(query, (tracking_number,))
        result = cursor.fetchone()
        if result:
            return result[0]
        else:
            raise TrackingNumberNotFoundException(f"Tracking number {tracking_number} not found.")

    def cancel_order(self, tracking_number):
        query = "UPDATE couriers SET status = 'Cancelled' WHERE tracking_number =  %s"
        cursor = self.db_connection.cursor()
        cursor.execute(query, (tracking_number,))
        if cursor.rowcount == 0:
            raise TrackingNumberNotFoundException(f"Tracking number {tracking_number} not found.")
        self.db_connection.commit()
        print("Order cancelled successfully.")

    def get_assigned_order(self, courier_staff_id):
        query = "SELECT * FROM couriers WHERE assigned_staff_id =  %s"
        cursor = self.db_connection.cursor()
        cursor.execute(query, (courier_staff_id,))
        result = cursor.fetchall()
        return result
