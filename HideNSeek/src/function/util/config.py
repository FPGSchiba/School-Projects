import yaml
import os

project_root_name = "HideNSeek"

while project_root_name != os.path.split(os.getcwd())[-1]:
    os.chdir("..")

project_dir = os.getcwd()
data_dir = os.path.join(os.getcwd(), "Data")
str_data = "{data-dir}"


class Maps:
    def __init__(self, data):
        self.city = str(data["files"]["maps"]["city"]).replace(str_data, data_dir)
        self.labyrinth = str(data["files"]["maps"]["labyrinth"]).replace(str_data, data_dir)
        self.test = str(data["files"]["maps"]["test"]).replace(str_data, data_dir)


class Files:
    def __init__(self, data):
        self.maps = Maps(data)
        self.model = str(data["files"]["model"]).replace("{project-dir}", project_dir)


class Config:
    def __init__(self):
        with open(data_dir + "/config.yaml", "r+", encoding="UTF-8") as config_file:
            self.data = yaml.load(config_file, yaml.FullLoader)
        self.files = Files(self.data)