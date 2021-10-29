"""
A module to get time used.
"""
import time


def time_convert(sec):
    """
    Converts seconds into hours, minutes and seconds
    :param sec: Seconds as a int
    :return: A good formatted time string
    """
    mins = sec // 60
    sec = sec % 60
    hours = mins // 60
    mins = mins % 60
    return "{0:02.0f}:{1:02.0f}:{2:02.0f}".format(int(hours), int(mins), sec)


class Stopwatch:
    """
    A instance of a stopwatch to get the time used in code
    """
    def __init__(self):
        self.start_time = None
        self.end_time = None

    def start(self):
        """
        starts the stopwatch
        :return: self
        """
        self.start_time = time.time()
        return self

    def stop(self):
        """
        Stops the stopwatch
        :return: self
        """
        self.end_time = time.time()
        return self

    def get_time_string(self):
        """
        Returns a pretty sting of the time used
        :return: pretty sting
        """
        if not self.end_time:
            return time_convert(time.time() - self.start_time)
        return time_convert(self.end_time - self.start_time)

    def get_time(self):
        """
        Returns the time used
        :return: time used
        """
        if not self.end_time:
            return time.time() - self.start_time
        return self.end_time - self.start_time
