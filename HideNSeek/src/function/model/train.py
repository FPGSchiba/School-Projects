import pandas as pd
import time

import pygame
from tqdm import tqdm
import numpy as np
from random import choice

from src.function.game_classes.environment import Environment
from src.function.model.agent import save_model_and_weights, DQNAgent, PATH

TstartTime = time.time()

DISCOUNT = 0.99
REPLAY_MEMORY_SIZE = 3_000  # How many last steps to keep for model training
MIN_REPLAY_MEMORY_SIZE = 1_000  # Minimum number of steps in a memory to start training
UPDATE_TARGET_EVERY = 20  # Terminal states (end of episodes)
MIN_REWARD = 1000  # For model save
SAVE_MODEL_EVERY = 100  # Episodes
SHOW_EVERY = 1  # Episodes
EPISODES = 9999999999  # Number of episodes
#  Stats settings
AGGREGATE_STATS_EVERY = 20  # episodes
SHOW_PREVIEW = True
HUMAN = True
######################################################################################
# Models Arch :
# [{[conv_list], [dense_list], [util_list], MINIBATCH_SIZE, {EF_Settings}, {ECC_Settings}} ]

models_arch = [{"conv_list": [32], "dense_list": [32, 32], "util_list": ["ECC2", "1A-4Ac"],
                "MINIBATCH_SIZE": 128, "best_only": False,
                "EF_Settings": {"EF_Enabled": False}, "ECC_Settings": {"ECC_Enabled": False}},

               {"conv_list": [32], "dense_list": [32, 32, 32], "util_list": ["ECC2", "1A-4Ac"],
                "MINIBATCH_SIZE": 128, "best_only": False,
                "EF_Settings": {"EF_Enabled": False}, "ECC_Settings": {"ECC_Enabled": False}},

               {"conv_list": [32], "dense_list": [32, 32], "util_list": ["ECC2", "1A-4Ac"],
                "MINIBATCH_SIZE": 128, "best_only": False,
                "EF_Settings": {"EF_Enabled": True, "FLUCTUATIONS": 2},
                "ECC_Settings": {"ECC_Enabled": True, "MAX_EPS_NO_INC": int(EPISODES * 0.2)}}]

# A dataframe used to store grid search results
res = pd.DataFrame(columns=["Model Name", "Convolution Layers", "Dense Layers", "Batch Size", "ECC", "EF",
                            "Best Only", "Average Reward", "Best Average", "Epsilon 4 Best Average",
                            "Best Average On", "Max Reward", "Epsilon 4 Max Reward", "Max Reward On",
                            "Total Training Time (min)", "Time Per Episode (sec)"])
