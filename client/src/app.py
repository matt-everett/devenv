from aiohttp import web, ClientSession
import asyncio

async def get_manifest(request):
    return web.Response(text="I am the client")

async def contact_server():
    while True:
        try:
            await asyncio.sleep(3)
            async with ClientSession() as session:
                async with session.get('http://server:8081/api/manifest') as resp:
                    print(resp.status)
                    print(await resp.text())

        except Exception:
            print('Arrrrrggggghh!')

def main():
    asyncio_loop = asyncio.get_event_loop()
    asyncio.ensure_future(contact_server(), loop=asyncio_loop)

    app = web.Application()
    app.add_routes([web.get('/api/manifest', get_manifest)])

    web.run_app(app, host="0.0.0.0", port=8082)

if __name__ == "__main__":
    main()
