# @version ^0.3.0

# Create a string variable that can store maximum 100 characters
greet: public(String[100])


@external
def __init__():
    self.greet = "Hello World"

def set_name(_n):
    self.greet = _n

def get_name():
    return self.greet