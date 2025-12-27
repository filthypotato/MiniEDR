#include "Core/ProcessInfo.h"
#include <iostream>
#include <thread>
#include <chrono>

int main()
{
	std::cout << "MiniEDR - Process Monitor\n";
	std::cout << "========================\n\n";
	std::cout << "PID      | Process Name                  | Timestamp            | Executable Path\n";
	std::cout << "---------|-------------------------------|----------------------|----------------\n";
	
	// Main monitoring loop
	while (true) {
		// Clear screen (optional - comment out if you want to see history)
		// std::cout << "\033[2J\033[1;1H";
		
		std::vector<Core::ProcessInfo> processes = Core::ProcessMonitor::GetProcesses();
		
		std::cout << "\n=== Process Scan - " << processes.size() << " processes found ===\n";
		
		for (const auto& process : processes) {
			Core::ProcessMonitor::PrintProcess(process);
		}
		
		std::cout << "\n=== End of scan ===\n";
		std::cout << "Scanning again in 5 seconds... (Ctrl+C to exit)\n\n";
		
		// Wait 5 seconds before next scan
		std::this_thread::sleep_for(std::chrono::seconds(5));
	}
	
	return 0;
}
