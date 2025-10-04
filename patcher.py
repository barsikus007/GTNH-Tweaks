import shutil
from pathlib import Path
from pprint import pprint


def parse_md(md_text: str, level=1) -> dict | str:
    output = {}
    section_end = 0
    while section_end != -1:
        section_anchor = f"{'' if section_end == 0 else '\n'}{'#'*level} "
        section_start = md_text.find(section_anchor, section_end)
        section_name_start = section_start + len(section_anchor)
        section_name_end = md_text.find("\n", section_name_start)
        section_name = md_text[section_name_start:section_name_end]
        section_end = md_text.find(f"\n{'#'*level} ", section_start + 1)

        if section_start == -1:
            break
        output[section_name] = parse_md(
            md_text[section_name_end : section_end if section_end != -1 else None].strip(), level=level + 1
        )

    return output or md_text.strip()


def parse_config(config: dict[str, str]) -> tuple[dict[str, list], dict[str, list]]:
    replace_dict: dict[str, list] = {}
    append_dict: dict[str, list] = {}
    for section in config:
        config_section_lines = config[section].splitlines()
        if section == "InGameInfoXML/InGameInfo.xml":
            append_list = [[]]
            add_num = 3
            line_buffer = ""

            while True:
                next_line = config_section_lines[add_num]
                add_num += 1
                if next_line.startswith("```xml"):
                    continue
                if next_line.startswith("```"):
                    if len(append_list[-1]) == 2:
                        append_list.append([])
                    append_list[-1].append(line_buffer)
                    line_buffer = ""
                    add_num += 1
                    try:
                        if not config_section_lines[add_num].startswith("```xml"):
                            break
                    except IndexError:
                        break
                    continue
                line_buffer += next_line + "\n"
            append_dict[section] = append_list
        else:
            replace_list = [[]]
            add_num = 3

            while True:
                next_line = config_section_lines[add_num]
                add_num += 1
                if next_line.startswith("```"):
                    break
                if len(replace_list[-1]) == 2:
                    replace_list.append([])
                replace_list[-1].append(next_line)
            replace_dict[section] = replace_list
    return replace_dict, append_dict


def patch_config(config_folder: Path, config: dict[str, str], dry_run: bool = True):
    replace_dict, append_dict = parse_config(config)
    print(f"Patching {config_folder=}")
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

        to_replace = [_ for _ in value if filedata.find(f"{_[0]}\n") != -1]
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
            (config_folder / path).write_text(filedata)


def patch_mods(mods_folder: Path, mods: dict[str, str], dry_run: bool = True):
    if not (mods_folder / mods["Remove"]).exists():
        print("Mods seems to be patched")
        return
    print(f"Removing {mods['Remove']}")
    if not dry_run:
        (mods_folder / mods["Remove"]).unlink()
    for mod in Path("mods/").glob("*"):
        print(f"Copying {mod} to {mods_folder}")
        if not dry_run:
            shutil.copy(mod, mods_folder / mod.name)


def patch_resourcepacks(resourcepacks_folder: Path):
    print(
        "resourcepacks patching not implemented yet, just copy files from `resourcepacks` folder to your resourcepacks folder"
    )


def main(minecraft_home: Path, *, dry_run: bool = True):
    md_file: dict = parse_md(Path("README.md").read_text(encoding="utf-8"))["GTNH Tweaks"]  # type: ignore
    patch_config(minecraft_home / "config", md_file["config/"], dry_run)
    print()
    patch_config(minecraft_home / "serverutilities", md_file["serverutilities/"], dry_run)
    print()
    patch_mods(minecraft_home / "mods", md_file["mods/"], dry_run)
    print()
    patch_resourcepacks(minecraft_home / "resourcepacks")
    print()
    print("copy journeymap/config/ and content of local .minecraft/ folder to instance .minecraft/ folder")
    print("")
    print("to sync data check ## TODO/Sync section in README.md")


if __name__ == "__main__":
    TARGET_VERSION = "2.8.0"
    DEFAULT_PATH = rf"C:\Users\Admin\scoop\apps\prismlauncher\current\instances\GTNH-{TARGET_VERSION}\.minecraft"
    print(f"GTNH patcher target version: {TARGET_VERSION}")
    input_path = input(f"Enter path to GTNH .minecraft folder: ({DEFAULT_PATH})\n>>> ") or DEFAULT_PATH
    main_dry_run = input("Dry run? (Y/n)\n>>> ").lower() != "n"
    main_minecraft_home = Path(input_path)
    main(main_minecraft_home, dry_run=main_dry_run)
