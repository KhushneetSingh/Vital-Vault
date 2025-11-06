from fastapi import APIRouter, Body
import requests, os

router = APIRouter(prefix="/chat", tags=["AI Chat"])

OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")

@router.post("/")
def chat_with_ai(prompt: dict = Body(...)):
    headers = {
        "Authorization": f"Bearer {OPENROUTER_API_KEY}",
        "Content-Type": "application/json"
    }
    body = {
        "model": "qwen/qwen-2-7b-chat",
        "messages": [{"role": "user", "content": prompt["message"]}]
    }
    response = requests.post("https://openrouter.ai/api/v1/chat/completions", headers=headers, json=body)
    return response.json()