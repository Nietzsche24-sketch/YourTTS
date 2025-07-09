#!/bin/bash

echo "⚙️  [AutoPatch v2] Scaffolding your custom YourTTS-Lite..."

# Create folders
mkdir -p TTS/{bin,configs,models,trainers,datasets,utils,config}

# 1. Entry Point
cat > TTS/bin/train_tts.py << 'PYEOF'
from TTS.configs.your_tts_config import YourTTSConfig
from TTS.trainers.vits_trainer import VitsTrainer

config = YourTTSConfig()
trainer = VitsTrainer(config)
trainer.fit()
PYEOF

# 2. Trainer
cat > TTS/trainers/vits_trainer.py << 'PYEOF'
class VitsTrainer:
    def __init__(self, config):
        self.config = config

    def fit(self):
        print("🚀 Training started with config:", self.config.__dict__)
PYEOF

# 3. Config
cat > TTS/configs/your_tts_config.py << 'PYEOF'
class YourTTSConfig:
    def __init__(self):
        self.model_name = "yourtts-lite"
        self.batch_size = 8
        self.lr = 0.001
PYEOF

# 4. Dummy dataset (placeholder)
cat > TTS/datasets/dummy_dataset.py << 'PYEOF'
def load_dataset():
    print("📦 Loading dataset...")
PYEOF

# 5. __init__.py everywhere
find TTS -type d -exec touch {}/__init__.py \;

# 6. Minimal setup.py
cat > setup.py << 'PYEOF'
from setuptools import setup, find_packages
setup(
    name='yourtts-full',
    version='0.1',
    packages=find_packages(),
)
PYEOF

# 7. Editable install
pip uninstall yourtts-full -y
pip install -e .

echo "✅ All scaffolds created and installed."

# 8. Launch
echo "🚀 Launching training..."
python3 TTS/bin/train_tts.py
