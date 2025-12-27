#include "ProcessInfo.h"

#include <fstream>
#include <sstream>
#include <filesystem>
#include <iostream>
#include <iomanip>
#include <ctime>

namespace Core {

	std::vector<ProcessInfo> ProcessMonitor::GetProcesses() {
		std::vector<ProcessInfo> processes;
		
		// Iterate through /proc directory
		for (const auto& entry : std::filesystem::directory_iterator("/proc")) {
			if (!entry.is_directory()) {
				continue;
			}
			
			std::string dirName = entry.path().filename().string();
			
			// Check if directory name is a number (PID)
			bool isNumeric = true;
			for (char c : dirName) {
				if (!std::isdigit(c)) {
					isNumeric = false;
					break;
				}
			}
			
			if (!isNumeric) {
				continue;
			}
			
			int pid = std::stoi(dirName);
			
			try {
				ProcessInfo info = GetProcess(pid);
				if (!info.exePath.empty()) {
					processes.push_back(info);
				}
			} catch (...) {
				// Process might have terminated, skip it
				continue;
			}
		}
		
		return processes;
	}

	ProcessInfo ProcessMonitor::GetProcess(int pid) {
		ProcessInfo info;
		info.pid = pid;
		info.timestamp = std::chrono::system_clock::now();
		
		// Get executable path from /proc/[pid]/exe symlink
		std::string exeLink = "/proc/" + std::to_string(pid) + "/exe";
		try {
			if (std::filesystem::exists(exeLink)) {
				info.exePath = std::filesystem::read_symlink(exeLink).string();
			}
		} catch (...) {
			// Can't read symlink (process might have terminated or permission issue)
		}
		
		// Get process name from /proc/[pid]/comm
		std::string commPath = "/proc/" + std::to_string(pid) + "/comm";
		std::ifstream commFile(commPath);
		if (commFile.is_open()) {
			std::getline(commFile, info.name);
			commFile.close();
		}
		
		// If name is empty, try to get it from exePath
		if (info.name.empty() && !info.exePath.empty()) {
			info.name = std::filesystem::path(info.exePath).filename().string();
		}
		
		return info;
	}

	void ProcessMonitor::PrintProcess(const ProcessInfo& process) {
		// Convert timestamp to readable format
		auto timeT = std::chrono::system_clock::to_time_t(process.timestamp);
		std::tm* timeInfo = std::localtime(&timeT);
		
		std::cout << std::setfill(' ') << std::setw(8) << process.pid << " | "
		          << std::setw(30) << std::left << process.name << " | "
		          << std::put_time(timeInfo, "%Y-%m-%d %H:%M:%S") << " | "
		          << process.exePath << std::endl;
	}

}

