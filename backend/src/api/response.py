from fastapi import APIRouter, BackgroundTasks, HTTPException
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
import os
from dotenv import load_dotenv

load_dotenv()

llm = ChatGoogleGenerativeAI(
    model='gemini-2.5-flash',
    temperature=0.5,
    max_retries=3
)

prompt = ChatPromptTemplate.from_messages([
    ("system", "You are a helpful assistant. Reply in paragraphs format only."),
    ("user", "{user_input}")
])

chain = prompt | llm


router = APIRouter(tags=["assistant"], prefix="/assistant")

@router.post('/response')
async def response(user_input : str) :
    try:
        response = await chain.ainvoke({"user_input": user_input})
        
        # response is an AIMessage object. We extract the string content.
        return {"result": response.content}
    except HTTPException :
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

