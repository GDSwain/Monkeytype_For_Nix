#!@python@

import http.server
import socket
import socketserver
import sys
import threading
import webbrowser
from pathlib import Path

HOST = "127.0.0.1"
PORT = 8765
URL = f"http://{HOST}:{PORT}"
DIRECTORY = Path("@site@")


def check_port_available():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        try:
            sock.bind((HOST, PORT))
        except OSError:
            print(f"Error: Port {PORT} is already in use.")
            print("Is another instance of Monkeytype already running?")
            sys.exit(1)


def open_browser():
    webbrowser.open(URL)


def main():
    check_port_available()

    handler = lambda *args, **kwargs: http.server.SimpleHTTPRequestHandler(
        *args,
        directory=str(DIRECTORY),
        **kwargs,
    )

    with socketserver.TCPServer((HOST, PORT), handler) as httpd:
        print("Starting Monkeytype...")
        print(f"Serving {URL}")

        threading.Timer(0.5, open_browser).start()

        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print()
            print("Keyboard interrupt received, exiting.")


if __name__ == "__main__":
    main()
