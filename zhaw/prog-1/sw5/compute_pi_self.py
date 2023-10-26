floating_points = 300000
series = [1]
walker = 3
positive = False

iteration = range(3, floating_points, 2)

# Gregory-Leibniz Series
for i in iteration:
    if positive:
        series.append(1/i)
    else:
        series.append(-1/i)
    positive = not positive

pi_approx = 4 * sum(series)
print(round(pi_approx, 5))
