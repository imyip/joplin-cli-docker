import { serve } from "https://deno.land/std@0.138.0/http/server.ts";
async function handler(req: Request) {
  const url = new URL(req.url);
  return fetch('http://192.168.1.157:41182/' + url.pathname + '?token=9e4d4ad1c53c40fe655e35b39faaedc4ff50675d96ef189256f7de75268e1a98f42a25f072613d1b73218b85fbadaab281f53a76c54e090e4313e213c8ecb0c2', {
    headers: req.headers, method: req.method, body: req.body
  });
}
await serve(handler);