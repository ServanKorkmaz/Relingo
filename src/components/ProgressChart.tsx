import { motion } from 'framer-motion';
import { TrendingUp } from 'lucide-react';
import { useQuery } from '@tanstack/react-query';
import { getDailyXPLog } from '../db/queries';

interface ProgressChartProps {
  xp: number;
  userId?: string;
}

export default function ProgressChart({ xp: _xp, userId }: ProgressChartProps) {
  // Fetch actual daily XP data
  const { data: dailyXPData = [] } = useQuery({
    queryKey: ['daily-xp-log', userId],
    queryFn: () => userId ? getDailyXPLog(userId, 7) : Promise.resolve([]),
    enabled: !!userId,
  });

  // Generate last 7 days of XP with actual data
  const generateChartData = () => {
    const data = [];
    const days = ['Man', 'Tir', 'Ons', 'Tor', 'Fre', 'Lør', 'Søn'];
    const today = new Date();
    
    for (let i = 6; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(date.getDate() - i);
      const dateString = date.toISOString().split('T')[0];
      
      // Find XP for this date
      const dayData = dailyXPData.find(entry => entry.date === dateString);
      const value = dayData?.xp_earned || 0;
      
      data.push({
        day: days[6 - i],
        value: value,
        isToday: i === 0,
      });
    }
    
    return data;
  };

  const chartData = generateChartData();
  const maxValue = Math.max(...chartData.map(d => d.value));

  return (
    <div className="bg-white rounded-2xl p-6 border border-gray-100 shadow-soft">
      <div className="flex items-center gap-2 mb-6">
        <TrendingUp className="w-5 h-5 text-brand" />
        <h3 className="font-bold text-lg text-gray-900">Ukentlig Fremgang</h3>
      </div>

      {/* Chart */}
      <div className="flex items-end justify-between gap-2 h-32 mb-4">
        {chartData.map((item, index) => (
          <div key={index} className="flex-1 flex flex-col items-center gap-2">
            <motion.div
              initial={{ height: 0 }}
              animate={{ height: `${(item.value / maxValue) * 100}%` }}
              transition={{ duration: 0.8, delay: index * 0.1, ease: "easeOut" }}
              className={`
                w-full rounded-t-lg relative group cursor-default
                ${item.isToday
                  ? 'bg-gradient-to-t from-brand to-brand-light shadow-glow'
                  : 'bg-gradient-to-t from-gray-200 to-gray-300 hover:from-brand/30 hover:to-brand/40'
                }
                transition-all duration-200
              `}
            >
              {/* Tooltip on hover */}
              <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-2 py-1 bg-gray-900 text-white text-xs rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">
                {item.value} XP
              </div>
            </motion.div>
            <span className={`text-xs font-medium ${item.isToday ? 'text-brand' : 'text-gray-600'}`}>
              {item.day}
            </span>
          </div>
        ))}
      </div>

      {/* Summary */}
      <div className="pt-4 border-t border-gray-200">
        <div className="flex justify-between items-center">
          <span className="text-sm text-gray-600">Gjennomsnitt</span>
          <span className="text-sm font-bold text-brand">
            {Math.floor(chartData.reduce((sum, d) => sum + d.value, 0) / 7)} XP/dag
          </span>
        </div>
      </div>
    </div>
  );
}

