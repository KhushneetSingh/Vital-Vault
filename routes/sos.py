from fastapi import APIRouter, Body

router = APIRouter(prefix="/sos", tags=["Emergency"])

@router.post("/")
def trigger_sos(data: dict = Body(...)):
    # later integrate Twilio / SMS API
    return {"status": "SOS sent", "location": data.get("location")}