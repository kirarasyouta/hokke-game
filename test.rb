# p a
# p a[0]
# b = a[0]
# p b
# p a
# p a[0]

# a = [6, -6]

ball_rand_dx_count = rand(0..1)
ball_rand_dy_count = rand(0..1)

if ball_rand_dx_count == 1
    ball_rand_dx = 6
elsif ball_rand_dx_count == 0
    ball_rand_dx = -6
end
if ball_rand_dy_count == 1
    ball_rand_dy = 6
elsif ball_rand_dy_count == 0
    ball_rand_dy = -6
end

dx = ball_rand_dx
dy = ball_rand_dy

puts b