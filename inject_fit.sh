#!/bin/bash

# Delete any existing fit() block
sed -i '' '/^    def fit(self):/,/^    def /{d;}' TTS/trainers/vits_trainer.py

# Inject properly spaced Python code under class
sed -i '' '/class VitsTrainer/a\
    def fit(self):\
        for _ in range(3):\
            print("🔥 Starting REAL VitsTrainer training loop...")\
            self.optimizer.zero_grad()\
            output = self.model(wav_tensor, tokenizer, emotion_vec)\
            loss = torch.nn.functional.mse_loss(output, wav_tensor)\
            loss.backward()\
            self.optimizer.step()\
            print(f"<0001f9e0> Loss: {loss.item():.5f}")\
            self.save_checkpoint()\
            print("✅ Epoch done.")
' TTS/trainers/vits_trainer.py
