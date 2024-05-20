from pprint import pprint
from pathlib import Path


def patch_config(config_folder: Path, dry_run: bool = True):
    config_anchor = "## config/"
    with open("README.md", "r", encoding="utf-8") as f:
        readme = f.read()
    config_start = readme.find(config_anchor)
    config_end = readme.find("\n## ", config_start+1)
    config = readme[config_start:config_end]
    config_lines = config.splitlines()
    replace_dict: dict[str, list] = {}
    append_dict: dict[str, list] = {}
    for num, line in enumerate(config_lines):
        if line.startswith("### InGameInfoXML/InGameInfo.xml"):
            append_list = [[]]
            path_to_file = line[4:]
            add_num = 5
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
                    add_num += 1
                    if not config_lines[num+add_num].startswith("```xml"):
                        break
                    continue
                line_buffer += next_line + "\n"
            append_dict[path_to_file] = append_list
        elif line.startswith("### "):
            replace_list = [[]]
            path_to_file = line[4:]
            add_num = 5

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
            filedata = (config_folder / path).read_text()
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
            (config_folder / path).write_text(filedata)
    for path, value in append_dict.items():
        try:
            filedata = (config_folder / path).read_text()
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
    print("mods patching not implemented yet, just copy files from `mods` folder to your mods folder and follow instructions in `README.md` mod section")


def patch_resourcepacks(resourcepacks_folder: Path):
    print("resourcepacks patching not implemented yet, just copy files from `resourcepacks` folder to your resourcepacks folder")


def main(minecraft_home: Path, dry_run: bool = True):
    patch_config(minecraft_home / "config", dry_run)
    patch_mods(minecraft_home / "mods")
    patch_resourcepacks(minecraft_home / "resourcepacks")
    print("copy journeymap/config/ and content of local .minecraft/ folder to instance .minecraft/ folder")
    print("")
    print("to sync data check #TODO/Sync section in README.md")


if __name__ == "__main__":
    TARGET_VERSION = "2.6.0"
    DEFAULT_PATH = rf"C:\Users\Admin\scoop\apps\prismlauncher\current\instances\GTNH-{TARGET_VERSION}\.minecraft"
    print(f"GTNH patcher target version: {TARGET_VERSION}")
    input_path = input(f"Enter path to your .minecraft folder: ({DEFAULT_PATH})\n>>> ") or DEFAULT_PATH
    main_dry_run = input("Dry run? (Y/n)\n>>> ").lower() != "n"
    main_minecraft_home = Path(input_path)
    main(main_minecraft_home, main_dry_run)
