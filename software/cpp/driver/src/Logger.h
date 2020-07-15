#ifndef _LOGGER_H_
#define _LOGGER_H_

#include <iostream>
#include <string>

// Logger level values
//enum class LoggerLevel { Debug = 10, Warning = 20, Error = 30, None = 40 };
enum class LoggerLevel { Debug, Warning, Error, None };

// Logger level operators
bool operator<(LoggerLevel lhs, LoggerLevel rhs);
bool operator>(LoggerLevel lhs, LoggerLevel rhs);
bool operator<=(LoggerLevel lhs, LoggerLevel rhs);
bool operator>=(LoggerLevel lhs, LoggerLevel rhs);
bool operator==(LoggerLevel lhs, LoggerLevel rhs);
bool operator!=(LoggerLevel lhs, LoggerLevel rhs);

// Operator used to print the level name
std::ostream& operator<<(std::ostream& os, LoggerLevel ll);

// Simple logger class
class Logger
{
public:
    Logger(const std::string& n); // : name(n), level(LoggerLevel::Error) {};

    // Set/Get global log level
    static void        setLevel(const LoggerLevel& l) { globalLevel = l; };
    static LoggerLevel getLevel()                     { return globalLevel; }; 

    // Operator used to log a message on a specific log level
    Logger& operator()(const LoggerLevel& l);

    // Operator to receive a log message
    template <typename T>
    friend Logger& operator<<(Logger& log, const T& msg)
    {
        // Filter the message depending on the message and global log levels
        if (log.level >= globalLevel)
            std::cout << log.level << log.name << " : " << msg << std::endl;

        return log;
    };

private:
    static LoggerLevel globalLevel; // Global log level
    std::string        name;        // Logger instance name
    LoggerLevel        level;       // Message log level
};

#endif
