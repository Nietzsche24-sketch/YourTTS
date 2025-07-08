import torch
import torchaudio
import json
from TTS.vits.yourtts import YourTTS
from TTS.configs.shared_configs import YourTTSConfig

# Path setup
wav_path = "wavs/ana-ghadban.wav"
json_path = "emotion_vectors/ana-ghadban.json"
text = ["أنا غضبان"]  # Egyptian Arabic

# Load audio
wav_tensor, sr = torchaudio.load(wav_path)
wav_tensor = wav_tensor.to(torch.float32).to("cpu")

# Load emotion vector
with open(json_path) as f:
    emotion_vec = torch.tensor(json.load(f)).unsqueeze(0).to(torch.float32)

# Load config and model
config = YourTTSConfig()
model = YourTTS(config)
model.to("cpu")

# Forward
output = model(wav_tensor, text, emotion_vec)
output = torch.nn.functional.pad(output, (0, 80000 - output.shape[-1]))
target = torch.zeros_like(output)
loss = torch.nn.functional.mse_loss(output, target)
print("✅ Loss computed successfully:", loss.item())
print("✅ Success: Forward pass with real WAV + emotion vector")

# ===== FINAL PATCH: PADDING + LOSS COMPUTATION =====
output = torch.nn.functional.pad(output, (0, 80000 - output.shape[-1]))
target = torch.zeros_like(output)
loss = torch.nn.functional.mse_loss(output, target)
print("✅ Loss computed successfully:", loss.item())
