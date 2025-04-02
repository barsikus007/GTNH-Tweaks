from pathlib import Path


class JourneyMapPatcher:
    def __init__(self, minecraft_home: Path, server_name: str, def_uuid, *, dry_run: bool = True):
        jm_path = minecraft_home / "journeymap" / "data" / "mp"
        self.jm_target_path = jm_path / f"{server_name}_{def_uuid}"
        self.jm_target_glob = {_ for _ in jm_path.glob(f"{server_name}*") if _.is_dir()}
        self.jm_target_glob.discard(self.jm_target_path)
        self.jm_path = jm_path
        self.dry_run = dry_run

    def run(self):
        print(f"Found {len(self.jm_target_glob)} folders to move")
        for _ in self.jm_target_glob:
            self.move_folder_contents(_, self.jm_target_path)

    def remove_folder_if_empty(self, folder: Path):
        if not list(folder.iterdir()):
            print(f"Removing empty folder: {folder.relative_to(self.jm_path)}")
            if not self.dry_run:
                folder.rmdir()

    def create_folder_if_not_exists_and_move(self, file: Path, dest_file: Path):
        if not dest_file.parent.exists():
            print(f"Creating folder: {dest_file.parent.relative_to(self.jm_path)}")
            if not self.dry_run:
                dest_file.parent.mkdir(parents=True)
        print(f"Moving {file.relative_to(self.jm_path)} to {dest_file.parent.relative_to(self.jm_path)}")
        if not self.dry_run:
            try:
                file.rename(dest_file)
            except FileExistsError:
                print(f"\tFile {dest_file.relative_to(self.jm_path)} already exists")
                if file.stat().st_mtime > dest_file.stat().st_mtime:
                    print(f"\t\tOverwriting {dest_file.relative_to(self.jm_path)}")
                    file.replace(dest_file)
                else:
                    print(f"\t\tRemoving {file.relative_to(self.jm_path)} cause it is older than in target directory")
                    file.unlink()

    def move_folder_contents(self, src: Path, dest: Path):
        for file in src.iterdir():
            if file.is_dir():
                self.move_folder_contents(file, dest / file.name)
                continue
            self.create_folder_if_not_exists_and_move(file, dest / file.name)
        self.remove_folder_if_empty(src)
        if src.parent == self.jm_path and src.exists() and list(src.iterdir()):
            print(f"Files left in {src.relative_to(self.jm_path)}")


def main(minecraft_home: Path, server_name: str, *, dry_run: bool = True):
    def_uuid = "d1aab591~568c~4599~945b~0647d0359b38"
    patcher = JourneyMapPatcher(minecraft_home, server_name, def_uuid, dry_run=dry_run)
    patcher.run()


if __name__ == "__main__":
    TARGET_VERSION = "2.7.3"
    DEFAULT_PATH = rf"C:\Users\Admin\scoop\apps\prismlauncher\current\instances\GTNH-{TARGET_VERSION}\.minecraft"
    print("JourneyMap patcher")
    input_path = input(f"Enter path to GTNH .minecraft folder: ({DEFAULT_PATH})\n>>> ") or DEFAULT_PATH
    DEFAULT_SERVER_NAME = "Official~GTNH~Server~1~EU"
    input_server_name = input(f"Enter server name: ({DEFAULT_SERVER_NAME})\n>>> ") or DEFAULT_SERVER_NAME
    main_dry_run = input("Dry run? (Y/n)\n>>> ").lower() != "n"
    main_minecraft_home = Path(input_path)
    main(main_minecraft_home, input_server_name, dry_run=main_dry_run)
