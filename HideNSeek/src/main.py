# Make an environment object
from time import sleep
import pygame
from src.function.game_classes.environment import Environment

env = Environment()
# Change wall speed to 3 (one step every 3 frames)
env.MOVE_WALL_EVERY = 5

# Initialize some variables
WINDOW = pygame.display.set_mode((env.WINDOW_WIDTH, env.WINDOW_HEIGHT))
clock = pygame.time.Clock()
win = False
winning_score = 100

# Repeat the game until the player win (got a score of winning_score) or quits the game.
while not win:
    score_increased = False
    _ = env.reset()
    pygame.display.set_caption("Game")
    while True:
        clock.tick(27)
        score_increased = env.render(score_increased, WINDOW=WINDOW, human=True)
        if env.game_over:
            break
        if env.found:
            break
    #####################################################
    if env.found:
        env.print_text(WINDOW=WINDOW, text_cords=(env.WINDOW_WIDTH // 2, env.WINDOW_HEIGHT // 2),
                       text=f"Hider Found - Score : {env.score}", color=(255, 0, 0), center=True)
    else:
        env.print_text(WINDOW=WINDOW, text_cords=(env.WINDOW_WIDTH // 2, env.WINDOW_HEIGHT // 2),
                       text=f"Game Over - Score : {env.score}", color=(255, 0, 0), center=True)
    pygame.display.update()
    sleep(2)
######################################################################################
