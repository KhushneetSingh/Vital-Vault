from fastapi import FastAPI
from routes import users, records, chat, medicines, sos

app = FastAPI(title="VitalVault Backend", version="1.0.0")

app.include_router(users.router)
app.include_router(records.router)
app.include_router(chat.router)
app.include_router(medicines.router)
app.include_router(sos.router)

@app.get("/")
def home():
    return {"message": "VitalVault Backend API is running"}