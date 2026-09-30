#include <iostream>
#include <string>
#include <vector>

int main() {
    std::vector<std::string> tasks;

    while (true) {
        std::cout << "1. Add task\n";
        std::cout << "2. View tasks\n";
        std::cout << "3. Quit\n";

        std::string menuChoice;
        if (!std::getline(std::cin, menuChoice)) {
            break;
        }

        if (menuChoice == "1") {
            std::cout << "Enter task: ";

            std::string task;
            if (!std::getline(std::cin, task)) {
                break;
            }

            if (task.empty()) {
                std::cout << "Task cannot be empty.\n";
            } else {
                tasks.push_back(task);
                std::cout << "Task added.\n";
            }
        } else if (menuChoice == "2") {
            if (tasks.empty()) {
                std::cout << "No tasks yet.\n";
            } else {
                for (std::size_t index = 0; index < tasks.size(); ++index) {
                    std::cout << index + 1 << ". " << tasks[index] << '\n';
                }
            }
        } else if (menuChoice == "3") {
            break;
        } else {
            std::cout << "Invalid choice.\n";
        }
    }

    return 0;
}
