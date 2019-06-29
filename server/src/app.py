from aiohttp import web

async def get_manifest(request):
    return web.Response(text="I am the server")

def main():
    app = web.Application()
    app.add_routes([web.get('/api/manifest', get_manifest)])
    web.run_app(app, host="0.0.0.0", port=8081)

if __name__ == "__main__":
    main()
