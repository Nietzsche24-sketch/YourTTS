import os
import json
from types import SimpleNamespace
from TTS.trainers.vits_trainer import VitsTrainer

# Load JSON config and convert to an object
with open("config/your_config.json", "r", encoding="utf-8") as f:
    config_dict = json.load(f)
config = SimpleNamespace(**config_dict)

# Fallback: manually nest tokenizer_config if needed
if "tokenizer_config" not in config_dict:
    config.tokenizer_config = SimpleNamespace(characters=config_dict.get("characters", []))

# Dummy args
args = SimpleNamespace()
args.restore_path = None
args.continue_path = None

# Output directory
output_path = os.path.abspath("training_output")

# Train
import sys
sys.stdout = open("training_output/train.log", "w", encoding="utf-8")
sys.stderr = sys.stdout

if __name__ == "__main__":
    trainer = VitsTrainer(config, args, output_path)
    trainer.fit()
