<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
</head>

<body>
  <h1 align="center">WebSeeker 🕵️‍♂️</h1>

  <p align="center">
     <a href="https://tryhackme.com/p/TxVScoobyDoo">
          <img src="https://tryhackme-badges.s3.amazonaws.com/TxVScoobyDoo.png" alt="TryHackMe Profile">
  </p>

  <h2>About WebSeeker</h2>

  <p>🚀 <strong>WebSeeker</strong> is a Bash script designed for directory and file scanning on web servers. It efficiently searches for accessible paths using a provided wordlist.</p>

  <h2>Getting Started</h2>

  <h3>Usage</h3>

  <p>To run WebSeeker, use the following command in the terminal:</p>

  <pre><code>chmod +x webSeeker.sh
./webSeeker.sh [OPTIONS]</code></pre>

  <h4>Options:</h4>

  <table>
      <thead>
          <tr>
              <th>Option</th>
              <th>Description</th>
          </tr>
      </thead>
      <tbody>
          <tr>
              <td><code>-w, --wordlist WORDLIST</code></td>
              <td>Specify the wordlist file for directory and file names.</td>
          </tr>
          <tr>
              <td><code>-u, --url URL</code></td>
              <td>Specify the target URL for scanning.</td>
          </tr>
          <tr>
              <td><code>-a, --user-agent USER_AGENT</code></td>
              <td>Specify the user agent for HTTP requests (default: webSeeker).</td>
          </tr>
          <tr>
              <td><code>-x, --extension EXTENSION</code></td>
              <td>Specify the file extension to filter results (optional).</td>
          </tr>
          <tr>
              <td><code>-o, --output OUTPUT_FILE</code></td>
              <td>Specify the output file for results (optional).</td>
          </tr>
      </tbody>
  </table>

  <h4>Examples:</h4>

  <pre><code>
# Scan with default settings
./webSeeker.sh -w wordlist.txt -u http://example.com

# Scan with custom options
./webSeeker.sh -w wordlist.txt -u http://example.com -a customAgent -x php -o output.txt
</code></pre>

  <h2>Permissions</h2>

  <p>Before running the script, ensure it has execution permissions. Use the following command in the terminal:</p>

  <pre><code>chmod +x webSeeker.sh</code></pre>

</body>

</html>
