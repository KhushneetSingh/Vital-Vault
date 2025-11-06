from fastapi import APIRouter
from models.user_model import User
from config.firebase_config import db

router = APIRouter(prefix="/users", tags=["Users"])

@router.post("/")
def create_user(user: User):
    db.collection("users").add(user.dict())
    return {"message": "User created successfully"}

@router.get("/{user_id}")
def get_user(user_id: str):
    user_doc = db.collection("users").document(user_id).get()
    return user_doc.to_dict() if user_doc.exists else {"error": "User not found"}