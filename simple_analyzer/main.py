import os
from dotenv import load_dotenv

load_dotenv()

config_file = os.environ.get('CONFIG_FILE')

with open(config_file, 'r') as config:
    lines = config.readlines()
    interval_value = lines[0].split('=')[1].strip()
    sequence_length_value = lines[1].split('=')[1].strip()
    print(interval_value)
    print(sequence_length_value)
