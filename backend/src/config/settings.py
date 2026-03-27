from pydantic_settings import BaseSettings
import os 
from dotenv import load_dotenv

load_dotenv()

class Setting(BaseSettings):
    project_name : str = os.getenv("project_name")
    project_version : str = os.getenv("project_version")
    project_description : str = os.getenv("project_description")
    project_secret_key : str = os.getenv("project_secret_key")
    debug_mode : bool = False

    class Config:
        my_file='.env'

setting = Setting()