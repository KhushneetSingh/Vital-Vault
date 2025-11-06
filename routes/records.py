from fastapi import APIRouter, UploadFile, File, Form
from config.firebase_config import db
import uuid, time

router = APIRouter(prefix="/records", tags=["Health Records"])

@router.post("/")
async def upload_record(user_id: str = Form(...), file: UploadFile = File(...)):
    record_id = str(uuid.uuid4())
    db.collection("users").document(user_id).collection("records").document(record_id).set({
        "record_id": record_id,
        "filename": file.filename,
        "uploaded_at": time.time()
    })
    return {"message": "Record uploaded", "record_id": record_id}

@router.get("/{user_id}")
def list_records(user_id: str):
    records = db.collection("users").document(user_id).collection("records").stream()
    return [r.to_dict() for r in records]