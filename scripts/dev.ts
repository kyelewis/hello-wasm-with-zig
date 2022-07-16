import { join } from "node:path";
import { createServer } from 'vite';

(async() => {

  const server = await createServer({
    configFile: false,
    root: join(__dirname, '../src/web'),
    server: {
      port: 3000
    }
  });

  await server.listen()
  server.printUrls();

})();
