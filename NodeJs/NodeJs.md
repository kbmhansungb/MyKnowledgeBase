# Node.js
* [Node.js](https://nodejs.org/docs/latest/api/synopsis.html)

Node.js는 Chrome V8 JavaScript 엔진을 기반으로 한 오픈 소스, 크로스 플랫폼 JavaScript 런타임 환경입니다. 이를 통해 JavaScript로 서버 측 애플리케이션을 개발할 수 있으며, 웹 브라우저 외부에서도 JavaScript를 사용할 수 있게 해줍니다.

Node.js는 비동기 이벤트 기반의 단일 스레드 아키텍처를 사용하여 높은 성능과 확장성을 제공합니다. 또한 **npm(Node Package Manager)**을 통해 다양한 오픈 소스 라이브러리와 모듈을 쉽게 활용할 수 있어 개발 생산성이 향상됩니다.

즉, Node.js는 JavaScript를 사용하여 서버와 네트워크 애플리케이션을 효율적으로 구축할 수 있게 해주는 플랫폼입니다.

<br>

Create an HTTP Server:
```javascript
// server.mjs
import { createServer } from 'node:http';

const server = createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World!\n');
});

// starts a simple http server locally on port 3000
server.listen(3000, '127.0.0.1', () => {
  console.log('Listening on 127.0.0.1:3000');
});

// run with `node server.mjs`

```