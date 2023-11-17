def find_largest_product(liste) -> (int,int,int,int,int):
    ROWS = len(liste)
    COLS = len(liste[1])
    start_x = 0
    start_y = 0
    end_x = 0
    end_y = 0
    topscore = 0
    for row in range(ROWS):
        for col in range(COLS):
            # recht
            # abe
            if row < ROWS - 3:
                score = liste[row][col] * liste[row + 1][col] * liste[row + 2][col] * liste[row + 3][col]
                if score > topscore:
                    topscore = score
                    start_y = col
                    start_x = row
                    end_y = col
                    end_x = row +3
            if col < COLS - 3:
                score = liste[row][col] * liste[row][col + 1] * liste[row][col + 2] * liste[row][col + 3]
                if score > topscore:
                    topscore = score
                    start_y = col
                    start_x = row
                    end_y = col +3
                    end_x = row
            # quer abe
            if row < ROWS - 3 and col < COLS - 3:
                score = liste[row][col] * liste[row + 1][col + 1] * liste[row + 2][col + 2] * liste[row + 3][col + 3]
                if score > topscore:
                    topscore = score
                    start_y = col
                    start_x = row
                    end_y = col + 3
                    end_x = row + 3

            # Quer ufe
            if row >= 3 and col < COLS - 3:
                score = liste[row][col] * liste[row - 1][col + 1] * liste[row - 2][col + 2] * liste[row - 3][col + 3]
                if score > topscore:
                    topscore = score
                    end_y = col
                    end_x = row
                    start_y = col + 3
                    start_x = row - 3
    return (topscore, ((start_x, start_y), (end_x, end_y)))