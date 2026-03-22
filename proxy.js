const http = require('http');
const httpProxy = require('http-proxy');

const proxy = httpProxy.createProxyServer({
    ws: true,
    selfHandleResponse: false
});

proxy.on('error', function(err, req, res) {
    console.error('Proxy error:', err);
});

proxy.on('proxyReq', function(proxyReq, req, res, options) {
    proxyReq.setHeader('X-User-Email', 'demouser@nextlab.asu.edu');
});

const server = http.createServer((req, res) => {
    proxy.web(req, res, { 
        target: 'http://localhost:3002',
        changeOrigin: true
    });
});

server.on('upgrade', function(req, socket, head) {
    proxy.ws(req, socket, head, {
        target: 'http://localhost:3002'
    });
});

server.listen(3000, () => {
    console.log('Demo proxy running on http://localhost:3000');
    console.log('Forwarding to Open WebUI on http://localhost:3002');
});