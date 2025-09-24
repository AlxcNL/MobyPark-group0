#!/usr/bin/env python

# Author: J.A.Boogaard@hr.nl

from fastapi import FastAPI
from fastapi import FastAPI


import uvicorn

app = FastAPI(swagger_ui_parameters={"syntaxHighlight": {"theme": "obsidian"}})

port = 8000

# GET
@app.get("/")
async def helloWorld():
    return { "message" : "hello world" }

@app.get("/component")
async def readComponent(text: str):
    return { "text": text }

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=port)
