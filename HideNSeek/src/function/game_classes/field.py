from src.function.util.Image2Array import EnvironmentGenerator


class Field:
    def __init__(self, generator: EnvironmentGenerator):
        self.generator = generator
        self.width = self.generator.width
        self.height = self.generator.height
        self.body = self.generator.matrix

    def update_field(self, player):
        try:
            # Put the player on the field:
            if self.body[player.y, player.x] == 0:
                self.body[player.y, player.x] = player.body
                self.body[player.old_y, player.old_x] = 0
        except:
            pass

    def put_hider_on_field(self, hider):
        try:
            if self.body[hider.hider_y, hider.hider_x] == 0:
                self.body[hider.hider_y, hider.hider_x] = hider.material
        except:
            pass
