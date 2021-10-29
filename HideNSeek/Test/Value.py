import time

from src.function.util.stopwatch import Stopwatch

stopwatch = Stopwatch()
stopwatch.start()

time.sleep(1)
print(stopwatch.get_time() > 1)