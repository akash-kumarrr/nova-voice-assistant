from fastapi import HTTPException, APIRouter
from datetime import datetime

router = APIRouter(prefix='/health', tags=['health'])

router.get('/status')
async def health_status():
    try :
        return {
            'system' : 'Nova : Basic Responsive Voice Assistant',
            'status' : 'healthy',
            'checked at' : str(datetime.datetime)
        }
    except HTTPException:
        raise
    except Exception as e:
        return HTTPException(status_code=500, detail=f'Internal Server Error : {str(e)}')

