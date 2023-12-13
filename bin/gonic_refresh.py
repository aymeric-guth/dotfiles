#!/usr/bin/env python3
import requests
import os


def safe_getenv(identifier: str) -> str:
    val = os.getenv(f"GONIC_{identifier}", default=None)
    if val is None:
        raise TypeError(f"{identifier=} is required")
    return val


if __name__ == "__main__":
    baseurl = safe_getenv("BASEURL")
    user = safe_getenv("USER")
    password = safe_getenv("PASS")

    s = requests.session()
    r = s.get(f"{baseurl}/admin/login")
    r = s.post(
        f"{baseurl}/admin/login_do", data={"username": user, "password": password}
    )
    # incremental scan
    r = s.post(f"{baseurl}/admin/start_scan_inc_do")
    # full scan
    # r = s.post(f"{BASEURL}/admin/start_scan_full_do")
    raise SystemExit()
