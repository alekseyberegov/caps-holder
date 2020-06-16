import sys
import traceback
import urllib
import requests
from urllib3.exceptions import InsecureRequestWarning


class Stub(object):
    def __init__(self, endpoint):
        self.endpoint = endpoint
        requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

    def send(self, url):
        req = {'url': url, 'debug': True}

        try:
            res = requests.post(self.endpoint, json=req, timeout=1, verify=False)
            payload = res.content.decode('utf-8')
        except requests.exceptions.SSLError as error:
            payload = self.create_error_response()

        return payload

    @staticmethod
    def create_error_response():
        exc_type, exc_value, exc_traceback = sys.exc_info()
        res: str = repr(traceback.format_exception(exc_type, exc_value, exc_traceback))
        res = '{"status": "error", "stacktrace" : "%s"}' % urllib.parse.quote(res)
        return res
