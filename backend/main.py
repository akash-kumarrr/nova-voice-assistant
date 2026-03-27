from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from src.config.settings import setting
from src.api import health, response
import uvicorn 

app = FastAPI(
    title=setting.project_name,
    description=setting.project_description,
    version=setting.project_version,
    debug=setting.debug_mode
)

@app.on_event("startup")
async def startup():
    print("Backend is initilized successfully...")
    return {
        "message" : "NOVA ASSISSTANT BACKEND IS INITILIZED SUCCESSFULLY",
        "status" : "running"
    }

@app.on_event("shutdown")
async def shutdown():
    print("system is shutting down succesfully")
    return {
        "message"  : "NOVA ASSISTANT BACKEND IS SHUTDOWN",
        "status" : "shutdown"
    }

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router=health.router)
app.include_router(router=response.router)

@app.get("/")
async def root():
    return {
        "message" : "This is backend of AssetScan",
        "version" : setting.project_version,
        "description" : "AssetScan is a professional utility designed to bridge the gap between physical hardware and digital records using high-speed QR technology.",
        "docs"  : "/docs"
    }

@app.get("/api/info")
async def api_info():
    return {
        'name' : setting.project_name,
        'version' : setting.project_version,
        'description' : setting.project_description,
        'endpoins' : {
            'health' : '/api/health',
            'response' : '/api/response'
        }
    }

if __name__ == '__main__':
    uvicorn.run(app, host='localhost', port=8000)