import os
import time
import random

from analyzer import Analyzer
from dotenv import load_dotenv

load_dotenv()

__version__ = "v1.0.0"
print(f"Running version {__version__}")

config_file = os.environ.get('CONFIG_FILE')

with open(config_file, 'r') as config:
    lines = config.readlines()
    interval = int(lines[0].split('=')[1].strip())
    sequence_length = int(lines[1].split('=')[1].strip())

numbers = []
analyzer = Analyzer(numbers)

while True:
    num = random.randint(1, 100)
    analyzer.add_number(num)

    if len(analyzer.array) > sequence_length:
        analyzer.array.pop(0)

    print(f"\nNew number: {num}")
    print(f"Numbers: {analyzer.array}")
    print(f"Even: {analyzer.even_count()} "
          f" Odd: {analyzer.odd_count()} "
          f" Increasing pairs: {analyzer.increasing_pairs()} "
          f" Highest: {analyzer.highest_number()}")

    current_time = time.localtime()
    if len(analyzer.array) >= sequence_length and current_time.tm_sec == 0:
        print("\n Stopping: reached full sequence and full minute.")
        break

    time.sleep(interval)
