#include "Logger.h"

LoggerLevel Logger::globalLevel = LoggerLevel::Error;

bool operator<(LoggerLevel lhs, LoggerLevel rhs)
{
    return (static_cast<int>(lhs) < static_cast<int>(rhs));
}

bool operator>(LoggerLevel lhs, LoggerLevel rhs)
{
    return rhs < lhs;
}

bool operator<=(LoggerLevel lhs, LoggerLevel rhs)
{
    return !(lhs > rhs); 
}

bool operator>=(LoggerLevel lhs, LoggerLevel rhs)
{
    return !(lhs < rhs); 
}

bool operator==(LoggerLevel lhs, LoggerLevel rhs)
{
    return (static_cast<int>(lhs) == static_cast<int>(rhs));
}

bool operator!=(LoggerLevel lhs, LoggerLevel rhs)
{
    return !(lhs == rhs); 
}

std::ostream& operator<<(std::ostream& os, LoggerLevel ll)
{
    switch(ll)
    {
        case LoggerLevel::Debug:
            os << "DEBUG : ";
            break;
        case LoggerLevel::Warning:
            os << "WARNING : ";
            break;
        case LoggerLevel::Error:
            os << "ERROR : ";
            break;
    }

    return os;
}


Logger::Logger(const std::string& n) 
: 
    name(n), 
    level(LoggerLevel::Error) 
{
}

Logger& Logger::operator()(const LoggerLevel& l)
{
    if (l != LoggerLevel::None)
        level = l;
    return *this;
}
