""" 
This Script automatically create a virtual environment, install the requirements and setup the VSCode settings
For this to work, this file should be on the root directory of the project.
NOTE: This only work for Windows. Will add code for Mac, Linux when needed.
"""

import os
import json
import time
import venv
import shutil

def create_venv(base_path, venv_folder_name):
    path = os.path.join(base_path,venv_folder_name)
    builder = venv.EnvBuilder(with_pip=True)
    builder.create(path)
    print(f"Successfully created {path} !!!")
    
def delete_folder(base_path, folder_name):
    path = os.path.join(base_path, folder_name)
    
    if os.path.exists(path):
        try:
            shutil.rmtree(path)
            print(f"Successfully deleted folder {path}")
        except Exception as e:
            raise Exception(f"An error occurred while deleting '{path}'. MANUALLY DELETE THIS FOLDER THEN RE-RUN THE SCRIPT")
        
    
def wait_until_file_exists(file_path, timeout_seconds):
    start_time = time.time()

    while not os.path.exists(file_path):
        if time.time() - start_time > timeout_seconds:
            print("Timeout reached. File did not appear.")
            return
        print(f"Waiting until {file_path} exists !!!")
        time.sleep(1)  # Wait for 1 second before checking again
    
    print(f"File {file_path} exists !!!")
    
def create_vs_code_settings(base_path: str, venv_folder_name):
    python_exe_path = os.path.join(base_path,venv_folder_name,"Scripts","python.exe")

    robot_lang_server_py = python_exe_path
    if "\\" in robot_lang_server_py:
        robot_lang_server_py = robot_lang_server_py.replace("\\","\\")
    elif "/" in python_exe_path:
        robot_lang_server_py = robot_lang_server_py.replace("/","\\")
        
    robot_py = base_path
    if "\\" in robot_py:
        robot_py = robot_py.replace("\\","/")
        
    terminal_windows = base_path
    if "\\" in terminal_windows:
        terminal_windows = terminal_windows.replace("\\","\\")
        
    vscode_settings = {
        "robot.language-server.python": robot_lang_server_py,
        "robot.pythonpath": [robot_py],
        "terminal.integrated.env.windows": {
            "PYTHONPATH": terminal_windows
        }
    }
    
    vscode_directory = ".vscode"
    vscode_folder_path = os.path.join(base_path, vscode_directory)
    settings_file_path = os.path.join(vscode_folder_path, "settings.json")

    if not os.path.exists(vscode_folder_path):
        os.makedirs(vscode_folder_path)

    with open(settings_file_path, "w") as settings_file:
        json.dump(vscode_settings, settings_file, indent=4)
        
    print(f"Successfully created {settings_file_path} !!!")
        
def setup_workstation():
    os.system("deactivate")
    
    base_path = os.getcwd()
    
    venv_fn = "venv"
    dot_venv_fn = ".venv"
    dot_vs_code_fn = ".vscode"
    
    delete_folder(base_path, venv_fn)
    delete_folder(base_path,dot_venv_fn)
    delete_folder(base_path, dot_vs_code_fn)
    
    create_venv(base_path=base_path, venv_folder_name=dot_venv_fn)
    
    activate_path = os.path.join(base_path, dot_venv_fn,"Scripts","activate")
    wait_until_file_exists(activate_path, 120)
    commands = [activate_path, "pip install -r requirements.txt"]
    os.system(" && ".join(commands))
    
    create_vs_code_settings(base_path,".venv")
    print(f"DONE SETTING UP WORK STATION. PLEASE DOUBLE CHECK THE CONTENT OF {dot_venv_fn} and {dot_vs_code_fn} folders !!!")
    
setup_workstation()





   

