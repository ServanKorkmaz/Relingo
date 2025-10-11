interface LessonPathProps {
  color: string;
}

export default function LessonPath({ color }: LessonPathProps) {
  return (
    <div className="flex justify-center my-2">
      <svg width="4" height="32" viewBox="0 0 4 32" fill="none">
        {/* Dashed path line */}
        <line
          x1="2"
          y1="0"
          x2="2"
          y2="32"
          stroke={color}
          strokeWidth="3"
          strokeDasharray="4 4"
          strokeLinecap="round"
          opacity="0.6"
        />
        {/* Decorative dots */}
        <circle cx="2" cy="8" r="1.5" fill={color} opacity="0.8"/>
        <circle cx="2" cy="16" r="1.5" fill={color} opacity="0.8"/>
        <circle cx="2" cy="24" r="1.5" fill={color} opacity="0.8"/>
      </svg>
    </div>
  );
}
