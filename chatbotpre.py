import tkinter as tk
from tkinter import scrolledtext
import random
import json

# Load health-related dataset (predefined Q&A)
with open(r"c:\PROJECTS\PYTHON\health\health_dataset.json", "r") as file:
    health_data = json.load(file)

def get_response(user_input):
    user_input = user_input.lower()
    responses = []
    for entry in health_data["questions"]:
        if any(keyword in user_input for keyword in entry["keywords"]):
            responses.extend(entry["responses"])
    
    if responses:
        return "\n".join(random.sample(responses, min(3, len(responses))))  # Return up to 3 responses
    else:
        return "I'm sorry, I don't have information on that. Please consult a doctor."

def send_message(event=None):
    user_input = entry_field.get()
    if user_input.strip():
        chat_window.insert(tk.END, "You: " + user_input + "\n", "user")
        response = get_response(user_input)
        chat_window.insert(tk.END, "Bot: " + response + "\n\n", "bot")
        entry_field.delete(0, tk.END)
        chat_window.yview(tk.END)

# GUI Setup
root = tk.Tk()
root.title("Health,io")
root.geometry("900x700")  # Increased default size for better UI
root.state("zoomed")  # Fullscreen mode
root.configure(bg="#1e1e1e")  # Dark background

# Chat Window
chat_window = scrolledtext.ScrolledText(root, wrap=tk.WORD, font=("Barlow Condensed", 18, "bold"), bg="#2d2d2d", fg="#ffffff", padx=15, pady=15)
chat_window.pack(pady=10, padx=10, fill=tk.BOTH, expand=True)
chat_window.tag_configure("user", foreground="#4CAF50", font=("Barlow Condensed", 18, "bold"))
chat_window.tag_configure("bot", foreground="#FFD700", font=("Barlow Condensed", 18, "bold"))

# Entry Field
entry_frame = tk.Frame(root, bg="#1e1e1e")
entry_frame.pack(pady=5, padx=10, fill=tk.X)
entry_field = tk.Entry(entry_frame, font=("Barlow Condensed", 18, "bold"), bg="#3a3a3a", fg="#ffffff", insertbackground="white")
entry_field.pack(side=tk.LEFT, padx=5, pady=10, expand=True, fill=tk.X)
entry_field.bind("<Return>", send_message)

# Send Button
send_button = tk.Button(entry_frame, text="Send", command=send_message, font=("Barlow Condensed", 18, "bold"), bg="#4CAF50", fg="white", padx=15, pady=10)
send_button.pack(side=tk.RIGHT, padx=5, pady=5)

# Keyboard Shortcut for Sending Messages
root.bind("<Return>", send_message)

root.mainloop()
