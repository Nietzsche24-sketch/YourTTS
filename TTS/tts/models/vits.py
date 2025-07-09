import torch.nn as nn

class Vits(nn.Module):
    def __init__(self, config):
        super().__init__()
        self.dummy = nn.Linear(10, 10)  # Mock layer

    def forward(self, *args, **kwargs):
        return {"loss": 100.0}  # Fake loss output
