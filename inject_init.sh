#!/bin/bash

# Inject __init__ method just after class VitsTrainer:
sed -i '' '/class VitsTrainer/a\
    def __init__(self, config, args, output_path):\
        self.config = config\
        self.args = args\
        self.output_path = output_path
' TTS/trainers/vits_trainer.py
