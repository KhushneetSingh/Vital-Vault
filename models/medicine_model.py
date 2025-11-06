from pydantic import BaseModel
from typing import List, Optional

class Medicine(BaseModel):
    name: str
    dosage: str
    frequency: str
    start_date: str
    end_date: str
    reminders: Optional[List[str]] = []