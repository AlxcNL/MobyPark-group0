#!/usr/bin/env python

from fastapi import FastAPI

import uvicorn

app = FastAPI()

# GET
@app.get("/")
async def helloWorld():
    return { "message" : "hello world" }

# # GET path parameter
# @app.get("/component/{component_id}")
# async def getComponent(component_id: int):
#     return { "component_id" : component_id }

@app.get("/component")
async def readComponent(text: str):    
    return { "text": text }

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
