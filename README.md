# web-cf-scanner

A lightweight **Cloudflare IP scanner** that probes Cloudflare IP ranges and identifies usable IPs for CDN, proxy, or network testing purposes.

This tool automates scanning Cloudflare IP ranges, testing reachability and basic network behavior, and exporting working IP addresses for further use in routing, tunneling, or performance analysis workflows.

---

## Features

- Scan Cloudflare IPv4 / IPv6 ranges
- Test IP reachability and responsiveness
- Export usable Cloudflare IPs
- Simple and script-friendly
- Suitable for automation and research workflows

---

## Installation

Clone the repository:

```bash
git clone https://github.com/F4RAN/web-cf-scanner.git
cd web-cf-scanner
```

Install dependencies (adjust based on implementation language):

```bash
# Example (Python)
pip install -r requirements.txt

# Example (Node.js)
npm install
```

---

## Usage

Run the scanner with default settings:

```bash
python scanner.py
```

Or specify input and output files:

```bash
python scanner.py -i cloudflare_ips.txt -o results.txt
```

### Common Parameters

| Flag | Description |
|-----|-------------|
| `-i` | Input file containing IP ranges |
| `-o` | Output file for working IPs |
| `-t` | Concurrency / thread count |

---

## Input Format

The input file should contain Cloudflare IP ranges or individual IP addresses, one per line:

```
104.16.0.0/12
172.64.0.0/13
```

Official Cloudflare IP lists:
- https://www.cloudflare.com/ips-v4
- https://www.cloudflare.com/ips-v6

---

## Output

The output file contains a list of IPs that passed scanner checks:

```
104.16.12.34
172.64.88.21
```

---

## Use Cases

- CDN performance testing
- Proxy and tunnel configuration
- Network research and experimentation
- Cloudflare routing validation

---

## Contributing

Contributions are welcome.  
Please open issues or submit pull requests on GitHub.

---

## License

MIT
