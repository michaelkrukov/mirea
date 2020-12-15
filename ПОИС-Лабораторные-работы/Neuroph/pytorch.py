import itertools
import torch


# Data for bitwise OR
xx = torch.tensor([
    [0., 0.],
    [1., 0.],
    [0., 1.],
    [1., 1.],
])

yy = torch.tensor([
    [0.],
    [1.],
    [1.],
    [1.]
])

# Network description
layers = [2, 4, 3, 1]
loss_fn = torch.nn.MSELoss(reduction='sum')
learning_rate = 1e-3

# Build a feed-forward network
network = []

for i in range(1, len(layers)):
    network.append(torch.nn.Linear(layers[i - 1], layers[i]))

# Create model
model = torch.nn.Sequential(*network)

# Print model
print(model)

# Fit model
for t in range(5000):
    y_pred = model(xx)

    loss = loss_fn(y_pred, yy)

    if t % 500 == 499:
        print(t, loss.item())

    model.zero_grad()

    loss.backward()

    with torch.no_grad():
        for param in model.parameters():
            param -= learning_rate * param.grad

# Test model
print('[0, 0]', '->', model(torch.tensor([[0., 0.]])).detach().numpy()[0][0])
print('[1, 0]', '->', model(torch.tensor([[1., 0.]])).detach().numpy()[0][0])
print('[0, 1]', '->', model(torch.tensor([[0., 1.]])).detach().numpy()[0][0])
print('[1, 1]', '->', model(torch.tensor([[1., 1.]])).detach().numpy()[0][0])
