import pyttsx3

# Initialize once at the module level so it stays in memory
engine = pyttsx3.init()
engine.setProperty('rate', 100)

def say(text: str):
    engine.say(text)
    engine.runAndWait()

