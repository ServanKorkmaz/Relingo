import { motion } from 'framer-motion';
import { Flame } from 'lucide-react';
import { useQuery } from '@tanstack/react-query';
import { getStreakLog } from '../db/queries';

interface StreakCalendarProps {
  streak: number;
  userId?: string;
}

export default function StreakCalendar({ streak, userId }: StreakCalendarProps) {
  // Fetch actual streak log data
  const { data: streakLogData = [] } = useQuery({
    queryKey: ['streak-log', userId],
    queryFn: () => userId ? getStreakLog(userId, 28) : Promise.resolve([]),
    enabled: !!userId,
  });

  // Create a Set of active dates for O(1) lookup
  const activeDates = new Set(streakLogData.map(entry => entry.date));

  // Generate last 28 days
  const generateDays = () => {
    const days = [];
    const today = new Date();
    
    for (let i = 27; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(date.getDate() - i);
      
      const dateString = date.toISOString().split('T')[0];
      const isActive = activeDates.has(dateString);
      const dayName = date.toLocaleDateString('no', { weekday: 'short' });
      const dayNumber = date.getDate();
      
      days.push({
        date: dayNumber,
        dayName: dayName.charAt(0).toUpperCase(),
        isActive,
        isToday: i === 0,
      });
    }
    
    return days;
  };

  const days = generateDays();
  const weeks = [];
  for (let i = 0; i < days.length; i += 7) {
    weeks.push(days.slice(i, i + 7));
  }

  return (
    <div className="bg-gradient-to-br from-orange-50 to-red-50 rounded-2xl p-6 border border-orange-100">
      <div className="flex items-center gap-2 mb-4">
        <Flame className="w-5 h-5 text-orange-600" />
        <h3 className="font-bold text-lg text-gray-900">Aktivitetskalender</h3>
      </div>

      {/* Day Labels */}
      <div className="grid grid-cols-7 gap-2 mb-2">
        {['M', 'T', 'O', 'T', 'F', 'L', 'S'].map((day, i) => (
          <div key={i} className="text-center text-xs font-medium text-gray-500">
            {day}
          </div>
        ))}
      </div>

      {/* Calendar Grid */}
      <div className="space-y-2">
        {weeks.map((week, weekIndex) => (
          <div key={weekIndex} className="grid grid-cols-7 gap-2">
            {week.map((day, dayIndex) => (
              <motion.div
                key={dayIndex}
                initial={{ scale: 0, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ delay: (weekIndex * 7 + dayIndex) * 0.02 }}
                className={`
                  aspect-square rounded-lg flex items-center justify-center text-xs font-semibold
                  transition-all duration-200 cursor-default
                  ${day.isToday
                    ? 'bg-gradient-to-br from-brand to-brand-dark text-white shadow-md ring-2 ring-brand/50'
                    : day.isActive
                    ? 'bg-gradient-to-br from-orange-400 to-orange-500 text-white shadow-sm hover:shadow-md'
                    : 'bg-white text-gray-400 hover:bg-gray-50'
                  }
                `}
                title={day.isActive ? 'Aktiv dag' : 'Ingen aktivitet'}
              >
                {day.isActive && !day.isToday && (
                  <Flame className="w-3 h-3" />
                )}
                {day.isToday && (
                  <span className="text-sm">🔥</span>
                )}
              </motion.div>
            ))}
          </div>
        ))}
      </div>

      {/* Legend */}
      <div className="flex items-center justify-center gap-4 mt-4 text-xs text-gray-600">
        <div className="flex items-center gap-1.5">
          <div className="w-4 h-4 bg-gradient-to-br from-orange-400 to-orange-500 rounded"></div>
          <span>Aktiv</span>
        </div>
        <div className="flex items-center gap-1.5">
          <div className="w-4 h-4 bg-white border border-gray-200 rounded"></div>
          <span>Inaktiv</span>
        </div>
        <div className="flex items-center gap-1.5">
          <div className="w-4 h-4 bg-gradient-to-br from-brand to-brand-dark rounded ring-1 ring-brand/50"></div>
          <span>I dag</span>
        </div>
      </div>

      {/* Streak Info */}
      <div className="mt-4 pt-4 border-t border-orange-200">
        <p className="text-center text-sm text-gray-700">
          <span className="font-bold text-orange-600 text-lg">{streak}</span> dagers streak! 🔥
        </p>
        <p className="text-center text-xs text-gray-600 mt-1">
          Hold det gående for å nå nye milepæler!
        </p>
      </div>
    </div>
  );
}

