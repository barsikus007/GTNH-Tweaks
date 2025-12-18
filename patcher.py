import os
import shutil
from pathlib import Path
from pprint import pprint


def parse_md(md_text: str, level=1) -> dict | str:
    output = {}
    section_end = 0
    while section_end != -1:
        section_anchor = f"{'' if section_end == 0 else '\n'}{'#' * level} "
        section_start = md_text.find(section_anchor, section_end)
        section_name_start = section_start + len(section_anchor)
        section_name_end = md_text.find("\n", section_name_start)
        section_name = md_text[section_name_start:section_name_end]
        section_end = md_text.find(f"\n{'#' * level} ", section_start + 1)

        if section_start == -1:
            break
        output[section_name] = parse_md(
            md_text[section_name_end : section_end if section_end != -1 else None].strip(), level=level + 1
        )

    return output or md_text.strip()


def parse_config(config: dict[str, str]) -> tuple[dict[str, list], dict[str, str]]:
    replace_dict: dict[str, list] = {}
    diff_dict: dict[str, str] = {}
    for section, section_text in config.items():
        config_section_lines = config[section].splitlines()
        if "```diff" in section_text:
            code_block_buffer = []
            is_code_block = False

            for line in config_section_lines:
                if line.startswith("```diff"):
                    is_code_block = True
                    continue
                if line.startswith("```"):
                    is_code_block = False
                if not is_code_block:
                    continue
                code_block_buffer.append(line)
            diff_dict[section] = "\n".join(code_block_buffer)
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
    return replace_dict, diff_dict


def patch_config(config_folder: Path, config: dict[str, str], dry_run: bool = True):
    replace_dict, diff_dict = parse_config(config)
    print(f"Patching {config_folder=}")
    if dry_run:
        print("Parsed replaces:")
        pprint(replace_dict)
        print()
        print("Parsed diffs:")
        pprint(diff_dict.keys())
    for path, diff in replace_dict.items():
        try:
            filedata = (config_folder / path).read_text()
        except FileNotFoundError:
            print(f"File {path} not found")
            continue

        to_replace = [_ for _ in diff if filedata.find(f"{_[0]}\n") != -1]
        if not to_replace:
            print(f"Nothing to replace in {path}")
            continue
        print(f"Replacing in {path}")
        for _ in to_replace:
            filedata = filedata.replace(_[0], _[1])

        if not dry_run:
            (config_folder / path).write_text(filedata)
    for path, diff in diff_dict.items():
        try:
            filedata = (config_folder / path).read_text()
        except FileNotFoundError:
            print(f"File {path} not found")
            continue

        cmd = f"cat <<EOL | patch {(config_folder / path).as_posix()}{' --dry-run' if dry_run else ''}\n{diff}\nEOL"
        print(f"Patching {path=}")
        os.system(cmd)
        print()


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
    TARGET_VERSION = "2.8.3"
    DEFAULT_PATH = rf"C:\Users\Admin\scoop\apps\prismlauncher\current\instances\GTNH-{TARGET_VERSION}\.minecraft"
    DEFAULT_PATH = f"/home/ogurez/.local/share/PrismLauncher/instances/GTNH-{TARGET_VERSION}/.minecraft"
    print(f"GTNH patcher target version: {TARGET_VERSION}")
    input_path = input(f"Enter path to GTNH .minecraft folder: ({DEFAULT_PATH})\n>>> ") or DEFAULT_PATH
    main_dry_run = input("Dry run? (Y/n)\n>>> ").lower() != "n"
    main_minecraft_home = Path(input_path)
    main(main_minecraft_home, dry_run=main_dry_run)
