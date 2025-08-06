import sys

import requests


MENDER_SERVER_URI = "https://update.pianoled.fr"
MENDER_SERVER_USER = "aymericguth@gmail.com"
MENDER_SERVER_PASSWORD = "nqGXvVpxnV6p2knV"

# login
resp = requests.post(
    f"{MENDER_SERVER_URI}/api/management/v1/useradm/auth/login",
    auth=(MENDER_SERVER_USER, MENDER_SERVER_PASSWORD),
    verify=False,
)
assert resp.status_code == 200, f"Failed to login: {resp.text}"
jwt = resp.content.decode("utf8")

if len(sys.argv) != 2:
    raise SystemExit("Expecting 1 argument: macadd")

device_macaddr = sys.argv[1]
url = f"{MENDER_SERVER_URI}/api/management/v2/inventory/filters/search"
body = {
    "page": 1,
    "per_page": 20,
    "filters": [
        {
            "scope": "identity",
            "attribute": "mac",
            "type": "$eq",
            "value": device_macaddr,
        },
        {
            "scope": "identity",
            "attribute": "status",
            "type": "$eq",
            "value": "accepted",
        },
    ],
    "sort": [{"attribute": "mac", "order": "asc", "scope": "identity"}],
    "attributes": [
        {"scope": "identity", "attribute": "status"},
        {"scope": "inventory", "attribute": "artifact_name"},
        {"scope": "inventory", "attribute": "device_type"},
        {"scope": "inventory", "attribute": "rootfs-image.version"},
        {"scope": "monitor", "attribute": "alerts"},
        {"scope": "system", "attribute": "created_ts"},
        {"scope": "system", "attribute": "updated_ts"},
        {"scope": "tags", "attribute": "name"},
        {"scope": "identity", "attribute": "mac"},
        {"attribute": "device_type", "scope": "inventory"},
        {"attribute": "rootfs-image.version", "scope": "inventory"},
        {"attribute": "updated_ts", "scope": "system"},
        {"attribute": "geo-city", "scope": "inventory"},
        {"attribute": "geo-ip", "scope": "inventory"},
    ],
}

resp = requests.post(
    url,
    headers={
        "Authorization": f"Bearer {jwt}",
        "Content-Type": "application/json",
        "Accept": "application/json",
    },
    json=body,
    verify=False,
)
d = resp.json()
assert len(d) == 1, "Unexpected resp: returned more than 1 device"

sys.stdout.writelines(d[0]["id"])
