from pydantic import BaseModel

class User(BaseModel):
    name: str
    email: str
    phone: str = ""
    blood_group: str = ""