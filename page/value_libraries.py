import re
import datetime

def parse_value_to_float(parse_value):
    
    try:
        # Try to convert the input to a float.
        cleaned_str = re.sub(r'[^\d.]', '', parse_value)  # Remove letters and commas
        return float(cleaned_str)
    except ValueError as e:
        # If the conversion fails (invalid format), return a descriptive error message.
        return f"Error"

# Function to add two values, with error handling.
def add_values(value_1, value_2):
    try:
        cleaned_str_1 = re.sub(r'[^\d.]', '', value_1)  # Remove letters and commas
        cleaned_str_2 = re.sub(r'[^\d.]', '', value_2)  # Remove letters and commas
        # Try to convert both values to floats and add them.
        return float(cleaned_str_1) + float(cleaned_str_2)
    except ValueError as e:
        # If either value cannot be converted to a float, return an error message.
        return f"Error"

# Function to subtract one value from another, with error handling.
def subtract_values(value_1, value_2):
    try:
        cleaned_str_1 = re.sub(r'[^\d.]', '', value_1)  # Remove letters and commas
        cleaned_str_2 = re.sub(r'[^\d.]', '', value_2)  # Remove letters and commas
        # Try to convert both values to floats and add them.
        return float(cleaned_str_1) - float(cleaned_str_2)
    except ValueError as e:
        # If either value cannot be converted to a float, return an error message.
        return f"Error"
    
def add_current_date_to_name(pre_name):
    # Get the current date and format it as day-month-year
    return f"{pre_name}-{datetime.datetime.now().strftime("%d-%m-%Y")}"