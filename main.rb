require 'dxruby'
require_relative "reset"

Window.width = 1920
Window.height = 1200
Window.windowed = false

#バーの定義
raight_bar = Sprite.new(1900, 550, Image.new(20, 100, C_RED))
left_bar = Sprite.new(0, 550, Image.new(20, 100, C_BLUE))
bar_cpu_y = 0

#ボールの定義
ball = Sprite.new( 960, 600, Image.new( 20, 20).circle_fill( 10, 10, 10, C_WHITE))
ball_count = 0
ball_rand_dx = 0
ball_rand_dy = 0
ball_rand_dx_count = 0
ball_rand_dy_count = 0
dx = 6
dy = 6


#壁の定義
walls = [Sprite.new(0, 0, Image.new(1920, 20, C_WHITE)),
        Sprite.new(0, 1180, Image.new(1920, 20, C_WHITE)),
        raight_bar,
        left_bar]

#得点管理
raight_player_point = 0
left_player_point = 0
# raight_player_

#ゲーム管理
game_start = true
game_cpu = false
game_cpu_level = false
game_vs = false

#音楽管理
walls_col = Sound.new("bgm/walls_col.wav")
lose = Sound.new("bgm/lose.wav")
bar_col = Sound.new("bgm/bar_col.wav")

Window.loop do

    if game_start
        Window.draw_font(500, 300, "モード選択\n\n1.VS CPU\n2.VS player", Font.default)
        if Input.key_push?(K_1)
            game_cpu_level = true
            game_start = false
        end
        if Input.key_push?(K_2)
            game_vs = true
            game_start = false
        end
    elsif raight_player_point == 5
        Window.draw_font(500, 300, "右側の赤いバーのプレイヤーの勝利！！\nエンターおしてもう一回！", Font.default)
        if Input.key_push?(K_RETURN)
            raight_player_point = 0
            left_player_point = 0
            game_start = true
            game_cpu = false
            game_vs = false
            ball_count = 0
            ball.x = 640
            ball.y = 360
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

        end
        break if Input.key_push?(K_ESCAPE)
    elsif left_player_point == 5
        Window.draw_font(500, 300, "左側の青いバーのプレイヤーの勝利！！\nエンターおしてもう一回！", Font.default)
        if Input.key_push?(K_RETURN)
            raight_player_point = 0
            left_player_point = 0
            game_start = true
            game_cpu = false
            game_vs = false
            ball_count = 0
            ball.x = 640
            ball.y = 360
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
        end
        break if Input.key_push?(K_ESCAPE)
    elsif game_cpu_level
        Window.draw_font(500, 300, "モード選択\n\n1.弱い\n2.普通\n3.強い", Font.default)
        if Input.key_push?(K_1)
            bar_cpu_y = 5.5
            game_cpu = true
            game_cpu_level = false
        end
        if Input.key_push?(K_2)
            bar_cpu_y = 7
            game_cpu = true
            game_cpu_level = false
        end
        if Input.key_push?(K_3)
            bar_cpu_y = 10
            game_cpu = true
            game_cpu_level = false
        end
    elsif game_cpu
        Sprite.draw(walls)
        Sprite.draw(ball)
        Window.draw_font(100, 40, "#{left_player_point}点", Font.default)
        Window.draw_font(1800, 40, "#{raight_player_point}点", Font.default)

        #移動判定
        if Input.key_down?(K_O)
            raight_bar.y -= 10
        end
        if Input.key_down?(K_L)
            raight_bar.y += 10
        end
        #CPUの動作
        if left_bar.y < ball.y
            left_bar.y += bar_cpu_y
        end
        if left_bar.y > ball.y
            left_bar.y -= bar_cpu_y
        end

        #バーの移動制限
        if raight_bar.y < 20
            raight_bar.y = 20
        end
        if raight_bar.y > 1080
            raight_bar.y = 1080
        end
        if left_bar.y < 20
            left_bar.y = 20
        end
        if left_bar.y > 1080
            left_bar.y = 1080
        end

        #ボールの挙動
        ball.x += dx
        if ball === walls
            ball.x -= dx
            dx = -dx
            walls_col.play
        end
        ball.y += dy
        if ball === walls
            ball.y -= dy
            dy = -dy
            walls_col.play
        end

        #ボールの速度を上げる
        ball_count += 1
        if ball_count == 300
            if dx < 0
                dx -= 4
            end
            if dx > 0
                dx += 4
            end
            ball_count = 0
        end

        #得点
        if ball.x < 0
            raight_player_point += 1
            ball_count = 0
            ball.x = 960
            ball.y = 600
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
            lose.play
        end
        if ball.x > 1920 
            left_player_point += 1
            ball_count = 0
            ball.x = 960
            ball.y = 600
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
            lose.play
        end
        break if Input.key_push?(K_ESCAPE)

    elsif game_vs

        Sprite.draw(walls)
        Sprite.draw(ball)
        Window.draw_font(100, 40, "#{left_player_point}点", Font.default)
        Window.draw_font(1180, 40, "#{raight_player_point}点", Font.default)

        #移動判定
        if Input.key_down?(K_O)
            raight_bar.y -= 10
        end
        if Input.key_down?(K_L)
            raight_bar.y += 10
        end
        # if Input.key_down?(K_K)
        #     if raight_bar.x > 1800
        #         raight_bar.x -= 20
        #     end
        # else
        #     raight_bar.x = 1900 
        # end
        

        if Input.key_down?(K_W)
            left_bar.y -= 10
        end
        if Input.key_down?(K_S)
            left_bar.y += 10
        end

        #バーの壁判定
        if raight_bar.y < 20
            raight_bar.y = 20
        end
        if raight_bar.y > 1080
            raight_bar.y = 1080
        end
        if left_bar.y < 20
            left_bar.y = 20
        end
        if left_bar.y > 1080
            left_bar.y = 1080
        end

        #ボールの挙動
        ball.x += dx
        if ball === walls
            ball.x -= dx
            dx = -dx
            walls_col.play
        end
        ball.y += dy
        if ball === walls
            ball.y -= dy
            dy = -dy
            walls_col.play
        end

        #ボールの速度を上げる
        ball_count += 1
        if ball_count == 300
            if dx < 0
                dx -= 4
            end
            if dx > 0
                dx += 4
            end
            ball_count = 0
        end

        #得点
        if ball.x < 0
            raight_player_point += 1
            ball_count = 0
            ball.x = 960
            ball.y = 600
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
            lose.play
        end
        if ball.x > 1920 
            left_player_point += 1
            ball_count = 0
            ball.x = 960
            ball.y = 600
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
            lose.play
        end
    end
    break if Input.key_push?(K_ESCAPE)
end