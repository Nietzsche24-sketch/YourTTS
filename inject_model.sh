#!/bin/bash

# Inject model initialization under self.output_path
sed -i '' '/self.output_path = output_path/a\
        from TTS.utils.dummy import Vits\
        self.model = Vits(self.config)
' TTS/trainers/vits_trainer.py