######################################################################################
# Grid Search:
for i, m in enumerate(models_arch):
    startTime = time.time()  # Used to count episode training time
    MINIBATCH_SIZE = m["MINIBATCH_SIZE"]

    # Exploration settings :
    # Epsilon Fluctuation (EF):
    EF_Enabled = m["EF_Settings"]["EF_Enabled"]  # Enable Epsilon Fluctuation
    MAX_EPSILON = 1  # Maximum epsilon value
    MIN_EPSILON = 0.001  # Minimum epsilon value
    if EF_Enabled:
        FLUCTUATIONS = m["EF_Settings"]["FLUCTUATIONS"]  # How many times epsilon will fluctuate
        FLUCTUATE_EVERY = int(EPISODES / FLUCTUATIONS)  # Episodes
        EPSILON_DECAY = MAX_EPSILON - (MAX_EPSILON / FLUCTUATE_EVERY)
        epsilon = 1  # not a constant, going to be decayed
    else:
        EPSILON_DECAY = MAX_EPSILON - (MAX_EPSILON / (0.8 * EPISODES))
        epsilon = 1  # not a constant, going to be decayed

    # Initialize some variables:
    best_average = -100
    best_score = -100

    # Epsilon Conditional Constantation (ECC):
    ECC_Enabled = m["ECC_Settings"]["ECC_Enabled"]
    avg_reward_info = [
        [1, best_average, epsilon]]  # [[episode1, reward1 , epsilon1] ... [episode_n, reward_n , epsilon_n]]
    max_reward_info = [[1, best_score, epsilon]]
    if ECC_Enabled: MAX_EPS_NO_INC = m["ECC_Settings"][
        "MAX_EPS_NO_INC"]  # Maximum number of episodes without any increment in reward average
    eps_no_inc_counter = 0  # Counts episodes with no increment in reward

    # For stats
    ep_rewards = [best_average]

    env = Environment(HUMAN)
    env.MOVE_WALL_EVERY = 1  # Every how many frames the wall moves.

    agent = DQNAgent(f"M{i}", env, m["conv_list"], m["dense_list"], m["util_list"])
    MODEL_NAME = agent.name

    best_weights = [agent.model.get_weights()]

    # Uncomment these two lines if you want to show preview on your screen
    WINDOW = pygame.display.set_mode((env.WINDOW_WIDTH, env.WINDOW_HEIGHT))
    clock = pygame.time.Clock()

    # Iterate over episodes
    for episode in tqdm(range(1, EPISODES + 1), ascii=True, unit='episodes'):
        if m["best_only"]: agent.model.set_weights(best_weights[0])
        # agent.target_model.set_weights(best_weights[0])

        score_increased = False
        # Update tensorboard step every episode
        agent.tensorboard.step = episode

        # Restarting episode - reset episode reward and step number
        episode_reward = 0
        step = 1
        action = 0
        # Reset environment and get initial state
        current_state = env.reset()
        game_over = env.game_over
        while not game_over:
            # This part stays mostly the same, the change is to query a model for Q values
            if np.random.random() > epsilon:
                # Get action from Q table
                action = np.argmax(agent.get_qs(current_state, env))
            else:
                # Get random action
                action = choice(env.ACTION_SPACE)

            new_state, reward, game_over, score_increased = env.step(action, score_increased)

            # Transform new continuous state to new discrete state and count reward
            episode_reward += reward

            # Uncomment the next block if you want to show preview on your screen
            pygame.display.set_caption("Game")
            if SHOW_PREVIEW and not episode % SHOW_EVERY:
                clock.tick(27)
                env.render(score_increased, WINDOW)

            # Every step we update replay memory and train main network
            agent.update_replay_memory((current_state, action, reward, new_state, game_over))
            agent.train(game_over, MINIBATCH_SIZE, env)

            current_state = new_state
            step += 1

        if ECC_Enabled: eps_no_inc_counter += 1
        # Append episode reward to a list and log stats (every given number of episodes)
        ep_rewards.append(episode_reward)

        if not episode % AGGREGATE_STATS_EVERY:
            average_reward = sum(ep_rewards[-AGGREGATE_STATS_EVERY:]) / len(ep_rewards[-AGGREGATE_STATS_EVERY:])
            min_reward = min(ep_rewards[-AGGREGATE_STATS_EVERY:])
            max_reward = max(ep_rewards[-AGGREGATE_STATS_EVERY:])
            agent.tensorboard.update_stats(reward_avg=average_reward, reward_min=min_reward, reward_max=max_reward,
                                           epsilon=epsilon)

            # Save models, but only when avg reward is greater or equal a set value
            if not episode % SAVE_MODEL_EVERY:
                # Save Agent :
                _ = save_model_and_weights(agent, episode)

            if average_reward > best_average:
                best_average = average_reward
                # update ECC variables:
                avg_reward_info.append([episode, best_average, epsilon])
                eps_no_inc_counter = 0
                # Save Agent :
                best_weights[0] = save_model_and_weights(agent, episode)

            if ECC_Enabled and eps_no_inc_counter >= MAX_EPS_NO_INC:
                epsilon = avg_reward_info[-1][2]  # Get epsilon value of the last best reward
                eps_no_inc_counter = 0

        if episode_reward > best_score:
            try:
                best_score = episode_reward
                max_reward_info.append([episode, best_score, epsilon])

                # Save Agent :
                best_weights[0] = save_model_and_weights(agent, MODEL_NAME, episode, max_reward, average_reward,
                                                         min_reward)

            except:
                pass

        # Decay epsilon
        if epsilon > MIN_EPSILON:
            epsilon *= EPSILON_DECAY
            epsilon = max(MIN_EPSILON, epsilon)

        # Epsilon Fluctuation:
        if EF_Enabled:
            if not episode % FLUCTUATE_EVERY:
                epsilon = MAX_EPSILON

    endTime = time.time()
    total_train_time_sec = round((endTime - startTime))
    total_train_time_min = round((endTime - startTime) / 60, 2)
    time_per_episode_sec = round((total_train_time_sec) / EPISODES, 3)

    # Get Average reward:
    average_reward = round(sum(ep_rewards) / len(ep_rewards), 2)

    # Update Results DataFrames:
    res = res.append({"Model Name": MODEL_NAME, "Convolution Layers": m["conv_list"], "Dense Layers": m["dense_list"],
                      "Batch Size": m["MINIBATCH_SIZE"], "ECC": m["ECC_Settings"], "EF": m["EF_Settings"],
                      "Best Only": m["best_only"], "Average Reward": average_reward,
                      "Best Average": avg_reward_info[-1][1], "Epsilon 4 Best Average": avg_reward_info[-1][2],
                      "Best Average On": avg_reward_info[-1][0], "Max Reward": max_reward_info[-1][1],
                      "Epsilon 4 Max Reward": max_reward_info[-1][2], "Max Reward On": max_reward_info[-1][0],
                      "Total Training Time (min)": total_train_time_min, "Time Per Episode (sec)": time_per_episode_sec}
                     , ignore_index=True)
    res = res.sort_values(by='Best Average')
    avg_df = pd.DataFrame(data=avg_reward_info, columns=["Episode", "Average Reward", "Epsilon"])
    max_df = pd.DataFrame(data=max_reward_info, columns=["Episode", "Max Reward", "Epsilon"])

    # Save dataFrames
    res.to_csv(f"{PATH}results/Results.csv")
    avg_df.to_csv(f"{PATH}results/{EPISODES}-Results-Avg.csv")
    max_df.to_csv(f"{PATH}results/{EPISODES}-Results-Max.csv")

TendTime = time.time()
######################################################################################
print(f"Training took {round((TendTime - TstartTime) / 60)} Minutes ")
print(f"Training took {round((TendTime - TstartTime) / 3600)} Hours ")
######################################################################################
