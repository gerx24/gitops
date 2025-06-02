import requests
import json

# ---- CONFIGURATION ----
ZONE_ID = 'xxxxxxxxxxxxxx'
RECORD_ID = 'xxxxxxxxxxxxxxx'
API_TOKEN = 'xxxxxxxxxxxxxxxxxx'
RECORD_NAME = 'homelab.gersonplace.com'
RECORD_TYPE = 'A'  # 'A' for IPv4
TTL = 300  # Time to live (seconds)
PROXIED = False  # True if you want to use Cloudflare proxy
# ------------------------

def get_public_ip():
    return requests.get('https://api.ipify.org').text.strip()

def get_dns_record_ip():
    url = f'https://api.cloudflare.com/client/v4/zones/{ZONE_ID}/dns_records/{RECORD_ID}'
    headers = {'Authorization': f'Bearer {API_TOKEN}', 'Content-Type': 'application/json'}
    response = requests.get(url, headers=headers)
    return response.json()['result']['content']

def update_dns_record(new_ip):
    url = f'https://api.cloudflare.com/client/v4/zones/{ZONE_ID}/dns_records/{RECORD_ID}'
    headers = {'Authorization': f'Bearer {API_TOKEN}', 'Content-Type': 'application/json'}
    data = {
        'type': RECORD_TYPE,
        'name': RECORD_NAME,
        'content': new_ip,
        'ttl': TTL,
        'proxied': PROXIED
    }
    response = requests.put(url, headers=headers, json=data)
    return response.json()

def main():
    current_ip = get_public_ip()
    dns_ip = get_dns_record_ip()

    if current_ip != dns_ip:
        print(f'Updating DNS record from {dns_ip} to {current_ip}')
        result = update_dns_record(current_ip)
        print(json.dumps(result, indent=2))
    else:
        print('IP has not changed. No update needed.')

if __name__ == "__main__":
    main()

