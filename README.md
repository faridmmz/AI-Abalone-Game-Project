# AI Abalone Game Project
Welcome to the third and final project from my AI university course! I hope you find this interesting and for any more information on this project and any other one feel free to reach out to me. 

## Table of Contents

- [Project Overview](#project-Overview)
- [Project Requirements](#project-Requirements)
- [Project Components](#project-Components)
- [AI Implementation](#aI-Implementation)
- [Usage](#usage)

## Project Overview
This project implements the classic two-player game Abalone in the Godot engine, along with an AI opponent capable of playing Abalone, a strategic board game where players aim to push their opponent's marbles off the hexagonal board, that uses the Minimax algorithm with alpha-beta pruning, proper evaluation functions, forward pruning, and table transposition to play against itself. Here's an image of the game at the start and after the first move:

![Game at the start image](https://github.com/faridmmz/AI-Abalone-Game-Project/blob/main/README_image.jpg "Real image of the game")

And here's an image of the game when it finishes:

![Game at the end image](https://github.com/faridmmz/AI-Abalone-Game-Project/blob/main/Endgame_image.jpg)

## Project Requirements
### The main requirements of this project include:

- Implementation of the Minimax algorithm to enable the computer to play against itself.
- Addition of alpha-beta pruning to the Minimax algorithm to improve its efficiency.
- Implementation of an appropriate evaluation function to determine when to stop searching a path based on a certain depth.
- Incorporation of forward pruning using the Search Beam method to further optimize the search space.
- Implementation of Table Transposition for managing duplicate game states.

## Project Components
### The project consists of several scripts:

**BoardManager.gd**: This script manages the game board, cell values, and neighbor relationships. It includes functions to initialize the board, check clusters of pieces, and gather statistics about clusters.

**gameAI.gd**: This script represents the AI player. It uses the implemented algorithms to make optimal moves for the computer player during the game. The AI evaluates various game states and calculates the best move to make.

**minimax.gd**: This script defines the `minimax` class, which is used to calculate the minimax value for a given game state using the Minimax algorithm with alpha-beta pruning.

**Move.gd**: The Move class provides functions for checking the legality and executing moves on the game board. It includes methods to check whether a move is valid and execute it accordingly.

**State.gd**:This script defines the `State` class, representing a specific game state. It includes methods for increasing scores and copying the state.

**Successor.gd**:The `Successor` class calculates the successor states for a given game state, which represent possible moves that can be made.

**Visualizer.gd**: The `Visualizer` script manages the visualization of the game board, including drawing the pieces and updating the board's appearance based on the current game state.

## AI Implementation
### Minimax Algorithm
The heart of the AI's decision-making process is the Minimax algorithm. This algorithm enables the AI to explore different game states by simulating possible moves and counter-moves for both players. The AI evaluates these states and selects the move that maximizes its chances of winning while minimizing the opponent's potential gains.

### Alpha-Beta Pruning
To significantly speed up the Minimax algorithm, the AI employs alpha-beta pruning. This optimization technique reduces the number of evaluated game states by eliminating branches that are guaranteed to be suboptimal. Alpha-beta pruning enhances the efficiency of the search process, allowing the AI to explore deeper levels of the game tree.

### Proper Evaluation Function
An essential component of the AI's strategy is the evaluation function. This function assesses the value of a game state from the AI's perspective. It takes into account factors such as piece positions, distance to the center, and potential moves. The evaluation function guides the AI's decision-making process by assigning higher values to more favorable game states.

### Forward Pruning with Search Beam
Forward pruning further accelerates the AI's search by focusing on the most promising moves. The Search Beam method, a form of forward pruning, limits the number of successors considered during the search. This approach narrows down the search space while retaining the potential for discovering optimal moves.

### Table Transposition
To handle duplicate game states efficiently, the AI employs table transposition. This technique involves storing previously evaluated states and their corresponding values in a table. When encountering a previously seen state, the AI can use the stored value to avoid redundant calculations, optimizing the search process.

## Usage
**To experience the AI-enhanced Abalone game, follow these steps:**
- Install the Godot engine if not already installed.
- Open the project using Godot.
- Start the game and observe the AI player making strategic moves.
- Simply watch AI as it competes against itself.