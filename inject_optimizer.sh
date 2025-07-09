#!/bin/bash

# Inject optimizer initialization under output_path line
sed -i '' '/self.output_path = output_path/a\
        import torch\
        self.optimizer = torch.optim.Adam(self.model.parameters(), lr=1e-4)
' TTS/trainers/vits_trainer.py
