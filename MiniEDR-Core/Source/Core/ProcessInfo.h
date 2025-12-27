#pragma once

#include <string>
#include <chrono>
#include <vector>

namespace Core {

	struct ProcessInfo {
		int pid;
		std::string exePath;
		std::chrono::system_clock::time_point timestamp;
		std::string name;
	};

	class ProcessMonitor {
	public:
		// Get all running processes
		static std::vector<ProcessInfo> GetProcesses();
		
		// Get a single process by PID
		static ProcessInfo GetProcess(int pid);
		
		// Print process information
		static void PrintProcess(const ProcessInfo& process);
	};

}

