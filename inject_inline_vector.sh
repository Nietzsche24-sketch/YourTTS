TARGET="TTS/trainers/vits_trainer.py"
sed -i '' '/# INLINE_EMOTION_VECTOR_START/,/# INLINE_EMOTION_VECTOR_END/d' "$TARGET"
sed -i '' '/for wav_path, text, speaker_name in batch/d' "$TARGET"

sed -i '' '/for batch in self.train_loader:/a\
        # INLINE_EMOTION_VECTOR_START\n\
        for wav_path, text, speaker_name, vector_path in batch:\n\
            with open(vector_path, "r", encoding="utf-8") as f:\n\
                vec = json.load(f)\n\
            emotion_tensor = torch.tensor(vec, dtype=torch.float32).to(self.device)\n\
            # Feed emotion_tensor into model input here\n\
        # INLINE_EMOTION_VECTOR_END
' "$TARGET"
