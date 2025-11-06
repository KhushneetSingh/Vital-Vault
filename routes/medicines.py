from fastapi import APIRouter
from config.firebase_config import db
from models.medicine_model import Medicine
import uuid

router = APIRouter(prefix="/medicines", tags=["Medicines"])

@router.post("/")
def add_medicine(medicine: Medicine):
    med_id = str(uuid.uuid4())
    db.collection("medicines").document(med_id).set(medicine.dict())
    return {"message": "Medicine added", "id": med_id}

@router.get("/")
def list_medicines():
    meds = db.collection("medicines").stream()
    return [m.to_dict() for m in meds]