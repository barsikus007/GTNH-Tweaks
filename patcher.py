from pathlib import Path


def patch_config(config_folder: Path):
    config_anchor = "## config/"
    with open("README.md", "r") as f:
        readme = f.read()
    config_start = readme.find(config_anchor)
    config_end = readme.find("\n## ", config_start+1)
    config = readme[config_start:config_end]
    config_lines = config.splitlines()
    replace_dict = {}
    for num, line in enumerate(config_lines):
        if line.startswith("### InGameInfo.xml"):
            continue
        if line.startswith("### "):
            replace_list = [[]]
            path_to_file = line[4:]
            add_num = 3

            while True:
                lin = config_lines[num+add_num]
                if lin.startswith("```"):
                    break
                if len(replace_list[-1]) == 2:
                    replace_list.append([])
                replace_list[-1].append(lin)
                add_num += 1
            replace_dict[path_to_file] = replace_list
    for path, value in replace_dict.items():
        with open(config_folder / path, "r") as f:
            filedata = f.read()

        to_replace = [_ for _ in value if filedata.find(f'{_[0]}\n') != -1]
        if not to_replace:
            print(f"Nothing to replace in {path}")
            continue
        print(f"Replacing in {path}")
        for _ in to_replace:
            filedata = filedata.replace(_[0], _[1])

        with open(config_folder / path, 'w') as file:
            file.write(filedata)


def patch_mods(mods_folder: Path):
    pass


def patch_resourcepacks(resourcepacks_folder: Path):
    pass


def main(minecraft_home: Path):
    patch_config(minecraft_home / "config")
    patch_mods(minecraft_home / "mods")
    patch_resourcepacks(minecraft_home / "resourcepacks")
    print("TODO path other files")


if __name__ == "__main__":
    path = input(r"Enter path to your .minecraft folder: (C:\MultiMC\instances\GTNH\.minecraft)")
    minecraft_home = Path(path)
    main(minecraft_home)
