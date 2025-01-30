# SSE-based Server and Client for [MCP](https://modelcontextprotocol.io/introduction)
[![smithery badge](https://smithery.ai/badge/@sidharthrajaram/mcp-sse)](https://smithery.ai/server/@sidharthrajaram/mcp-sse)

This demonstrates a working pattern for SSE-based MCP servers and standalone MCP clients that use tools from them. Based on an original discussion [here](https://github.com/modelcontextprotocol/python-sdk/issues/145).

## Usage
**Note**: Make sure to supply `ANTHROPIC_API_KEY` in `.env` or as an environment variable.
```
uv run weather.py

uv run client.py http://0.0.0.0:8080/sse
```
```
Initialized SSE client...
Listing tools...

Connected to server with tools: ['get_alerts', 'get_forecast']

MCP Client Started!
Type your queries or 'quit' to exit.

Query: whats the weather like in Spokane?

I can help you check the weather forecast for Spokane, Washington. I'll use the get_forecast function, but I'll need to use Spokane's latitude and longitude coordinates.

Spokane, WA is located at approximately 47.6587° N, 117.4260° W.
[Calling tool get_forecast with args {'latitude': 47.6587, 'longitude': -117.426}]
Based on the current forecast for Spokane:

Right now it's sunny and cold with a temperature of 37°F and ...
```

## Why?
This means the MCP server can now be some running process that agents (clients) connect to, use, and disconnect from whenever and wherever they want. In other words, an SSE-based server and clients can be decoupled processes (potentially even, on decoupled nodes). This is different and better fits "cloud-native" use-cases compared to the STDIO-based pattern where the client itself spawns the server as a subprocess.

### Installing via Smithery

To install SSE-based Server and Client for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@sidharthrajaram/mcp-sse):

```bash
npx -y @smithery/cli install @sidharthrajaram/mcp-sse --client claude
```

### Server

`weather.py` is a SSE-based MCP server that presents some tools based on the National Weather Service APIs. Adapted from the MCP docs' [example STDIO server implementation.](https://modelcontextprotocol.io/quickstart/server) 

By default, server runs on 0.0.0.0:8080, but is configurable with command line arguments like: 
```
uv run weather.py --host <your host> --port <your port>
```

### Client
`client.py` is a MCP Client that connects to and uses tools from the SSE-based MCP server. Adapted from the MCP docs' [example STDIO client implementation.](https://modelcontextprotocol.io/quickstart/client)

By default, client connects to SSE endpoint provided in the command line argument like: 
```
uv run weather.py http://0.0.0.0:8080/sse
```
