import subprocess
import sys

def run_tmux_command(command):
    try:
        result = subprocess.check_output(command, shell=True, text=True)
        return result.strip().split('\n')
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {e}")
        return []

def get_windows_list():
    command = "tmux list-windows -F '#{window_index} #{window_name}'"
    return [tuple(line.split(' ')) for line in run_tmux_command(command)]

def get_panes_in_windows_list(window_index):
    command = f"tmux list-panes -t {window_index} -F '#{{pane_index}}'"
    return run_tmux_command(command)

def send_keys_to_tmux(window_index, pane_index, command):
    target = f"{window_index}.{pane_index}" if pane_index is not None else window_index
    command = f"tmux send-keys -t {target} '{command}' C-m"
    subprocess.run(command, shell=True)

def select_window(window_list):
    if not window_list:
        print("No Tmux windows found.")
        return None
    print("Available Tmux windows:")
    for index, (window_index, window_name) in enumerate(window_list):
        print(f"{index + 1}: {window_name}")

    selected_window = int(input("Select a window (enter the number): ")) - 1
    return window_list[selected_window] if 0 <= selected_window < len(window_list) else None

def select_pane(pane_indices):
    if len(pane_indices) == 1:
        return pane_indices[0]

    print(f"Available panes:")
    for index, pane_index in enumerate(pane_indices):
        print(f"{index + 1}: Pane {pane_index}")

    selected_pane = int(input("Select a pane (enter the number): ")) - 1
    return pane_indices[selected_pane] if 0 <= selected_pane < len(pane_indices) else None


def process_args(window_list, user_input):
    parts = user_input.split('.')
    
    if len(parts) == 1:
        # Format: script.py $WINDOW
        window_input = parts[0]
        pane_index = 1  # Always use pane 1
    elif len(parts) == 2:
        # Format: script.py $WINDOW.$PANE
        window_input, pane_index = parts
    else:
        print("Invalid input format.")
        return None, None

    for window_index, window_name in window_list:
        if window_index == window_input or window_name == window_input:
            return window_index, pane_index

    print("Window not found.")
    return None, None

def run_args_passed():
    window_list = get_windows_list()
    window_index, pane_index = process_args(window_list, sys.argv[1])
    
    if window_index is not None:
        command = sys.argv[2]
        send_keys_to_tmux(window_index, pane_index, command)

def prompt_user_input(): 
    # TODO: Make this cleaner
    window_list = get_windows_list()
    selected_window = select_window(window_list)

    if selected_window:
        window_index, _ = selected_window
        pane_indices = get_panes_in_windows_list(window_index)
        selected_pane = select_pane(pane_indices)
    else:
        print("Invalid window selection.")

    if selected_pane:
        command = input("Enter the string to send: ")
        send_keys_to_tmux(window_index, selected_pane, command)
    else:
        print("Invalid pane selection.")



if __name__ == "__main__":
    if(len(sys.argv) > 2): 
        run_args_passed()
    else: 
        prompt_user_input()