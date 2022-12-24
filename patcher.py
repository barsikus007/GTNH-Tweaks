from pprint import pprint
from pathlib import Path


def patch_config(config_folder: Path, dry_run: bool = True):
    config_anchor = "## config/"
    with open("README.md", "r") as f:
        readme = f.read()
    config_start = readme.find(config_anchor)
    config_end = readme.find("\n## ", config_start+1)
    config = readme[config_start:config_end]
    config_lines = config.splitlines()
    replace_dict = {}
    append_dict = {}
    for num, line in enumerate(config_lines):
        if line.startswith("### InGameInfo.xml"):
            append_list = [[]]
            path_to_file = line[4:]
            add_num = 3
            line_buffer = ""

            while True:
                next_line = config_lines[num+add_num]
                add_num += 1
                if next_line.startswith("```xml"):
                    continue
                if next_line.startswith("```"):
                    if len(append_list[-1]) == 2:
                        append_list.append([])
                    append_list[-1].append(line_buffer)
                    line_buffer = ""
                    if not config_lines[num+add_num].startswith("```xml"):
                        break
                    continue
                line_buffer += next_line + "\n"
            append_dict[path_to_file] = append_list
        elif line.startswith("### "):
            replace_list = [[]]
            path_to_file = line[4:]
            add_num = 3

            while True:
                next_line = config_lines[num+add_num]
                add_num += 1
                if next_line.startswith("```"):
                    break
                if len(replace_list[-1]) == 2:
                    replace_list.append([])
                replace_list[-1].append(next_line)
            replace_dict[path_to_file] = replace_list
    if dry_run:
        print("Parsed replaces:")
        pprint(replace_dict)
        print()
        print("Parsed append:")
        pprint(append_dict)
    for path, value in replace_dict.items():
        try:
            with open(config_folder / path, "r") as f:
                filedata = f.read()
        except FileNotFoundError:
            print(f"File {path} not found")
            continue

        to_replace = [_ for _ in value if filedata.find(f'{_[0]}\n') != -1]
        if not to_replace:
            print(f"Nothing to replace in {path}")
            continue
        print(f"Replacing in {path}")
        for _ in to_replace:
            filedata = filedata.replace(_[0], _[1])
        
        if not dry_run:
            with open(config_folder / path, 'w') as file:
                file.write(filedata)
    for path, value in append_dict.items():
        try:
            with open(config_folder / path, "r") as f:
                filedata = f.read()
        except FileNotFoundError:
            print(f"File {path} not found")
            continue

        to_append = [_ for _ in value if filedata.find(_[1]) == -1]
        if not to_append:
            print(f"Nothing to append in {path}")
            continue
        print(f"Appending in {path}")
        for _ in to_append:
            pos = filedata.find(_[0]) + len(_[0])
            if pos == -1:
                print(f"Can't find `{_[0]}` in {path}")
                continue
            filedata = filedata[:pos] + _[1] + filedata[pos:]
        if not dry_run:
            with open(config_folder / path, 'w') as file:
                file.write(filedata)


def patch_mods(mods_folder: Path):
    pass


def patch_resourcepacks(resourcepacks_folder: Path):
    pass


def main(minecraft_home: Path, dry_run: bool = True):
    patch_config(minecraft_home / "config", dry_run)
    patch_mods(minecraft_home / "mods")
    patch_resourcepacks(minecraft_home / "resourcepacks")
    print("TODO path other files")


if __name__ == "__main__":
    path = input(r"Enter path to your .minecraft folder: (C:\MultiMC\instances\GTNH\.minecraft)""\n>>> ")
    if not path:
        path = r"C:\Users\Admin\Desktop\Gayms\Portable\MultiMC\instances\GTNH\.minecraft"
    dry_run = input("Dry run? (Y/n)\n>>> ").lower() != "n"
    minecraft_home = Path(path)
    main(minecraft_home, dry_run)
