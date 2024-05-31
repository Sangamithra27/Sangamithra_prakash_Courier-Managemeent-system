class Payment:
    def __init__(self, payment_id, courier_id, amount, payment_date):
        self.payment_id = payment_id
        self.courier_id = courier_id
        self.amount = amount
        self.payment_date = payment_date

    def __str__(self):
        return f"Payment({self.payment_id}, {self.courier_id}, {self.amount}, {self.payment_date})"
